import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';

var zeitURL="https://backend-akpdptqjya.now.sh";

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

  getUserData(userNumber) async{
    print('inside getUserData');
    Dio dio = new Dio();
    try {
      Response response;
      response=await dio.post(zeitURL + "/getUserData", data: {"userNumber": userNumber});
      print('here is the response from getUserData');
      print(response);
      return response;
    } on DioError catch(e) {
        print('there was some error in getUserData');
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);  
        return e;
    }
  }

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

  addUserList(userNumber, listName, recordingType) async{
    print('inside addUserList() and value of userNumber');
    print(userNumber);
    print('and value of listName');
    print(listName);
    print('and value of recordingType');
    print(recordingType);
    Dio dio = new Dio();
    try {
      Response response;
      response=await dio.post(zeitURL + "/addUserList", data: {"userNumber": userNumber, "listName": listName, "recordingType": recordingType});
      print('here is the response from addUserList');
      print(response);
      return response.data;
    } on DioError catch(e) {
        print('there was some error in addUserList');
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);  
        return e.response.data;
    }
  }

}