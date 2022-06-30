part of dynamic_json_form;

class ConfigurationSetting extends TextFieldConfiguration{
  ConfigurationSetting._internal();
  static final ConfigurationSetting instance = ConfigurationSetting._internal();
  /*We will load form jason from API always will not check local json in case it true if it false we will always load formJason from local*/
  bool _loadFromApi = false;

  final List<String> singleLineInputFields = ['password','email','tel'];

  TextFieldConfiguration _textFieldConfiguration = TextFieldConfiguration();

  /*Set Text field ui presentation*/
  set setTextFieldViewConfig (TextFieldConfiguration textFieldConfig){
    _textFieldConfiguration = textFieldConfig;
  }
/*  textField({TextStyle? textStyle,TextStyle? hintStyle,InputBorder? border}){
    _textFieldConfiguration = setConfiguration(textStyle:textStyle,hintStyle:hintStyle,border:border);
  }*/

  /*Get stored local form from device */
  Future<String?> getFormDataLocal() async {
    return await localStorage.getFormDataLocal();
  }

  /*Store form data local device*/
  Future<String> storeFormDataLocal(String formJson) async {
    return await localStorage.storeFormDataLocal(formJson)!;
  }

  /*
  * Set value tru or false
  * */
  set setLoadFromApi (bool loadFromApi) {
    _loadFromApi = loadFromApi;
  }
  /*
  * Set value tru or false
  * */
  get getLoadFromApi => _loadFromApi;


}