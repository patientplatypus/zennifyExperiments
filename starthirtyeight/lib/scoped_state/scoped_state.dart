
import 'package:scoped_model/scoped_model.dart';
import 'package:fluro/fluro.dart';
import 'package:starthirtyeight/services/readwritephonenumber.dart';

var localStorage = new LocalPhoneStorage();

class ReadWriteModel extends Model{

  String _phoneNumber = "not initialized";

  String get phoneNumber => _phoneNumber;

  readFunc(){
    print('inside readFunc');
    var phoneRead = localStorage.readUserPhoneNumber().then((returnedNumber){
        _phoneNumber = returnedNumber;
        print('inside readFunc localStorage and value of _phoneNumber $_phoneNumber');
    });
    asyncRead()async{
      await phoneRead;
      notifyListeners();
    }
    asyncRead();
  }

  writeFunc(writeVal){
    print('inside writeFunc');
    asyncWrite()async{
      await localStorage.writeUserPhoneNumber(writeVal);
      readFunc();
    }
    asyncWrite();
  }

}

class CounterModel extends Model {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    // First, increment the counter
    _counter++;

    // Then notify all the listeners.
    notifyListeners();
  }
}

class ErrorModel extends Model{
  var _errorNumberModal = false;
  bool get errorNumberModal => _errorNumberModal;
  toggleErrorModal(){
    _errorNumberModal = !_errorNumberModal;
    notifyListeners();
  }
}

class SplashModel extends Model{
  var _enterNumberButton = false;
  bool get enterNumberButton => _enterNumberButton;
  toggleEnterNumberButton(){
    _enterNumberButton = !_enterNumberButton;
    notifyListeners();
  }
}

class SettingsRouter extends Model{
  String _settingsCurrentRoute = "menu";
  String get settingsCurrentRoute => _settingsCurrentRoute;

  recordSettingsRoute(routeName){
    print('inside recordSettingsRoute');
    _settingsCurrentRoute = routeName;
    print('value of _settingsCurrentRoute');
    print(_settingsCurrentRoute);
    notifyListeners();
  }
}

class SettingsModel extends Model{
  
}

class SettingsViews extends Model{
  String _step1ChooseType="new_list";
  String get step1ChooseType => _step1ChooseType;
  changeStep1ChooseType(newType){
    _step1ChooseType = newType;
    notifyListeners();
  }
}

class BottombarModel extends Model{
  String _currentRoute="";
  String get currentRoute => _currentRoute;
  recordRoute(routeName){
    print('inside recordRoute');
    _currentRoute = routeName;
    print('value of _currentRoute');
    print(_currentRoute);
    notifyListeners();
  }
}

class PhoneModel extends Model{
  String _callNumber = "";
  String get callNumber => _callNumber;
  appendNumber(digitAdd) {
    if (_callNumber.length < 10){
      _callNumber = _callNumber + digitAdd;
    }
    notifyListeners();
  }
  deleteNumber(){
    print('value of callnumber before substring: ${_callNumber}');
    _callNumber = _callNumber.substring(0, _callNumber.length - 1);
    print('value of callnumber after substring: ${_callNumber}');
    notifyListeners();
  }
}

class MainModel extends Model with PhoneModel, SplashModel, ReadWriteModel, ErrorModel, SettingsRouter, SettingsViews{}
