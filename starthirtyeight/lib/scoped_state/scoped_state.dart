
import 'package:scoped_model/scoped_model.dart';
import 'package:fluro/fluro.dart';
import 'package:starthirtyeight/services/readwritephonenumber.dart';
import 'package:starthirtyeight/HTTP/requests.dart' as Requests;

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
      var requests = new Requests.POSTRequests();
      requests.addUserNumber(writeVal);
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

class InfoModel extends Model{
  var _showInfoModel = false;
  bool get showInfoModel => _showInfoModel;
  var _infoName = "";
  String get infoName => _infoName;
  setInfoModel(newVal, newName){
    _showInfoModel = newVal;
    _infoName = newName;
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

class SettingsData extends Model{
  var _userMongoose;
  get userMongoose => _userMongoose;
  setUserMongoose(newVal){
    print('inside setUserMongoose and newVal');
    print(newVal);
    _userMongoose = newVal;
    notifyListeners();
  }
}

class SettingsViews extends Model{
  String _step1ChooseType="new_list";
  String get step1ChooseType => _step1ChooseType;
  changeStep1ChooseType(newType){
    _step1ChooseType = newType;
    notifyListeners();
  }

  bool _showProductBanners=true;
  bool get showProductBanners => _showProductBanners;
  setShowProductBanners(newVal){
    _showProductBanners = newVal;
    notifyListeners();
  }

  bool _showPrevLists=false;
  bool get showPrevLists => _showPrevLists;
  setShowPrevLists(newVal){
    _showPrevLists = newVal;
    notifyListeners();
  }

  bool _showNameList=false;
  bool get showNameList => _showNameList;
  setShowNameList(newVal){
    _showNameList = newVal;
    notifyListeners();
  }

  String _recordingOption = "none";
  String get recordingOption => _recordingOption;
  setRecordingOption(newVal){
    _recordingOption = newVal;
    notifyListeners();
  }

  String _newListName = "";
  String get newListName => _newListName;
  setNewListName(newVal){
    _newListName = newVal;
    notifyListeners();
  }

  String _nextStep = "";
  String get nextStep => _nextStep;
  setNextStep(newVal){
    _nextStep = newVal;
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

class MainModel extends Model with PhoneModel, SplashModel, ReadWriteModel, ErrorModel, SettingsRouter, SettingsViews, InfoModel, SettingsData{}
