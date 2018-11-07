import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalPhoneStorage {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/userPhoneNumber.txt');
  }

  Future<String> readUserPhoneNumber() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      // If we encounter an error, return 0
      return "not found";
    }
  }

  Future<File> writeUserPhoneNumber(String userPhoneNumber) async {
    final file = await _localFile;
    return file.writeAsString(userPhoneNumber);
  }
}