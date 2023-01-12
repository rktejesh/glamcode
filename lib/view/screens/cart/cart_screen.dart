import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glamcode/blocs/cart_data/cart_data_bloc.dart';
import 'package:glamcode/data/model/packages_model/service.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/custom_divider.dart';
import 'package:glamcode/view/base/error_screen.dart';
import 'package:glamcode/view/base/package_tile.dart';
import 'package:glamcode/view/screens/address/address_screen.dart';
import 'package:glamcode/view/screens/coupon/coupon_screen.dart';

import '../../../blocs/cart/cart_bloc.dart';
import '../../../data/api/api_helper.dart';
import '../../../data/model/address_details_model.dart';
import '../../base/loading_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<AddressDetailsModel?> _future;

  @override
  void initState() {
    _future = DioClient.instance.getAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.connectionState == ConnectionState.done) {
          AddressDetailsModel addressData = AddressDetailsModel();
          if (snapshot.hasData) {
            addressData = snapshot.data!;
            List<AddressDetails> addressList = addressData.addressDetails ?? [];
            AddressDetails? primaryAddressDetails;
            for (var element in addressList) {
              if (element.isPrimary != null && element.isPrimary!) {
                primaryAddressDetails = element;
              }
            }
            return BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoading) {
                  return const LoadingScreen();
                } else if (state is CartLoaded) {
                  Map<ServicePackage, int> cart = state.cart.items;
                  List<ServicePackage> keysList = cart.keys
                      .toList(); // getting all keys of your map into a list
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
                            child: cart.isNotEmpty
                                ? Column(
                                    children: [
                                      const CustomDivider(),
                                      primaryAddressDetails != null
                                          ? ListTile(
                                              tileColor: Colors.white,
                                              title: Text(
                                                primaryAddressDetails
                                                        .addressHeading ??
                                                    "",
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              subtitle: Text(
                                                primaryAddressDetails.street ??
                                                    "",
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              leading: const Icon(
                                                  Icons.location_on_outlined),
                                              trailing: TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const AddressDetailsScreen()));
                                                },
                                                style: ButtonStyle(
                                                  minimumSize:
                                                      MaterialStateProperty.all(
                                                    const Size(0, 0),
                                                  ),
                                                  padding:
                                                      MaterialStateProperty.all(
                                                    const EdgeInsets.all(
                                                      Dimensions
                                                          .PADDING_SIZE_SMALL,
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  "Change",
                                                  style: TextStyle(
                                                    fontSize: Dimensions
                                                        .fontSizeDefault,
                                                  ),
                                                ),
                                              ),
                                              dense: true,
                                              minLeadingWidth: 0,
                                            )
                                          : InkWell(
                                              onTap: () {
                                                Navigator.of(context)
                                                    .pushNamed('/address');
                                              },
                                              child: Container(
                                                color: Colors.white,
                                                padding: const EdgeInsets.all(
                                                    Dimensions
                                                        .PADDING_SIZE_DEFAULT),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(Icons.add),
                                                    Text(
                                                      "Select an address",
                                                      style: TextStyle(
                                                          fontSize: Dimensions
                                                              .fontSizeExtraLarge),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                      const CustomDivider(),
                                      ListView.builder(
                                        key: UniqueKey(),
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: cart.length,
                                        itemBuilder: (context, index) {
                                          return PackageTile(
                                              servicePackage: keysList[index]);
                                        },
                                      ),
                                      const PriceDetails(),
                                    ],
                                  )
                                : SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
                                    child: Center(
                                      child: Text(
                                        "Your Cart is Empty",
                                        style: TextStyle(
                                            fontSize: Dimensions.fontSizeLarge),
                                      ),
                                    ),
                                  ),
                          ),
                          bottomNavigationBar: cart.isNotEmpty
                              ? BottomAppBar(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              "Total Price",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "Rs. ${cartState.cartData.amountToPay}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.all(
                                            Dimensions.PADDING_SIZE_SMALL),
                                        child: TextButton(
                                            style: TextButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xFFA854FC),
                                                minimumSize: const Size(
                                                    double.infinity,
                                                    Dimensions
                                                        .PADDING_SIZE_DEFAULT),
                                                padding: const EdgeInsets
                                                        .symmetric(
                                                    vertical: Dimensions
                                                        .PADDING_SIZE_DEFAULT),
                                                textStyle: TextStyle(
                                                    fontSize: Dimensions
                                                        .fontSizeExtraLarge)),
                                            onPressed: () {
                                              if ((cartState.cartData
                                                          .originalAmount !=
                                                      null) &&
                                                  (cartState
                                                          .cartData.mincheck !=
                                                      null)) {
                                                if (cartState.cartData
                                                        .originalAmount! >=
                                                    cartState
                                                        .cartData.mincheck!) {
                                                  if (primaryAddressDetails !=
                                                      null) {
                                                    Navigator.pushNamed(context, '/booking-data');
                                                    /*Navigator.pushNamed(
                                                        context, '/addons');*/
                                                  } else {
                                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                      content: Text('Please select Address.'),
                                                      duration: Duration(seconds: 1),
                                                    ));
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                                    content: Text('Please add items worth ${cartState.cartData.mincheck} to proceed.'),
                                                    duration: const Duration(seconds: 1),
                                                  ));
                                                }
                                              }
                                            },
                                            child: const Text("Next")),
                                      ))
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                        );
                      } else {
                        return const Scaffold(
                          body: CustomError(),
                        );
                      }
                    },
                  );
                } else {
                  return const Scaffold(
                    body: CustomError(),
                  );
                }
              },
            );
          } else {
            return const CustomError();
          }
        } else {
          return const Scaffold(
            body: CustomError(),
          );
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
                        backgroundColor: const Color(0xFF882EDF),
                        minimumSize: const Size(
                            double.infinity, Dimensions.PADDING_SIZE_LARGE),
                        padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.PADDING_SIZE_DEFAULT),
                        textStyle:
                            TextStyle(fontSize: Dimensions.fontSizeExtraLarge)),
                    child: const Text("Apply Coupon"),
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Rs ${state.cartData.originalAmount}"),
                      const Text("(Inclusive of all taxes)")
                    ],
                  ),
                )
              ]),
              TableRow(
                  children: [
                const Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Text("Coupon Discount"),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: Text("- ${state.cartData.couponDiscount ?? 0}"),
                    ),
                  ],
                )
              ]),
              TableRow(children: [
                const Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Text("Safety & Hygiene Fee"),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: Text("${state.cartData.extraFees}"),
                    ),
                  ],
                )
              ]),
              TableRow(children: [
                const Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Text("Transportation Fee"),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: Text("0"),
                    ),
                  ],
                )
              ]),
              TableRow(children: [
                const Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Text("Total Amount Payable"),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: Text("${state.cartData.amountToPay}"),
                    ),
                  ],
                )
              ]),
            ],
          );
        } else {
          return const CustomError();
        }
      },
    );
  }
}
