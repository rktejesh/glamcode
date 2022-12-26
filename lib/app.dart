import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamcode/blocs/cart/cart_bloc.dart';
import 'package:glamcode/theme/light_theme.dart';
import 'package:glamcode/util/app_constants.dart';
import 'package:glamcode/view/screens/about/about.dart';
import 'package:glamcode/view/screens/address/address_screen.dart';
import 'package:glamcode/view/screens/address/new_address.dart';
import 'package:glamcode/view/screens/dashboard/dashboard_screen.dart';
import 'package:glamcode/view/screens/location/location_screen.dart';
import 'package:glamcode/view/screens/cart/cart_screen.dart';
import 'package:glamcode/view/screens/privacy_policy/privacy_policy_screen.dart';
import 'package:glamcode/view/screens/terms_and_conditions/terms_and_conditions_screen.dart';

import 'blocs/auth/auth_bloc.dart';
import 'data/api/api_helper.dart';
import 'data/model/auth.dart';
import 'data/repository/user_repository.dart';
import 'helper/route_helper.dart';
import 'home.dart';

class MyApp extends StatefulWidget {
  final UserRepository userRepository;
  final Auth auth;
  final DioClient dioClient;
  const MyApp(
      {super.key,
      required this.userRepository,
      required this.auth,
      required this.dioClient});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthBloc authBloc;
  late CartBloc cartBloc;
  UserRepository get userRepository => widget.userRepository;
  Auth get auth => widget.auth;
  DioClient get dioClient => widget.dioClient;
  @override
  void initState() {
    authBloc = AuthBloc(userRepository: userRepository, dioClient: dioClient);
    authBloc.add(AppLoaded());
    cartBloc = CartBloc();
    cartBloc.add(CartStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => authBloc,
        ),
        BlocProvider(
          create: (context) => cartBloc,
        ),
      ],
      child: MaterialApp(
        title: AppConstants.APP_NAME,
        debugShowCheckedModeBanner: false,
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
        ),
        theme: light(color: Colors.white),
/*      theme: themeController.darkTheme
          ? themeController.darkColor == null
              ? dark()
              : dark(color: themeController.darkColor ?? Colors.black54)
          : themeController.lightColor == null
              ? light()
              : light(color: themeController.lightColor ?? Colors.white),*/
        initialRoute: RouteHelper.getInitialRoute(),
        routes: {
          '/': (context) => Home(
                authBloc: authBloc,
              ),
          "/dashboard": (context) => const DashboardScreen(pageIndex: 0),
          "/location": (context) => const SelectLocationScreen(),
          "/cart": (context) => const CartScreen(),
          "/terms": (context) => const TermsConditionsScreen(),
          "/about": (context) => const AboutScreen(),
          "/privacy": (context) => const PrivacyPolicyScreen(),
          "/address": (context) => const AddressDetailsScreen(),
          "/new-address": (context) => const NewAddressScreen()
        },
      ),
    );
  }
}
