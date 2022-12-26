import 'package:glamcode/data/model/packages_model/service.dart';

import '../api/api_helper.dart';
import '../model/auth.dart';

class ShoppingRepository {
  Auth auth = Auth.instance;
  DioClient dioClient = DioClient.instance;
  ShoppingRepository({required this.auth, required this.dioClient});

/*  Future<Map<ServicePackage, int>> loadCartItems() async {

  }*/
}
