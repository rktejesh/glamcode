part of 'cart_data_bloc.dart';

@immutable
abstract class CartDataEvent extends Equatable {
  const CartDataEvent();
}

class CartDataStarted extends CartDataEvent {
  @override
  List<Object> get props => [];
}

class CartDataUpdate extends CartDataEvent {
  @override
  List<Object> get props => [];
}
