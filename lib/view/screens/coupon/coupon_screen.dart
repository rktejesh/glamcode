import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamcode/data/api/api_helper.dart';
import 'package:glamcode/data/model/coupons.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/error_screen.dart';

import '../../../blocs/cart_data/cart_data_bloc.dart';
import '../../base/loading_screen.dart';

class CouponScreen extends StatefulWidget {
  const CouponScreen({Key? key}) : super(key: key);

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  late Future<Coupons?> _future;

  @override
  void initState() {
    _future = DioClient.instance.getCoupons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Apply Coupons"),
        ),
        body: FutureBuilder<Coupons?>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            } else if (snapshot.connectionState == ConnectionState.done) {
              Coupons couponData = const Coupons();
              if (snapshot.hasData) {
                couponData = snapshot.data!;
                List<CouponData> couponsList = couponData.couponData ?? [];
                return BlocBuilder<CartDataBloc, CartDataState>(
                  builder: (context, state) {
                    if(state is CartDataLoading) {
                      return const LoadingScreen();
                    } else if (state is CartDataLoaded) {
                      return ListView.builder(
                          itemCount: couponsList.length,
                          itemBuilder: (context, index) {
                            bool isApplied = state.cartData.couponId == couponsList[index].id;
                            return couponsTile(couponsList[index], isApplied, context);
                          });
                    } else {
                      return const CustomError();
                    }
                  },
                );
              } else {
                return const CustomError();
              }
            } else {
              return const CustomError();
            }
          },
        ));
  }
}

Widget couponsTile(CouponData couponData, bool isApplied, BuildContext context) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            couponsTileText("Coupon  ", couponData.title.toString()),
            couponsTileText(
                "Discount  ",
                couponData.percent == null
                    ? "Rs ${couponData.amount}"
                    : "${couponData.percent}%" " off"),
            couponsTileText("Minimum Purchase Amount  ",
                "Rs ${couponData.minimumPurchaseAmount}"),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE,
              vertical: Dimensions.PADDING_SIZE_SMALL),
          child: TextButton(
            style: isApplied ? ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey)
            ): const ButtonStyle(),
            onPressed: isApplied ? null : () {
              context.read<CartDataBloc>()
                  .add(CartCouponUpdate(couponData));
            },
            child: isApplied ? Text(
              "Applied ${couponData.title.toString()}",
              style: TextStyle(fontSize: Dimensions.fontSizeLarge, color: Colors.white),
            ) : Text(
              "Apply ${couponData.title.toString()}",
              style: TextStyle(fontSize: Dimensions.fontSizeLarge),
            ),
          ),
        )
      ],
    ),
  );
}

Widget couponsTileText(String title, String text) {
  return Padding(
    padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL),
    child: RichText(
      text: TextSpan(
        text: title,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: Dimensions.fontSizeLarge,
            color: Colors.black),
        children: [
          TextSpan(
            text: text,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: Dimensions.fontSizeLarge,
                color: Colors.black),
          )
        ],
      ),
    ),
  );
}
