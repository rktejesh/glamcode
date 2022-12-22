import 'package:flutter/material.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/package_tile.dart';

class Packages extends StatefulWidget {
  const Packages({Key? key}) : super(key: key);

  @override
  State<Packages> createState() => _PackagesState();
}

class _PackagesState extends State<Packages> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_DEFAULT),
          child: Text(
            "Packages ",
            style: TextStyle(fontSize: Dimensions.fontSizeExtraLarge),
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return const PackageTile(
              src: "https://picsum.photos/250?image=1",
              title: 'Legs Show Off',
              newPrice: '429',
              oldPrice: '858',
            );
          },
        ),
      ],
    );
  }
}
