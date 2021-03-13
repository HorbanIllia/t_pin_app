import 'package:dio/dio.dart';
import 'package:t_pin_app/models/pin_model.dart';

import 'mock_interceptor.dart';

class ApiProvider {
  final Dio _dio = Dio();

  Future<Pin> fetchFakePin(String code) async {
    try{

      _dio.interceptors.add(MockInterceptor());

      Response response;
      if(code.contains("1111")){
        response = await Future.delayed(Duration(seconds: 10),()=>_dio.get("access"));
      } else response = await Future.delayed(Duration(seconds: 5),()=>_dio.get("close"));

      return Pin.fromJson(response.data);
    } catch(error, stacktrace){
      print("Post. Exception: $error stackTrace: $stacktrace");
      return null;
    }
  }

}