import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamcode/blocs/cart_data/cart_data_bloc.dart';
import 'package:glamcode/data/model/packages_model/service.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/custom_divider.dart';
import 'package:glamcode/view/base/package_tile.dart';
import 'package:glamcode/view/screens/coupon/coupon_screen.dart';

import '../../../blocs/cart/cart_bloc.dart';
import '../../base/loading_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const LoadingScreen();
        } else if (state is CartLoaded) {
          Map<ServicePackage, int> cart = state.cart.items;
          List<ServicePackage> keysList =
              cart.keys.toList(); // getting all keys of your map into a list
          return BlocBuilder<CartDataBloc, CartDataState>(
            builder: (context, cartState) {
              if (cartState is CartDataLoading) {
                return const LoadingScreen();
              } else if (cartState is CartDataLoaded) {
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
                            padding: const EdgeInsets.all(
                                Dimensions.PADDING_SIZE_DEFAULT),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.add),
                                Text(
                                  "Select an address",
                                  style: TextStyle(
                                      fontSize: Dimensions.fontSizeExtraLarge),
                                )
                              ],
                            ),
                          ),
                        ),
                        const CustomDivider(),
                        ListView.builder(
                          key: UniqueKey(),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cart.length,
                          itemBuilder: (context, index) {
                            return PackageTile(servicePackage: keysList[index]);
                          },
                        ),
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
                            children: [
                              const Text("Total Price"),
                              Text("Rs. ${cartState.cartData.amountToPay}")
                            ],
                          ),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_SMALL),
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  minimumSize: const Size(double.infinity,
                                      Dimensions.PADDING_SIZE_DEFAULT),
                                  padding: const EdgeInsets.symmetric(
                                      vertical:
                                          Dimensions.PADDING_SIZE_DEFAULT),
                                  textStyle: TextStyle(
                                      fontSize: Dimensions.fontSizeExtraLarge)),
                              onPressed: () {},
                              child: const Text("Next")),
                        ))
                      ],
                    ),
                  ),
                );
              } else {
                /// TODO: error
                return const Text("error");
              }
            },
          );
        } else {
          /// TODO: error
          return const Text("error");
        }
      },
    );
  }
}

class PriceDetails extends StatelessWidget {
  const PriceDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartDataBloc, CartDataState>(
      builder: (context, state) {
        if (state is CartDataLoading) {
          return const LoadingScreen();
        } else if (state is CartDataLoaded) {
          return Table(
            children: <TableRow>[
              TableRow(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
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
                        textStyle:
                            TextStyle(fontSize: Dimensions.fontSizeExtraLarge)),
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
                    children: [
                      Text("Rs ${state.cartData.originalAmount}"),
                      const Text("(Inclusive of all taxes)")
                    ],
                  ),
                )
              ]),
              TableRow(children: [
                const Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Text("Coupon Discount"),
                ),
                Padding(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Text("- ${state.cartData.couponDiscount ?? 0}"),
                )
              ]),
              TableRow(children: [
                const Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Text("Safety & Hygiene Fee"),
                ),
                Padding(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Text("${state.cartData.extraFees}"),
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
              TableRow(children: [
                const Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Text("Total Amount Payable"),
                ),
                Padding(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Text("${state.cartData.amountToPay}"),
                )
              ]),
            ],
          );
        } else {
          ///TODO: error screen
          return const Text("error");
        }
      },
    );
  }
}
