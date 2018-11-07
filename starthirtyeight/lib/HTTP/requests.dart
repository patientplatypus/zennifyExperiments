import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';

var zeitURL="https://backend-bcseqdeiad.now.sh";

class GETRequests{

  spinRequest() async{
    print('inside spinRequest');
    Dio dio = new Dio();
    try {
      Response response;
      response=await dio.get(zeitURL+"/spinget");
      print('here is the response from testRequest');
      print(response.data);
    } on DioError catch(e) {
        print('there was some error in testRequest');
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);  
    }
  }

  testRequest() async{
    print('inside testRequest');
    Dio dio = new Dio();
    try {
      Response response;
      response=await dio.get(zeitURL+"/testget");
      print('here is the response from testRequest');
      print(response.data);
    } on DioError catch(e) {
        print('there was some error in testRequest');
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);  
    }

  }
}


class POSTRequests{
  addUserNumber(userNumber) async{
    print('inside addUserNumber');
    Dio dio = new Dio();
    try {
      Response response;
      response=await dio.post(zeitURL + "/addUserNumber", data: {"userNumber": userNumber});
      print('here is the response from addUserNumber');
      print(response);
    } on DioError catch(e) {
        print('there was some error in addUserNumber');
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);  
    }

  }
}