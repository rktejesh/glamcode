import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:glamcode/data/api/api_helper.dart';
import 'package:glamcode/theme/light_theme.dart';
import 'package:glamcode/util/app_constants.dart';
import 'package:glamcode/view/base/loading_screen.dart';
import 'package:glamcode/view/screens/dashboard/dashboard_screen.dart';
import 'package:glamcode/view/screens/location/location_screen.dart';
import 'package:glamcode/view/screens/otp/otp_screen.dart';
import 'package:glamcode/view/screens/packages/package_info.dart';
import 'package:glamcode/view/screens/packages/packages_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/bloc_observer.dart';
import 'data/model/auth.dart';
import 'data/repository/user_repository.dart';
import 'helper/route_helper.dart';
import 'home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  Auth auth = Auth.instance;
  DioClient dioClient = DioClient.instance;
  UserRepository userRepository = UserRepository(auth: auth, dioClient: dioClient);
  runApp(MyApp(
    userRepository: userRepository,
    auth: auth,
    dioClient: dioClient,
  ));
}

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
  UserRepository get userRepository => widget.userRepository;
  Auth get auth => widget.auth;
  DioClient get dioClient => widget.dioClient;
  @override
  void initState() {
    authBloc = AuthBloc(userRepository: userRepository, dioClient: dioClient);
    authBloc.add(AppLoaded());
    super.initState();
    print('building main.dart');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authBloc,
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
          "/packages": (context) => const PackagesScreen(),
          "/packages-details": (context) => const PackageInfo(),
          "/location": (context) => const SelectLocationScreen()
        },
      ),
    );
  }
}
