import 'package:flutter/material.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/golden_text.dart';

import 'cart_counter.dart';

class PackageTile extends StatefulWidget {
  final String src;
  final String title;
  final String newPrice;
  final String oldPrice;
  const PackageTile(
      {Key? key,
      required this.src,
      required this.title,
      required this.newPrice,
      required this.oldPrice})
      : super(key: key);

  @override
  State<PackageTile> createState() => _PackageTileState();
}

class _PackageTileState extends State<PackageTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
        child: Card(
          elevation: 0,
          borderOnForeground: true,
          margin: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding:
                      const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: Dimensions.fontSizeLarge,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: RichText(
                          text: TextSpan(
                            text: "₹${widget.newPrice}   ",
                            style: TextStyle(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Colors.black),
                            children: [
                              WidgetSpan(
                                child: Transform.translate(
                                  offset: const Offset(0.0, -4.0),
                                  child: Text(
                                    "₹${widget.oldPrice}",
                                    style: TextStyle(
                                      fontSize: Dimensions.fontSizeExtraSmall,
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
                              size: Dimensions.fontSizeSmall,
                            ),
                            Text(
                              "  60 Minutes",
                              style:
                                  TextStyle(fontSize: Dimensions.fontSizeSmall),
                            )
                          ],
                        ),
                      ),
                      OutlinedButton(
                        style: ButtonStyle(
                            side: MaterialStateProperty.all(
                                const BorderSide(color: Colors.black)),
                            splashFactory: InkRipple.splashFactory),
                        onPressed: () {
                          Navigator.of(context).pushNamed("/packages-details");
                        },
                        child: Text(
                          "View Details",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.fontSizeLarge),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        clipBehavior: Clip.hardEdge,
                        child: Image.network(widget.src),
                      ),
                    ),
                    const CartCounter(
                      count: 0,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
