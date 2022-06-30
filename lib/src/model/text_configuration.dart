// import 'package:flutter/material.dart';
part of dynamic_json_form;

class TextFieldConfiguration {
  /// The shape of the border to draw around the decoration's container.
  ///
  /// If [border] is a [MaterialStateUnderlineInputBorder]
  /// or [MaterialStateOutlineInputBorder], then the effective border can depend on
  /// the [MaterialState.focused] state, i.e. if the [TextField] is focused or not.
  ///
  /// If [border] derives from [InputBorder] the border's [InputBorder.borderSide],
  /// i.e. the border's color and width, will be overridden to reflect the input
  /// decorator's state. Only the border's shape is used. If custom  [BorderSide]
  /// values are desired for  a given state, all four borders – [errorBorder],
  /// [focusedBorder], [enabledBorder], [disabledBorder] – must be set.
  ///
  /// The decoration's container is the area which is filled if [filled] is
  /// true and bordered per the [border]. It's the area adjacent to
  /// [InputDecoration.icon] and above the widgets that contain
  /// [InputDecoration.helperText], [InputDecoration.errorText], and
  /// [InputDecoration.counterText].
  ///
  /// The border's bounds, i.e. the value of `border.getOuterPath()`, define
  /// the area to be filled.
  ///
  /// This property is only used when the appropriate one of [errorBorder],
  /// [focusedBorder], [focusedErrorBorder], [disabledBorder], or [enabledBorder]
  /// is not specified. This border's [InputBorder.borderSide] property is
  /// configured by the InputDecorator, depending on the values of
  /// [InputDecoration.errorText], [InputDecoration.enabled],
  /// [InputDecorator.isFocused] and the current [Theme].
  ///
  /// Typically one of [UnderlineInputBorder] or [OutlineInputBorder].
  /// If null, InputDecorator's default is `const UnderlineInputBorder()`.
  ///
  /// See also:
  ///
  ///  * [InputBorder.none], which doesn't draw a border.
  ///  * [UnderlineInputBorder], which draws a horizontal line at the
  ///    bottom of the input decorator's container.
  ///  * [OutlineInputBorder], an [InputDecorator] border which draws a
  ///    rounded rectangle around the input decorator's container.
  late InputBorder? _border =  const OutlineInputBorder();
  late InputBorder? _errorBorder =  const OutlineInputBorder();
  late TextStyle? _textStyle =  const TextStyle();
  late TextStyle? _hintStyle =  const TextStyle();
  late StrutStyle? _strutStyle =  const StrutStyle();
  late TextDirection? _textDirection = TextDirection.ltr;
  late TextAlign? _textAlign = TextAlign.start;
  late TextAlignVertical? _textAlignVertical = TextAlignVertical.center;

  TextFieldConfiguration({TextStyle? textStyle,TextStyle? hintStyle,InputBorder? border});

  TextFieldConfiguration setConfiguration({TextStyle? textStyle,TextStyle? hintStyle,InputBorder? border}) {
    return TextFieldConfiguration(
        textStyle : textStyle ?? _textStyle,
        hintStyle : hintStyle ?? _hintStyle,
        border : border ?? _border,
    );
}
  set setBorder (value){
    _border = value;
  }

  set setTextStyle (value){
    _textStyle = value;
  }
  set setHintStyle (value){
    _hintStyle = value;
  }
  set setStrutStyle (value){
    _strutStyle = value;
  }
  set setTextDirection (value){
    _textDirection = value;
  }
}
TextFieldConfiguration textFieldConfiguration = TextFieldConfiguration();

