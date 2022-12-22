import 'package:flutter/material.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/golden_text.dart';

import '../../base/cart_counter.dart';

class PackageInfo extends StatelessWidget {
  const PackageInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Package Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Image.network(
              "https://picsum.photos/250?image=1",
              width: double.infinity,
              fit: BoxFit.cover,
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
                        "Product",
                        style: TextStyle(
                            fontSize: Dimensions.fontSizeOverLarge,
                            fontWeight: FontWeight.w400),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: RichText(
                          text: TextSpan(
                            text: "₹359   ",
                            style: TextStyle(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Colors.black),
                            children: [
                              WidgetSpan(
                                child: Transform.translate(
                                  offset: const Offset(0.0, -4.0),
                                  child: Text(
                                    "₹718",
                                    style: TextStyle(
                                      fontSize: Dimensions.fontSizeSmall,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ),
                              ),
                              const WidgetSpan(
                                alignment: PlaceholderAlignment.bottom,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.PADDING_SIZE_DEFAULT),
                                  child: GoldenText(
                                    text: "  50% Off  ",
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
                              "  60 Minutes",
                              style: TextStyle(
                                  fontSize: Dimensions.fontSizeDefault),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const CartCounter(
                    count: 0,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
