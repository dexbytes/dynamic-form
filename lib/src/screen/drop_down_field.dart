//for Restaurant type dropdown
part of dynamic_json_form;

class DropDown extends StatefulWidget {
  final List<Options>? optionList;
  final String? hint;
  final Map<String,dynamic> jsonData;
  final Function (String fieldKey,List<String> fieldValue) onChangeValue ;

  const DropDown({Key? key,required this.jsonData,required this.onChangeValue,
    this.optionList = const [],
    this.hint,
  }) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState(optionList: this.optionList,jsonData: jsonData,onChangeValue: onChangeValue);
}

class _DropDownState extends State<DropDown> {
  String? valueChoose;
  List<Options>? optionList;
  DropDownModel? dropDownModel;
  Map<String, dynamic> jsonData;

  bool isMultipleSelect = false;
  bool isInline = false;
  final _dropDownKey = GlobalKey<FormState>();
  String fieldKey = "";
  String label = "";
  String placeholder = "";
  List<String> value = const [];
  List<String>? selectedOption = [];

  Function (String fieldKey,List<String> fieldValue) onChangeValue ;
  _DropDownState(
      {required this.jsonData,this.optionList,required this.onChangeValue}) {
    dropDownModel ??= responseParser.dropDownFormFiledParsing(
        jsonData: jsonData, updateCommon: true);
    setValues(dropDownModel);
  }
/*
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];*/

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child:
      /*DropdownButtonHideUnderline(key: _dropDownKey,
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: const [
              Icon(
                Icons.list,
                size: 16,
                color: Colors.yellow,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  'Select Item',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),dropdownOverButton:true,
          items: optionList!.map((option) => buildMenuItem(option)).toList()*//*items
              .map((item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ))
              .toList()*//*,
          value: valueChoose,
          onChanged: (value) {
            setState(() {
              valueChoose = value as String;
            });
          },
          icon: const Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconEnabledColor: Colors.yellow,
          iconDisabledColor: Colors.grey,
          buttonHeight: 50,
         // buttonWidth: 160,
          buttonPadding: const EdgeInsets.only(left: 14, right: 14),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: Colors.redAccent,
          ),
          buttonElevation: 2,
          itemHeight: 40,
          itemPadding: const EdgeInsets.only(left: 14, right: 14),
          dropdownMaxHeight: 200,
          dropdownWidth: 200,
          dropdownPadding: null,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.redAccent,
          ),
          dropdownElevation: 8,
          scrollbarRadius: const Radius.circular(40),
          scrollbarThickness: 6,
          scrollbarAlwaysShow: true,
          offset: const Offset(-20, 0),
        ),
      )*/
      DropdownButtonNew<String>(key: _dropDownKey,
        dropdownOverButton:true,
          alignment: AlignmentDirectional.centerStart,
          iconEnabledColor: Colors.grey,
          icon: const Icon(Icons.keyboard_arrow_down),
          iconSize: 28,
          elevation: 0,
          isExpanded: true,dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.grey.withOpacity(0.8),
        ),
          underline: Container(
            height: 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.redAccent,
            ),
          ),
          dropdownColor: Colors.red,
          // dropdownColor: !isDarkMode? Colors.grey.shade300 : Color(0xff212327),
          // alignment: Alignment.bottomCenter,
          borderRadius: BorderRadius.circular(8),
          hint: Text(widget.hint ??
              "" /*appString.trans(context, appString.restaurantType),style: appStyles.hintTextStyle()*/),
          isDense: false,
        focusColor: Colors.red,
          value: valueChoose,
          items: optionList!.map((option) => buildMenuItem(option)).toList(),
          onChanged: (value) =>
              setState(() {
               //// valueChoose = value;
              }),
      ),
    );
  }

  DropdownMenuItemNew<String> buildMenuItem(Options option) {
    String value = option.value!;/*
    String item = option.displayValue!;
    bool isChecked = selectedOption!.contains(value)?true:option.checked!;*/

    return DropdownMenuItemNew(value: value,
        enabled: false,
        child: Column(mainAxisSize: MainAxisSize.min,
          children: [
            DropdownRowItem(isMultipleSelect: isMultipleSelect,option: option, onClicked: (bool isChecked) {
              if(!isChecked){
                valueChoose = value;
                _onSelect(value: value);
              }
              else{
                _onUnSelect(value: value);
              }
              _returnValue();
             // _dropDownKey.currentState!.deactivate();
            }, selectedOption: selectedOption,),
            /*!isMultipleSelect?Container():TextButton(
              onPressed: () async {

              },
              child: const Text('Done'),
             // b: Colors.green,
            )*/
          ],
        )
        /*InkWell(onTap: (){
          *//*setState(() {
            isChecked = !isChecked;
          });*//*
          debugPrint("Item Click $isChecked");
          if(!isChecked){
          _onSelect(value: value);
          }
          else{
            _onUnSelect(value: value);
          }
          isChecked = !isChecked;

        },
          child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.start,mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  item,
                  //style: appStyles.hintTextStyle()
                ),
              ),
              !isMultipleSelect?Container():CheckBoxCustom(checkStatus: isChecked,onClicked: (value){

              },)
            ],
          ),
        )*/
    );
  }

  //Initial value set
  void setValues(DropDownModel? dropDownModel) {
    if (dropDownModel != null) {

      if (dropDownModel.elementConfig != null) {
        fieldKey = dropDownModel.elementConfig!.name!;
        label = dropDownModel.elementConfig!.label!;
        placeholder = dropDownModel.elementConfig!.placeholder!;

        isMultipleSelect = dropDownModel.elementConfig!.isMultipleSelect??false;
        isInline = dropDownModel.elementConfig!.isInline??false;
        value = const [];
        if (dropDownModel.elementConfig!.options!.isNotEmpty) {
          optionList = dropDownModel.elementConfig!.options!.map((e) => Options(value: e.value,displayValue: e.displayValue,checked: e.checked)).toList();
        }
        onChangeValue.call(fieldKey,selectedOption!);
      }
    }
  }

  /*Call action when click on any item*/
  void _onSelect({String? value = "", String? displayValue = ""}){
    if(value!.trim().isNotEmpty){
      selectedOption!.add(value.trim());
      setState(() {});
    }
    else if(displayValue!.trim().isNotEmpty){
      int idTemp = optionList!.indexWhere((element) => element.displayValue==displayValue);
      if(idTemp!=-1){
        value = optionList![idTemp].value;
      }
      selectedOption!.add(value!.trim());
      setState(() {});
    }
    else{
      debugPrint("Please attlist one value");
    }
  }
  /*Call action when click on any item*/
  void _onUnSelect({String? value = "", String? displayValue = ""}){
    if(value!.trim().isNotEmpty){
      selectedOption!.remove(value.trim());
      setState(() {});
    }
    else if(displayValue!.trim().isNotEmpty){
      int idTemp = optionList!.indexWhere((element) => element.displayValue==displayValue);
      if(idTemp!=-1){
        value = optionList![idTemp].value;
      }
      selectedOption!.remove(value!.trim());
      setState(() {});
    }
    else{
      debugPrint("Please attlist one value");
    }
  }

  void _returnValue(){
    if(!isMultipleSelect){
      Navigator.pop(_dropDownKey.currentContext!);
      }
    onChangeValue.call(fieldKey,selectedOption!);
  }
}


class Options {
  String? value;
  String? displayValue;
  bool? checked;

  Options({this.value, this.displayValue,this.checked = false});

  Options.fromJson(Map<String, dynamic> json) {
    value = json.containsKey('value')?json['value']:"";
    displayValue = json.containsKey('displayValue')?json['displayValue']:"";
    checked = json.containsKey('checked')?json['checked']:false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['displayValue'] = this.displayValue;
    data['checked'] = this.checked;
    return data;
  }
}

class DropdownRowItem extends StatefulWidget {
  final Options option;
  final Function(bool)? onClicked;
  final List<String>? selectedOption;
  final bool isMultipleSelect;

  const DropdownRowItem({Key? key,required this.option,required this.selectedOption,required this.onClicked,this.isMultipleSelect = false}) : super(key: key);

  @override
  _DropdownRowItemState createState() => _DropdownRowItemState(onClicked: onClicked,option: this.option, selectedOption: this.selectedOption);
}

class _DropdownRowItemState extends State<DropdownRowItem> {
  Function(bool)? onClicked;
  Options option;
  List<String>? selectedOption;
  String value = "";
  String item = "";
  bool isChecked = false;

  _DropdownRowItemState({required this.option,required this.selectedOption,required this.onClicked}){
    value = option.value!;
    item = option.displayValue!;
    isChecked = selectedOption!.contains(value)?true:option.checked!;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DropdownRowItem oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    setState(() {
      if (widget.selectedOption != null) {
        // checkStatus = widget.checkStatus;
        selectedOption = widget.selectedOption;
        isChecked = selectedOption!.contains(value)?true:option.checked!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.center,
        child:InkWell(onTap: (){
      if(mounted){
        setState(() {
          isChecked = !isChecked;
        });
      }
      onClicked?.call(!isChecked);
    },
      child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.start,mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Align(alignment: Alignment.centerLeft,
              child: Text(
                item,
                //style: appStyles.hintTextStyle()
              ),
            ),
          ),
          !widget.isMultipleSelect?Container():Checkbox(value: isChecked, onChanged: (value){
            setState(() {
              isChecked = !isChecked;
            });
            onClicked?.call(!isChecked);
          })
        ],
      ),
    ));
  }
}