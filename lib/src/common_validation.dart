import 'dart:convert';
import 'package:flutter/rendering.dart';

class CommonValidation {

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


  String? checkValidation({required String enteredValue,required Map<String, dynamic> validationStr,required String formFieldType}){
    String? errorMsg;
    switch(formFieldType){
      case 'text':
       return errorMsg = isValidText(enteredValue,validationStr);

      case 'password':
        return errorMsg = isValidPassword(enteredValue,validationStr);

      case 'name':
       return errorMsg = isValidName(enteredValue,validationStr);

      case 'email':
        return errorMsg = isValidEmail(enteredValue,validationStr);

      case 'tel':
        return errorMsg = isValidTel(enteredValue,validationStr);

      case 'url':
        return errorMsg = isValidUrl(enteredValue,validationStr);

      case 'number':
        return errorMsg = isValidNumber(enteredValue,validationStr);

      case 'text_multiline':
        return errorMsg = isValidEmail(enteredValue,validationStr);

    }
  }

  String? isValidText(String value,Map<String, dynamic> validationStr){


    String? errorMsg;
    try {
      Map<String,dynamic> validation = validationStr;
      Map<String,dynamic> errorMessage = validation.containsKey('errorMessage')?validation['errorMessage']:<String,dynamic>{};

      /*int minLine = 1;
    int maxLine = 20;*/

      bool required = validation.containsKey('required')?validation['required']: false;
      int minLength = validation.containsKey('minLength')?validation['minLength']: 1;
      int maxLength = validation.containsKey('maxLength')?validation['maxLength']: 2;
      String rejex = validation.containsKey('rejex')?validation['rejex']:"";

      if(value.trim().isEmpty){
        errorMsg = errorMessage.containsKey('required')?errorMessage['required']:"required key missing";
      }
      else if(value.length > maxLength){
        errorMsg = errorMessage.containsKey('maxLength')?errorMessage['maxLength']:"maxLength key missing";
      }
      else if(value.length < minLength){
        errorMsg = errorMessage.containsKey('minLength')?errorMessage['minLength']:"minLength key missing";
      }
      else if(rejex.trim().isNotEmpty){
        RegExp regex = RegExp(rejex.trim());
        bool isMatched = regex.hasMatch(value);
        errorMsg = isMatched?null: errorMsg = errorMessage.containsKey('rejex')?errorMessage['rejex']:"rejex key missing";
      }
      else{
        errorMsg = null;
      }
    }
    catch (e) {
      print(e);
    }
    return errorMsg;
  }
  String? isValidEmail(String value,Map<String, dynamic> validationStr){

    String? errorMsg ;
    try {
      Map<String,dynamic> validation = validationStr;
      Map<String,dynamic> errorMessage = validation.containsKey('errorMessage')?validation['errorMessage']:<String,dynamic>{};

      /*int minLine = 1;
    int maxLine = 20;*/

      bool required = validation.containsKey('required')?validation['required']: false;
      bool isEmail = validation.containsKey('isEmail')?validation['isEmail']: false;
      int minLength = validation.containsKey('minLength')?validation['minLength']: 1;
      int maxLength = validation.containsKey('maxLength')?validation['maxLength']: 2;
      String rejex = validation.containsKey('rejex')?validation['rejex']:"";

      if(value.trim().isEmpty){
        errorMsg = errorMessage.containsKey('required')?errorMessage['required']:"required key missing";
      }
      else if(rejex.trim().isNotEmpty){
        RegExp regex = RegExp(rejex.trim());
        bool isMatched = regex.hasMatch(value);
        errorMsg = isMatched?null: errorMsg = errorMessage.containsKey('rejex')?errorMessage['rejex']:"rejex key missing";
      }
      else if(isEmail && rejex.trim().isEmpty){
        rejex = r"^([^\.]+[a-zA-Z0-9.a-zA-Z0-9.!$%&'*+-/=?^_`{|}~!]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+[^\.-]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$";
        RegExp regex = RegExp(rejex.trim());
        bool isMatched = regex.hasMatch(value);
        errorMsg = isMatched?null: errorMsg = errorMessage.containsKey('rejex')?errorMessage['rejex']:"rejex key missing";
      }
      else{
        errorMsg = null;
      }
    }
    catch (e) {
      print(e);
    }
    return errorMsg;
  }
  String? isValidPassword(String value,Map<String, dynamic> validationStr){
    String? errorMsg ;
    try {
      Map<String,dynamic> validation = validationStr;
      Map<String,dynamic> errorMessage = validation.containsKey('errorMessage')?validation['errorMessage']:<String,dynamic>{};

    /*int minLine = 1;
    int maxLine = 20;*/

    bool required = validation.containsKey('required')?validation['required']: false;
    int minLength = validation.containsKey('minLength')?validation['minLength']: 1;
    int maxLength = validation.containsKey('maxLength')?validation['maxLength']: 2;
    String rejex = validation.containsKey('rejex')?validation['rejex']:"";

      if(value.trim().isEmpty){
         errorMsg = errorMessage.containsKey('required')?errorMessage['required']:"required key missing";
      }
      else if(value.length > maxLength){
        errorMsg = errorMessage.containsKey('maxLength')?errorMessage['maxLength']:"maxLength key missing";
      }
      else if(value.length < minLength){
        errorMsg = errorMessage.containsKey('minLength')?errorMessage['minLength']:"minLength key missing";
      }
      else if(rejex.trim().isNotEmpty){
        RegExp regex = RegExp(rejex.trim());
        bool isMatched = regex.hasMatch(value);
        errorMsg = isMatched?null: errorMsg = errorMessage.containsKey('rejex')?errorMessage['rejex']:"rejex key missing";
      }
      else{
        errorMsg = null;
      }
    }
    catch (e) {
      print(e);
    }
    return errorMsg;
  }
  String? isValidName(String value,Map<String, dynamic> validationStr){

    String? errorMsg ;
    try {
      Map<String,dynamic> validation = validationStr;
      Map<String,dynamic> errorMessage = validation.containsKey('errorMessage')?validation['errorMessage']:<String,dynamic>{};

      /*int minLine = 1;
    int maxLine = 20;*/

      bool required = validation.containsKey('required')?validation['required']: false;
      int minLength = validation.containsKey('minLength')?validation['minLength']: 1;
      int maxLength = validation.containsKey('maxLength')?validation['maxLength']: 2;
      String rejex = validation.containsKey('rejex')?validation['rejex']:"";

      if(value.trim().isEmpty){
        errorMsg = errorMessage.containsKey('required')?errorMessage['required']:"required key missing";
      }
      else if(value.length > maxLength){
        errorMsg = errorMessage.containsKey('maxLength')?errorMessage['maxLength']:"maxLength key missing";
      }
      else if(value.length < minLength){
        errorMsg = errorMessage.containsKey('minLength')?errorMessage['minLength']:"minLength key missing";
      }
      else if(rejex.trim().isNotEmpty){
        RegExp regex = RegExp(rejex.trim());
        bool isMatched = regex.hasMatch(value);
        errorMsg = isMatched?null: errorMsg = errorMessage.containsKey('rejex')?errorMessage['rejex']:"rejex key missing";
      }
      else{
        errorMsg = null;
      }
    }
    catch (e) {
      print(e);
    }
    return errorMsg;
  }
  String? isValidTel(String value,Map<String, dynamic> validationStr){

    String? errorMsg ;
    try {
      Map<String,dynamic> validation = validationStr;
      Map<String,dynamic> errorMessage = validation.containsKey('errorMessage')?validation['errorMessage']:<String,dynamic>{};

      /*int minLine = 1;
    int maxLine = 20;*/

      bool required = validation.containsKey('required')?validation['required']: false;
      int minLength = validation.containsKey('minLength')?validation['minLength']: 1;
      int maxLength = validation.containsKey('maxLength')?validation['maxLength']: 2;
      String rejex = validation.containsKey('rejex')?validation['rejex']:"";

      if(value.trim().isEmpty){
        errorMsg = errorMessage.containsKey('required')?errorMessage['required']:"required key missing";
      }
      else if(value.length > maxLength){
        errorMsg = errorMessage.containsKey('maxLength')?errorMessage['maxLength']:"maxLength key missing";
      }
      else if(value.length < minLength){
        errorMsg = errorMessage.containsKey('minLength')?errorMessage['minLength']:"minLength key missing";
      }
      else if(rejex.trim().isNotEmpty){
        RegExp regex = RegExp(rejex.trim());
        bool isMatched = regex.hasMatch(value);
        errorMsg = isMatched?null: errorMsg = errorMessage.containsKey('rejex')?errorMessage['rejex']:"rejex key missing";
      }
      else{
        errorMsg = null;
      }
    }
    catch (e) {
      print(e);
    }
    return errorMsg;
  }
  String? isValidUrl(String value,Map<String, dynamic> validationStr){

    String? errorMsg;
    try {
      Map<String,dynamic> validation = validationStr;
      Map<String,dynamic> errorMessage = validation.containsKey('errorMessage')?validation['errorMessage']:<String,dynamic>{};

      /*int minLine = 1;
    int maxLine = 20;*/

      bool required = validation.containsKey('required')?validation['required']: false;
      int minLength = validation.containsKey('minLength')?validation['minLength']: 1;
      int maxLength = validation.containsKey('maxLength')?validation['maxLength']: 2;
      String rejex = validation.containsKey('rejex')?validation['rejex']:"";

      if(value.trim().isEmpty){
        errorMsg = errorMessage.containsKey('required')?errorMessage['required']:"required key missing";
      }
      else if(value.length > maxLength){
        errorMsg = errorMessage.containsKey('maxLength')?errorMessage['maxLength']:"maxLength key missing";
      }
      else if(value.length < minLength){
        errorMsg = errorMessage.containsKey('minLength')?errorMessage['minLength']:"minLength key missing";
      }
      else if(rejex.trim().isNotEmpty){
        RegExp regex = RegExp(rejex.trim());
        bool isMatched = regex.hasMatch(value);
        errorMsg = isMatched?null: errorMsg = errorMessage.containsKey('rejex')?errorMessage['rejex']:"rejex key missing";
      }
      else{
        errorMsg = null;
      }
    }
    catch (e) {
      print(e);
    }
    return errorMsg;
  }
  String? isValidNumber(String value,Map<String, dynamic> validationStr){

    String? errorMsg;
    try {
      Map<String,dynamic> validation = validationStr;
      Map<String,dynamic> errorMessage = validation.containsKey('errorMessage')?validation['errorMessage']:<String,dynamic>{};

      /*int minLine = 1;
    int maxLine = 20;*/

      bool required = validation.containsKey('required')?validation['required']: false;
      int minLength = validation.containsKey('minLength')?validation['minLength']: 1;
      int maxLength = validation.containsKey('maxLength')?validation['maxLength']: 2;
      String rejex = validation.containsKey('rejex')?validation['rejex']:"";

      if(value.trim().isEmpty){
        errorMsg = errorMessage.containsKey('required')?errorMessage['required']:"required key missing";
      }
      else if(value.length > maxLength){
        errorMsg = errorMessage.containsKey('maxLength')?errorMessage['maxLength']:"maxLength key missing";
      }
      else if(value.length < minLength){
        errorMsg = errorMessage.containsKey('minLength')?errorMessage['minLength']:"minLength key missing";
      }
      else if(rejex.trim().isNotEmpty){
        RegExp regex = RegExp(rejex.trim());
        bool isMatched = regex.hasMatch(value);
        errorMsg = isMatched?null: errorMsg = errorMessage.containsKey('rejex')?errorMessage['rejex']:"rejex key missing";
      }
      else{
        errorMsg = null;
      }
    }
    catch (e) {
      print(e);
    }
    return errorMsg;
  }

}

CommonValidation commonValidation = CommonValidation();