import 'package:flutter/material.dart';
import 'package:glamcode/util/dimensions.dart';

class CartCounter extends StatefulWidget {
  final int count;
  const CartCounter({Key? key, required this.count}) : super(key: key);

  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(50, 50, 93, 0.25),
              spreadRadius: -2,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.3),
              spreadRadius: -3,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ]),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
              onTap: () {
                setState(() {
                  if (count > 0) {
                    count--;
                    print(count);
                  }
                });
              },
              child: Padding(
                padding:
                    const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: Icon(
                  Icons.remove,
                  size: Dimensions.fontSizeOverLarge,
                ),
              )),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_SMALL,
                vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3), color: Colors.white),
            child: Text(
              count.toString(),
              style: TextStyle(
                  color: Colors.black, fontSize: Dimensions.fontSizeOverLarge),
            ),
          ),
          InkWell(
              onTap: () {
                setState(() {
                  count++;
                  print(count);
                });
              },
              child: Padding(
                padding:
                    const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: Icon(
                  Icons.add,
                  size: Dimensions.fontSizeOverLarge,
                ),
              )),
        ],
      ),
    );
  }
}
