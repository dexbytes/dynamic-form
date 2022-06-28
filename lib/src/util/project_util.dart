import 'package:dynamic_json_form/parts.dart';

class PackageUtil {

  TextInputType keyBoardType({required String formFieldType}){
    TextInputType keyBoardType = TextInputType.text;
    switch(formFieldType){
      case 'text':
        keyBoardType = TextInputType.text;
        break ;
      case 'name':
        keyBoardType = TextInputType.name;
        break ;
      case 'email':
        keyBoardType = TextInputType.emailAddress;
        break ;
      case 'tel':
        keyBoardType = TextInputType.phone;
        break ;
      case 'url':
        keyBoardType = TextInputType.url;
        break ;
      case 'number':
        keyBoardType = TextInputType.number;
        break ;
      case 'text_multiline':
        keyBoardType = TextInputType.multiline;
        break ;
    }
    // keyBoardType = TextInputType.emailAddress;

    return keyBoardType;
  }
}

PackageUtil packageUtil = PackageUtil();