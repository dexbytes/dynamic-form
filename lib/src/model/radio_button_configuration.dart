part of dynamic_json_form;

enum LabelAndRadioButtonAlign{vertical, horizontal}
class RadioButtonConfiguration {

  //Label style
  late TextStyle _labelTextStyle =  const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  );

  //label alignment with radioButton
  late LabelAndRadioButtonAlign _labelAndRadioButtonAlign = LabelAndRadioButtonAlign.horizontal;

  //Radio buttons alignment
  late LabelAndRadioButtonAlign _radioButtonsAlign = LabelAndRadioButtonAlign.horizontal;

  RadioButtonConfiguration({TextStyle? labelTextStyle,LabelAndRadioButtonAlign? labelAndRadioButtonAlign,LabelAndRadioButtonAlign? radioButtonsAlign}){
    _labelTextStyle = labelTextStyle ?? _labelTextStyle;
    _labelAndRadioButtonAlign = labelAndRadioButtonAlign ?? _labelAndRadioButtonAlign;
    _radioButtonsAlign = radioButtonsAlign ?? _radioButtonsAlign;
  }

  RadioButtonConfiguration setConfiguration({TextStyle? textStyle,
    LabelAndRadioButtonAlign? labelAndRadioButtonAlign,
   LabelAndRadioButtonAlign? radioButtonsAlign,
    Widget? rightArrow,InputBorder? border,bool? enableLabel,TextStyle? labelTextStyle,TextStyle? selectedTextStyle,Color? iconEnabledColor,Color? iconDisabledColor,Color? selectedItemHighlightColor,BoxDecoration? buttonDecoration,BoxDecoration? dropdownDecoration,double? iconSize,double? itemHeight,double? buttonHeight,double? buttonWidth,EdgeInsetsGeometry? buttonPadding,EdgeInsetsGeometry? itemPadding,int? buttonElevation,int? dropdownElevation}) {
    return RadioButtonConfiguration(
      labelTextStyle : labelTextStyle ?? _labelTextStyle,
      labelAndRadioButtonAlign : labelAndRadioButtonAlign ?? _labelAndRadioButtonAlign,
      radioButtonsAlign : radioButtonsAlign ?? _radioButtonsAlign,
    );
  }

  set setLabelTextStyle (TextStyle value){
    _labelTextStyle = value;
  }

  set setLabelAndRadioButtonAlign (LabelAndRadioButtonAlign value){
    _labelAndRadioButtonAlign = value;
  }


}
RadioButtonConfiguration radioButtonConfiguration = RadioButtonConfiguration();

