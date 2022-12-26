
import 'package:flutter/material.dart';
import 'package:glamcode/data/api/api_helper.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'blocs/bloc_observer.dart';
import 'data/model/auth.dart';
import 'data/repository/user_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  Auth auth = Auth.instance;
  DioClient dioClient = DioClient.instance;
  UserRepository userRepository =
      UserRepository(auth: auth, dioClient: dioClient);
  runApp(MyApp(
    userRepository: userRepository,
    auth: auth,
    dioClient: dioClient,
  ));
}