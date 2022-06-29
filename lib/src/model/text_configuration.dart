// import 'package:flutter/material.dart';
export 'package:flutter/material.dart';
import '../../dynamic_json_form.dart';

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
  InputBorder? border = const OutlineInputBorder();
  TextStyle? textStyle = const TextStyle();
  TextStyle? hintStyle = const TextStyle();
  StrutStyle? strutStyle = const StrutStyle();
  TextDirection? textDirection;
  TextAlign textAlign = TextAlign.start;
  TextAlignVertical? textAlignVertical;
  TextFieldConfiguration({this.textStyle,this.hintStyle,this.border});

  TextFieldConfiguration setConfiguration({TextStyle? textStyle,TextStyle? hintStyle,InputBorder? border}) {
    return TextFieldConfiguration(
        textStyle : textStyle ?? this.textStyle,
        hintStyle : hintStyle ?? this.hintStyle,
        border : border ?? this.border,
    );
}
}
TextFieldConfiguration textFieldConfiguration = TextFieldConfiguration();

