import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cart_data_event.dart';
part 'cart_data_state.dart';

class CartDataBloc extends Bloc<CartDataEvent, CartDataState> {
  CartDataBloc() : super(CartDataInitial()) {
    on<CartDataEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
