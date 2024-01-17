import 'package:dio/dio.dart';

class DioManager {
  static DioManager _instance = DioManager._internal();
  static late Dio _dio;

  factory DioManager() => _instance;


  DioManager._internal() {
    _dio = Dio();
    _dio.options.baseUrl = "https://www.baidu.com/";
  }



  Future<T> _request<T>(String path, String method ,{Map<String,dynamic>? param, data}) async{

     var options = Options(method: method);
     Response response = await _dio.request<T>(path,options: options,queryParameters: param,data: data);
     return response.data;
  }


  Future<T> get<T>(String path,{Map<String,dynamic>? param, data}) async{
    return _request<T>(path, "GET",param: param,data: data);
  }

  Future<T> post<T>(String path,{Map<String,dynamic>? param, data})async{
    return _request<T>(path, "POST",param: param,data: data);
  }
}
