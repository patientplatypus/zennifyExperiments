import 'package:device_info/device_info.dart';
import 'dart:io';
import 'dart:async';

//not currently operational
//not sure why
// E/flutter (  586): [ERROR:flutter/shell/common/shell.cc(181)] Dart Error: Unhandled exception:
// E/flutter (  586): MissingPluginException(No implementation found for method getIosDeviceInfo on channel plugins.flutter.io/device_info)
// E/flutter (  586): #0      MethodChannel.invokeMethod (package:flutter/src/services/platform_channel.dart:278:7)
// E/flutter (  586): <asynchronous suspension>
// E/flutter (  586): #1      DeviceInfoPlugin.iosInfo (package:device_info/device_info.dart:34:44)
// E/flutter (  586): <asynchronous suspension>
// E/flutter (  586): #2      DeviceInfo.getInfo (package:starthirtyeight/services/deviceinfo.dart:12:46)
// E/flutter (  586): <asynchronous suspension>
// E/flutter (  586): #3      main (file:///Users/patientplatypus/Documents/zennifyExperiments/starthirtyeight/lib/main.dart:35:9)
// E/flutter (  586): #4      _startIsolate.<anonymous closure> (dart:isolate/runtime/libisolate_patch.dart:289:19)
// E/flutter (  586): #5      _RawReceivePortImpl._handleMessage (dart:isolate/runtime/libisolate_patch.dart:171:12)

class DeviceInfo{
  getInfo() async{
    print('inside DeviceInfo/getInfo()');
    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}');  // e.g. "Moto G (4)"

    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    print('Running on ${iosInfo.utsname.machine}');  // e.g. "iPod7,1"
  }
}