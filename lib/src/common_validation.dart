import 'dart:convert';
import 'package:flutter/rendering.dart';

import 'model/text_field_model.dart';

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


  String? checkValidation({required String enteredValue,required String validationStr,required String formFieldType}){
    String? errorMsg = "";
    switch(formFieldType){
      case 'text':
        errorMsg = isValidText(enteredValue,validationStr);
        break ;
      case 'password':
        errorMsg = isValidPassword(enteredValue,validationStr);
        break ;
      case 'name':
        errorMsg = isValidName(enteredValue,validationStr);
        break ;
      case 'email':
        errorMsg = isValidEmail(enteredValue,validationStr);
        break ;
      case 'tel':
        errorMsg = isValidTel(enteredValue,validationStr);
        break ;
      case 'url':
        errorMsg = isValidUrl(enteredValue,validationStr);
        break ;
      case 'number':
        errorMsg = isValidNumber(enteredValue,validationStr);
        break ;
      case 'text_multiline':
        errorMsg = isValidEmail(enteredValue,validationStr);
        break ;
    }

   // String? errorMsg = validation.errorMessage!.required!;
   /* try {
      if(value.trim().isEmpty){
        return errorMsg;
      }
      if(value.length > validation.maxLength!){
        errorMsg = validation.errorMessage!.maxLength!;
      }
      else if(value.length < validation.minLength!){
        errorMsg = validation.errorMessage!.minLength!;
      }
      else{
        errorMsg = null;
      }
    } catch (e) {
      print(e);
    }*/
    return errorMsg;
  }

  String? isValidText(String value,String validationStr){
    String? errorMsg = "";
    try {
      Map<String,dynamic> validation = jsonDecode(validationStr);
      Map<String,dynamic> errorMessage = validation.containsKey('errorMessage')?validation['errorMessage']:<String,dynamic>{};


      /*    int minLine = 1;
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
      else if(rejex.isNotEmpty){
        // Pattern pattern = rejex;
        RegExp regex = RegExp(rejex);
        errorMsg = regex.hasMatch(value)?null:errorMsg = errorMessage.containsKey('rejex')?errorMessage['rejex']:"rejex key missing";
      }
      else{
        errorMsg = null;
      }
/*"isReadOnly":false,
    "isUnique":false,
    "isDisabled":false*/
      // String? errorMsg = validation.errorMessage!.required!;
    }
    catch (e) {
      print(e);
    }

    return errorMsg;
  }


  String? isValidEmail(String value,String validationStr){
    String? errorMsg = "";
    try {
      Map<String,dynamic> validation = jsonDecode(validationStr);
      Map<String,dynamic> errorMessage = validation.containsKey('errorMessage')?validation['errorMessage']:<String,dynamic>{};

/*    int minLine = 1;
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
      else if(rejex.isNotEmpty){
        // Pattern pattern = rejex;
        RegExp regex = RegExp(rejex);
        errorMsg = regex.hasMatch(value)?null:errorMsg = errorMessage.containsKey('rejex')?errorMessage['rejex']:"rejex key missing";
      }
      else{
        errorMsg = null;
      }
/*    "isReadOnly":false,
    "isUnique":false,
    "isDisabled":false*/
      // String? errorMsg = validation.errorMessage!.required!;
    }
    catch (e) {
      print(e);
    }

    return errorMsg;
  }
  String? isValidPassword(String value,String validationStr){
    String? errorMsg = "";
    try {
      Map<String,dynamic> validation = jsonDecode(validationStr);
      Map<String,dynamic> errorMessage = validation.containsKey('errorMessage')?validation['errorMessage']:<String,dynamic>{};

/*    int minLine = 1;
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
      else if(rejex.isNotEmpty){
        // Pattern pattern = rejex;
        RegExp regex = RegExp(rejex);
        errorMsg = regex.hasMatch(value)?null:errorMsg = errorMessage.containsKey('rejex')?errorMessage['rejex']:"rejex key missing";
      }
      else{
        errorMsg = null;
      }
/*    "isReadOnly":false,
    "isUnique":false,
    "isDisabled":false*/
      // String? errorMsg = validation.errorMessage!.required!;
    }
    catch (e) {
      print(e);
    }

    return errorMsg;
  }
  String? isValidName(String value,String validationStr){
    String? errorMsg = "";
    try {
      Map<String,dynamic> validation = jsonDecode(validationStr);
      Map<String,dynamic> errorMessage = validation.containsKey('errorMessage')?validation['errorMessage']:<String,dynamic>{};

/*    int minLine = 1;
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
      else if(rejex.isNotEmpty){
        // Pattern pattern = rejex;
        RegExp regex = RegExp(rejex);
        errorMsg = regex.hasMatch(value)?null:errorMsg = errorMessage.containsKey('rejex')?errorMessage['rejex']:"rejex key missing";
      }
      else{
        errorMsg = null;
      }
/*    "isReadOnly":false,
    "isUnique":false,
    "isDisabled":false*/
      // String? errorMsg = validation.errorMessage!.required!;
    }
    catch (e) {
      print(e);
    }

    return errorMsg;
  }

  String? isValidTel(String value,String validationStr){
    String? errorMsg = "";
    try {
      Map<String,dynamic> validation = jsonDecode(validationStr);
      Map<String,dynamic> errorMessage = validation.containsKey('errorMessage')?validation['errorMessage']:<String,dynamic>{};

/*    int minLine = 1;
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
      else if(rejex.isNotEmpty){
        // Pattern pattern = rejex;
        RegExp regex = RegExp(rejex);
        errorMsg = regex.hasMatch(value)?null:errorMsg = errorMessage.containsKey('rejex')?errorMessage['rejex']:"rejex key missing";
      }
      else{
        errorMsg = null;
      }
/*    "isReadOnly":false,
    "isUnique":false,
    "isDisabled":false*/
      // String? errorMsg = validation.errorMessage!.required!;
    }
    catch (e) {
      print(e);
    }

    return errorMsg;
  }

  String? isValidUrl(String value,String validationStr){
    String? errorMsg = "";
    try {
      Map<String,dynamic> validation = jsonDecode(validationStr);
      Map<String,dynamic> errorMessage = validation.containsKey('errorMessage')?validation['errorMessage']:<String,dynamic>{};

/*    int minLine = 1;
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
      else if(rejex.isNotEmpty){
        // Pattern pattern = rejex;
        RegExp regex = RegExp(rejex);
        errorMsg = regex.hasMatch(value)?null:errorMsg = errorMessage.containsKey('rejex')?errorMessage['rejex']:"rejex key missing";
      }
      else{
        errorMsg = null;
      }
/*    "isReadOnly":false,
    "isUnique":false,
    "isDisabled":false*/
      // String? errorMsg = validation.errorMessage!.required!;
    }
    catch (e) {
      print(e);
    }

    return errorMsg;
  }

  String? isValidNumber(String value,String validationStr){
    String? errorMsg = "";
    try {
      Map<String,dynamic> validation = jsonDecode(validationStr);
      Map<String,dynamic> errorMessage = validation.containsKey('errorMessage')?validation['errorMessage']:<String,dynamic>{};

/*    int minLine = 1;
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
      else if(rejex.isNotEmpty){
        // Pattern pattern = rejex;
        RegExp regex = RegExp(rejex);
        errorMsg = regex.hasMatch(value)?null:errorMsg = errorMessage.containsKey('rejex')?errorMessage['rejex']:"rejex key missing";
      }
      else{
        errorMsg = null;
      }
/*    "isReadOnly":false,
    "isUnique":false,
    "isDisabled":false*/
      // String? errorMsg = validation.errorMessage!.required!;
    }
    catch (e) {
      print(e);
    }

    return errorMsg;
  }


}

CommonValidation commonValidation = CommonValidation();