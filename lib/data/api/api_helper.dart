import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:glamcode/data/model/about.dart';
import 'package:glamcode/data/model/auth.dart';
import 'package:glamcode/data/model/gallery.dart';
import 'package:glamcode/data/model/home_page.dart';
import 'package:glamcode/data/model/location_model.dart';
import 'package:glamcode/data/model/main_categories_model.dart';
import 'package:glamcode/data/model/privacy.dart';
import 'package:glamcode/data/model/terms.dart';
import 'package:glamcode/data/model/user.dart';
import 'package:glamcode/util/app_constants.dart';

class DioClient {
  final Dio _dio = Dio();
  final _baseUrl = 'https://glamcode.in/api';
  final CookieJar cookieJar = CookieJar();

  static final instance = DioClient();

  DioClient() {
    _dio.interceptors
      ..add(TokenInterceptor())
      ..add(DioCacheInterceptor(options: options))
      ..add(CookieManager(cookieJar));
    print(cookieJar.loadForRequest(Uri.parse("https://glamcode.in/")));
  }

/*  Future<Itemmodel?> getItem() async {
    Itemmodel? itemDetails;
    try {
      Response itemDetailsData =
      await _dio.get('$_baseUrl/astro/getProfile');
      itemDetails = Itemmodel.fromJson(itemDetailsData.data["data"]);
    } on DioError catch (e) {
      if (e.response != null) {
      } else {
      }
    }
    return itemDetails;
  }*/

  Future<HomePageModel?> getHomePage() async {
    HomePageModel? homePage;
    try {
      Response homePageData = await _dio.get('$_baseUrl/home');
      homePage = HomePageModel.fromJson(homePageData.data);
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
    }
    return homePage;
  }

  Future<Gallery?> getGallery() async {
    Gallery? gallery;
    try {
      Response galleryData = await _dio.get('$_baseUrl/gallery');
      gallery = Gallery.fromJson(galleryData.data);
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
    }
    return gallery;
  }

  Future<TermsModel?> getTerms() async {
    TermsModel? terms;
    try {
      Response termsData = await _dio.get('$_baseUrl/pages/terms');
      terms = TermsModel.fromJson(termsData.data);
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
    }
    return terms;
  }

  Future<About?> getAbout() async {
    About? about;
    try {
      Response aboutData = await _dio.get('$_baseUrl/pages/about');
      about = About.fromJson(aboutData.data);
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
    }
    return about;
  }

  Future<Privacy?> getPrivacy() async {
    Privacy? privacy;
    try {
      Response privacyData = await _dio.get('$_baseUrl/pages/privacy');
      privacy = Privacy.fromJson(privacyData.data);
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
    }
    return privacy;
  }

  Future<LocationModel?> getLocation() async {
    LocationModel? locationModel;
    try {
      Response locationModelData = await _dio.get('$_baseUrl/location');
      locationModel = LocationModel.fromJson(locationModelData.data);
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
    }
    return locationModel;
  }

  Future<MainCategoriesModel?> getMainCategories() async {
    MainCategoriesModel? mainCategoriesModel;
    try {
      Response mainCategoriesModelData =
          await _dio.get('$_baseUrl/main-categories/${Auth.instance.prefs.getInt("selectedLocationId")}');
      mainCategoriesModel =
          MainCategoriesModel.fromJson(mainCategoriesModelData.data);
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
    }
    return mainCategoriesModel;
  }

  Future<bool?> sendOtp(String phoneNumber) async {
    Map<String, dynamic> data = {"mobile": phoneNumber, "calling_code": "+91"};
    String jsonData = json.encode(data);
    print(data);
    try {
      Response response = await _dio.post(
        AppConstants.apiLogin,
        data: data,
      );
      print(response);
    } on DioError catch (e) {
      if (e.response != null) {
      } else {

      }
      return false;
    }
    return true;
  }

  Future<User?> verifyOtp(String otp, String phoneNumber) async {
    Map<String, dynamic> data = {"calling_code": "+91", "mobile": phoneNumber, "otp": otp};
    String jsonData = json.encode(data);
    print(data);
    try {
      Response response = await _dio.post(
        AppConstants.apiOtpVerify,
        data: data,
      );
      print(response);
      return User.fromJson(jsonEncode(response.data["user"]));
    } on DioError catch (e) {
      if (e.response != null) {
      } else {

      }
      return null;
    }
    return null;
  }

  Dio get dio => _dio;
}

class TokenInterceptor extends Interceptor {
  //String? authToken = GetStorage().read('authToken');
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //options.headers["authorization"] = "Bearer $authToken";
    print(options.headers);
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}'
        'DATA => ${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    print(err.response?.data);
    return super.onError(err, handler);
  }
}

// Global options
final options = CacheOptions(
  store: MemCacheStore(),
  policy: CachePolicy.request,
  hitCacheOnErrorExcept: [401, 403],
  maxStale: const Duration(hours: 1),
  priority: CachePriority.high,
);
