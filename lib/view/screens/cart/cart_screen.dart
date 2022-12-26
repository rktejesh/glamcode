import 'package:flutter/material.dart';
import 'package:glamcode/data/api/api_helper.dart';
import 'package:glamcode/data/model/my_cart/my_cart.dart';

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
    return FutureBuilder(
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
    );
  }
}
