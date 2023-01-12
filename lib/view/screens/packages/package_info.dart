import 'package:flutter/material.dart';
import 'package:glamcode/data/model/packages_model/service.dart';
import 'package:glamcode/util/convertHtmlToString.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/bottomServiceBar.dart';
import 'package:glamcode/view/base/custom_divider.dart';
import 'package:glamcode/view/base/golden_text.dart';

import '../../base/cart_counter.dart';

class PackageInfo extends StatelessWidget {
  final ServicePackage servicePackage;

  const PackageInfo({Key? key, required this.servicePackage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Package Details",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Hero(
              tag: servicePackage.slug ?? "",
              child: Image.network(
                servicePackage.serviceImageUrl ?? "",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        servicePackage.name ?? "",
                        style: TextStyle(
                            fontSize: Dimensions.fontSizeOverLarge,
                            fontWeight: FontWeight.w400),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: RichText(
                          text: TextSpan(
                            text: "₹${servicePackage.discountedPrice}   ",
                            style: TextStyle(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Colors.black),
                            children: [
                              WidgetSpan(
                                child: Transform.translate(
                                  offset: const Offset(0.0, -4.0),
                                  child: Text(
                                    "₹${servicePackage.price}",
                                    style: TextStyle(
                                      fontSize: Dimensions.fontSizeSmall,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.bottom,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.PADDING_SIZE_DEFAULT),
                                  child: GoldenText(
                                    text: "  ${servicePackage.discount}% Off  ",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: Dimensions.fontSizeDefault,
                            ),
                            Text(
                              "  ${servicePackage.time} Minutes",
                              style: TextStyle(
                                  fontSize: Dimensions.fontSizeDefault),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  CartCounter(
                    servicePackage: servicePackage,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_DEFAULT,
                  right: Dimensions.PADDING_SIZE_DEFAULT,
                  bottom: Dimensions.PADDING_SIZE_DEFAULT),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      convertHtmlToString(servicePackage.description ?? "")
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL),
                              child: Text("\u2022 $e"),
                            ),
                          )
                          .toList(),
                ),
              ),
            ),
            const CustomDivider(),
            Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(
                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: Text(
                        "Benefits",
                        style:
                            TextStyle(fontSize: Dimensions.fontSizeExtraLarge, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Wrap(
                      children: convertHtmlToString(
                              servicePackage.longDescription ?? "")
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL),
                              child: Text("\u2022 $e"),
                            ),
                          )
                          .toList(),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomServiceBar(),
    );
  }
}
