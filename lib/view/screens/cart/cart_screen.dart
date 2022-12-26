import 'package:flutter/material.dart';
import 'package:glamcode/data/api/api_helper.dart';
import 'package:glamcode/data/model/my_cart/my_cart.dart';
import 'package:glamcode/util/app_constants.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/custom_divider.dart';
import 'package:glamcode/view/base/package_tile.dart';
import 'package:glamcode/view/screens/coupon/coupon_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<MyCart?> _future;

  @override
  void initState() {
    _future = DioClient.instance.getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MY CART"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomDivider(),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/address');
              },
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add),
                    Text(
                      "Select an address",
                      style: TextStyle(fontSize: Dimensions.fontSizeExtraLarge),
                    )
                  ],
                ),
              ),
            ),
            const CustomDivider(),
            PackageTile(servicePackage: AppConstants.sampleServicePackage),
            PackageTile(servicePackage: AppConstants.sampleServicePackage),
            PackageTile(servicePackage: AppConstants.sampleServicePackage),
            const PriceDetails(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [Text("Total Price"), Text("Rs 2522")],
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: TextButton(
                  style: TextButton.styleFrom(
                      minimumSize: const Size(
                          double.infinity, Dimensions.PADDING_SIZE_DEFAULT),
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.PADDING_SIZE_DEFAULT),
                      textStyle:
                          TextStyle(fontSize: Dimensions.fontSizeExtraLarge)),
                  onPressed: () {},
                  child: const Text("Next")),
            ))
          ],
        ),
      ),
    );

    /*return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(title: const Text("MY CART"),),
              body: Text(snapshot.data?.productsArray![0].myCartProduct.toString() ?? ""),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );*/
  }
}

class PriceDetails extends StatelessWidget {
  const PriceDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      children: <TableRow>[
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Text(
                "Price Details",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.fontSizeExtraLarge),
              ),
            ),
            /*Container(
              color: Colors.black,
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: const Text(
                "% Apply Coupon",
                style: TextStyle(color: Colors.white),
              ),
            )*/
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CouponScreen(),
                  ),
                );
              },
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  minimumSize: const Size(
                      double.infinity, Dimensions.PADDING_SIZE_LARGE),
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_DEFAULT),
                  textStyle: TextStyle(fontSize: Dimensions.fontSizeExtraLarge)),
              child: const Text("% Apply Coupon"),
            )
          ],
        ),
        TableRow(children: [
          const Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Text("Total Price"),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Column(
              children: const [
                Text("Rs 2472"),
                Text("(Inclusive of all taxes)")
              ],
            ),
          )
        ]),
        const TableRow(children: [
          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Text("Coupon Discount"),
          ),
          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Text("- 0"),
          )
        ]),
        const TableRow(children: [
          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Text("Safety & Hygiene Fee"),
          ),
          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Text("49"),
          )
        ]),
        const TableRow(children: [
          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Text("Transportation Fee"),
          ),
          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Text("0"),
          )
        ]),
        const TableRow(children: [
          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Text("Total Amount Payable"),
          ),
          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Text("2522"),
          )
        ]),
      ],
    );
  }
}
