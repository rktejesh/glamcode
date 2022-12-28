import 'package:flutter/material.dart';
import 'package:glamcode/data/api/api_helper.dart';
import 'package:glamcode/data/model/cart_data.dart';
import 'package:glamcode/data/model/my_cart/cart.dart';
import 'package:glamcode/data/repository/cart_data_repository.dart';
import 'package:glamcode/data/repository/shopping_repository.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'blocs/bloc_observer.dart';
import 'data/model/auth.dart';
import 'data/repository/user_repository.dart';

Future<void> main() async {
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  Auth auth = Auth.instance;
  DioClient dioClient = DioClient.instance;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  UserRepository userRepository =
      UserRepository(auth: auth, dioClient: dioClient);
  ShoppingRepository shoppingRepository = ShoppingRepository(
      auth: auth, dioClient: dioClient, sharedPreferences: prefs);
  CartDataRepository cartDataRepository = CartDataRepository(
      auth: auth, dioClient: dioClient, shoppingRepository: shoppingRepository);
  runApp(MyApp(
    userRepository: userRepository,
    auth: auth,
    dioClient: dioClient,
    shoppingRepository: shoppingRepository,
    cartDataRepository: cartDataRepository,
  ));
}
