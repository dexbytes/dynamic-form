part of dynamic_json_form;

class RadioButton extends StatefulWidget {
  final List<Options>? optionList;
  final String? hint;
  final Map<String,dynamic> jsonData;
  final RadioButtonConfiguration? viewConfiguration;
  final Function (String fieldKey,List<String> fieldValue) onChangeValue ;

  const RadioButton({Key? key,required this.jsonData,required this.onChangeValue,
    this.optionList = const [],
    this.hint,this.viewConfiguration
  }) : super(key: key);

  @override
//  _RadioButtonState createState() => _RadioButtonState();
  _RadioButtonState createState() => _RadioButtonState(optionList: this.optionList,jsonData: jsonData,onChangeValue: onChangeValue,viewConfiguration:viewConfiguration);

}
enum ButtonsAlignment{VERTICAL, HORIZONTAL}

class _RadioButtonState extends State<RadioButton> {
  String? valueChoose;
  String? buttonHead = "Select Item";
  List<Options>? optionList;
  List<String> displayList = [];
  RadioButtonModel? radioButtonModel;
  Map<String, dynamic> jsonData;
  RadioButtonConfiguration? viewConfiguration;
  bool isMultipleSelect = false;
  bool isInline = false;
  String fieldKey = "";
  String label = "";
  bool enableLabel = true;
  String placeholder = "";
  String value = "";
  List<String>? selectedOption = [];
  String _verticalGroupValue = "Pending";


  Function (String fieldKey,List<String> fieldValue) onChangeValue ;
  _RadioButtonState(
      {required this.jsonData,this.optionList,required this.onChangeValue,this.viewConfiguration}) {
    radioButtonModel ??= responseParser.radioButtonFormFiledParsing(
        jsonData: jsonData, updateCommon: true);


    setValues(radioButtonModel,jsonData);

  }

  //Initial value set
  void setValues(RadioButtonModel? radioButtonModel, Map<String, dynamic> jsonData) {

    viewConfiguration  = viewConfiguration ?? ConfigurationSetting.instance._radioButtonConfiguration;

    if (radioButtonModel != null) {
      try {
        enableLabel = jsonData['elementConfig']['enableLabel'];
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      if (radioButtonModel.elementConfig != null) {
        fieldKey = radioButtonModel.elementConfig!.name!;
        label = radioButtonModel.elementConfig!.label!;
        placeholder = radioButtonModel.elementConfig!.placeholder!;

        isMultipleSelect = radioButtonModel.elementConfig!.isMultipleSelect??false;
        isInline = radioButtonModel.elementConfig!.isInline??false;
        value = radioButtonModel.value??"";

        if (radioButtonModel.elementConfig!.options!.isNotEmpty) {
          optionList = radioButtonModel.elementConfig!.options!.map((e) => Options(value: e.value,displayValue: e.displayValue,checked: e.checked)).toList();
          optionList!.map((e) => displayList.add(e.displayValue!)).toList();
          if(value.isNotEmpty){
           // _onSelect(isInit: true,displayValue: value);
          }
        }
       // onChangeValue.call(fieldKey,selectedOption!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var radioButtonAlignment = viewConfiguration!._radioButtonsAlign == LabelAndRadioButtonAlign.horizontal?Axis.horizontal:Axis.vertical;

    Widget label =  Text(radioButtonModel!.elementConfig!.label??'',style: viewConfiguration!._labelTextStyle);

    Widget radioButtons = RadioGroup<String>.builder(
      direction: radioButtonAlignment,
      groupValue: _verticalGroupValue,
      spacebetween: 30,
      horizontalAlignment: MainAxisAlignment.start,
      onChanged: (value) => setState(() {
        _verticalGroupValue = value as String;
        optionList!.map((e){
          if(e.displayValue == value){
            selectedOption = [];
            selectedOption!.add(e.value!.toString());
          }
        }).toList();
        onChangeValue.call(fieldKey,selectedOption!);
      }),
      items: displayList,
      itemBuilder: (item) => RadioButtonBuilder(item),
      activeColor: Colors.red,
    );

    return LabelAndRadioButtonAlign.vertical == viewConfiguration!._labelAndRadioButtonAlign?Row(
      children: [
       Flexible( child:Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisSize: MainAxisSize.min,
         children: [
           label,
           const SizedBox(height: 3,),
           radioButtons
         ],))
      ],
    ):Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
      Padding(
        padding: const EdgeInsets.only(top:5.0),
        child: label,
      ),
      const SizedBox(width: 15,),
      Expanded(child: radioButtons,)
    ],);
  }
}

enum RadioButtonTextPosition { right, left, }
class RadioButtonBuilder<T> {
  final String description;
  final RadioButtonTextPosition? textPosition;

  RadioButtonBuilder(
      this.description, {
        this.textPosition,
      });
}

class RadioGroup<T> extends StatelessWidget {
  /// Creates a [RadioButton] group
  ///
  /// The [groupValue] is the selected value.
  /// The [items] are elements to contruct the group
  /// [onChanged] will called every time a radio is selected. The clouser return the selected item.
  /// [direction] most be horizontal or vertial.
  /// [spacebetween] works only when [direction] is [Axis.vertical] and ignored when [Axis.horizontal].
  /// and represent the space between elements
  /// [horizontalAlignment] works only when [direction] is [Axis.horizontal] and ignored when [Axis.vertical].
  final T groupValue;
  final List<T> items;
  final RadioButtonBuilder Function(T value) itemBuilder;
  final void Function(T?)? onChanged;
  final Axis direction;
  final double spacebetween;
  final MainAxisAlignment horizontalAlignment;
  final Color? activeColor;
  final TextStyle? textStyle;

  const RadioGroup.builder({
    required this.groupValue,
    required this.onChanged,
    required this.items,
    required this.itemBuilder,
    this.direction = Axis.vertical,
    this.spacebetween = 20,
    this.horizontalAlignment = MainAxisAlignment.start,
    this.activeColor,
    this.textStyle,
  });

  List<Widget> get _group => this.items.map(
        (item) {
      final radioButtonBuilder = this.itemBuilder(item);

      return Container(
          height: this.direction == Axis.vertical ? this.spacebetween : 30.0,
          child: RadioButtonwidget(
            description: radioButtonBuilder.description,
            value: item,
            groupValue: this.groupValue,
            onChanged: this.onChanged,
            textStyle: textStyle,
            textPosition: radioButtonBuilder.textPosition ??
                RadioButtonTextPosition.right,
            activeColor: activeColor,
          )
      );
    },
  ).toList();

  @override
  Widget build(BuildContext context) => this.direction == Axis.vertical
      ? Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: _group,
  )
      :
        Wrap(children:_group
  );
}

class RadioButtonwidget<T> extends StatelessWidget {
   final String description;
   final T value;
   final T groupValue;
   final void Function(T?)? onChanged;
   final RadioButtonTextPosition textPosition;
   final Color? activeColor;
   final TextStyle? textStyle;

  const RadioButtonwidget({
    Key? key,
    required this.description,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.textPosition = RadioButtonTextPosition.right,
    this.activeColor,
    this.textStyle,
  }): super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () {
      if (this.onChanged != null) {
        this.onChanged!(value);
      }
    },
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: this.textPosition == RadioButtonTextPosition.right
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      children: <Widget>[
        this.textPosition == RadioButtonTextPosition.left
            ? Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            this.description,
            style: this.textStyle,
            textAlign: TextAlign.left,
          ),
        )
            : Container(),

            SizedBox(
              height:40,
              width:30,
              child: Radio<T>(
              visualDensity: VisualDensity.standard,
              groupValue: groupValue,
              onChanged: this.onChanged,
              value: this.value,
              activeColor: activeColor,
              //  splashRadius: 10.0,
              // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),),

        this.textPosition == RadioButtonTextPosition.right
            ? Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            this.description,
            style: this.textStyle,
            textAlign: TextAlign.right,
          ),
        )
            : Container(),
      ],
    ),
  );
}