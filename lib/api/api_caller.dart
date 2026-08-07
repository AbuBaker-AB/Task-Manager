import 'dart:convert';


import 'package:http/http.dart';
import 'package:logger/logger.dart';

import '../features/auth/providers/auth_controller.dart';
import 'api_response.dart';

class ApiCaller {
  static final Logger _logger = Logger();

  static Future<ApiResponse>getRequest({required String URL}) async {

    try{
      Uri uri = Uri.parse(URL);

      _logger.i(URL);

      Response response = await get(uri, headers: {
        'token': AuthController.token ?? ''
      });

      _logger.i(response.body);

      if(response.statusCode == 200){
        return ApiResponse(responseCode: response.statusCode, responseData: jsonDecode(response.body), isSuccess: true);
      }else{
        return ApiResponse(responseCode: response.statusCode, responseData: jsonDecode(response.body), isSuccess: false, errorMessage:jsonDecode(response.body) );
      }

    }catch(e){
      return ApiResponse(responseCode: -1, responseData: null, isSuccess: false, errorMessage:e.toString());

    }
  }





  static Future<ApiResponse>postRequest({required String URL, Map<String,dynamic>?body}) async {

    try{
      Uri uri = Uri.parse(URL);

      _logger.i(URL);

      Response response = await post(uri, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        'token': AuthController.token ?? ''
      },
        body: body != null ? jsonEncode(body) : null,

      );

      _logger.i(response.body);

      if(response.statusCode == 200 || response.statusCode == 201){
        return ApiResponse(responseCode: response.statusCode, responseData: jsonDecode(response.body), isSuccess: true);
      }else{
        return ApiResponse(responseCode: response.statusCode, responseData: jsonDecode(response.body), isSuccess: false, errorMessage:jsonDecode(response.body) );
      }

    }catch(e){
      return ApiResponse(responseCode: -1, responseData: null, isSuccess: false, errorMessage:e.toString());

    }
  }


}