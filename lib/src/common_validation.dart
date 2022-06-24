
import 'dart:async';
import 'dart:convert';
import 'package:dynamic_json_form/src/state/data_refresh_stream.dart';
import 'package:flutter/rendering.dart';

class CommonValidation {

  /*This will display current displayed form page it will change when user change form by clicking next or preview*/
  static int _currentFormNumber = 0;
  get getCurrentFormNumber => _currentFormNumber;
  set setCurrentFormNumber(value){
    _currentFormNumber = value;
  }

  /*This is formData will contain data according to form index*/
  static final Map<int,List<dynamic>> _formData = {};
  get getFormData => _formData;

  set setFormData(String jsonEncoded){
    //_formData = value;
    if(isValidJsonEncoded(jsonEncoded)){
      Map<String,dynamic>? enteredJson = json.decode(jsonEncoded);
      if(enteredJson!["formType"].toString().isNotEmpty){
        //Single form
        if(enteredJson["formType"]=="single"){
          _formData[0] = enteredJson["formFields"];
          _currentFormNumber = 0;
        }
        //Multi form
        else{
          _currentFormNumber = 0;
        }

        /*DataRefreshStream.instance.formFieldsRefresh(_formData[_currentFormNumber] as List<dynamic>);*/
      }

    }

  }

  StreamController<String> streamController = StreamController();




  //Check is entered json is not empty and correct format
  bool isValidJsonEncoded(String jsonEncoded){
    bool isValidate = false;
    if(jsonEncoded.isNotEmpty){
      try {
     // var enteredJsonN = json.decode(jsonEncoded);
        Map<String,dynamic>? enteredJson = json.decode(jsonEncoded);
        if(enteredJson!.isNotEmpty){
                if(enteredJson.containsKey("formType") && enteredJson.containsKey("formFields") && enteredJson["formFields"].isNotEmpty){
                  isValidate = true;
                }
              }
      } catch (e) {
        debugPrint("$e");
      }
    }
    return isValidate;
  }

  resetAll(){
    setCurrentFormNumber = -1;

  }
}

CommonValidation commonValidation = CommonValidation();