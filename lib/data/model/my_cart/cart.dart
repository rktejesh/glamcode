import 'package:equatable/equatable.dart';
import 'package:glamcode/data/model/packages_model/service.dart';

class Cart extends Equatable {
  const Cart({this.items = const <ServicePackage, int>{}});

  final Map<ServicePackage, int> items;

  num get totalPrice {
    num total = 0;
    items.forEach((key, value) {
      total += key.discountedPrice ?? 0 * value;
    });
    return total;
  }

  @override
  List<Object> get props => [items];
}
