import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/cart_data/cart_data_bloc.dart';
import '../../util/dimensions.dart';

class BottomServiceBar extends StatelessWidget {
  const BottomServiceBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartDataBloc, CartDataState>(
      builder: (context, cartState) {
        return BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoaded && cartState is CartDataLoaded) {
              return state.cart.items.isEmpty ? const SizedBox() : ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      color: const Color(0xFF882EDF),
                      child: Text("WELCOME 50 Coupon Unlocked! Use it to save up to 50% on your booking.", overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontSize: Dimensions.fontSizeSmall),),),
                    Container(
                      color: const Color(0xFFAF73E9),
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_SMALL),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${state.cart.items.length} items(s) | ₹${cartState.cartData.originalAmount}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.fontSizeLarge),
                              ),
                              Text(
                                "Extra charges may apply.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimensions.fontSizeExtraSmall),
                              ),
                            ],
                          ),
                          Flexible(
                              child: InkWell(
                                  splashColor: Colors.white,
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/addons');
                                    // Navigator.of(context).pushNamed('/cart');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                                    child: Text(
                                      "Checkout",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: Dimensions.fontSizeExtraLarge,
                                        shadows: const [
                                          Shadow(
                                            offset: Offset(5,5),
                                            blurRadius: 70.0,
                                            color: Colors.black,
                                          ),
                                        ]
                                      ),
                                    ),
                                  )))
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        );
      },
    );
  }
}
