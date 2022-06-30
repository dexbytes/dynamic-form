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


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(right: 6),
      margin: const EdgeInsets.only(
          left: 0, right: 0,
          top: 0,
          bottom: 0
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: DropdownButton<String>(key: _dropDownKey,
            alignment: AlignmentDirectional.centerStart,
            iconEnabledColor: Colors.grey,
            icon: const Icon(Icons.keyboard_arrow_down),
            iconSize: 28,
            elevation: 0,
            isExpanded: true,buildMenuItem:(){

            },
            underline: Container(
              height: 0.0,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFBDBDBD),
                    width: 0.01,
                  ),
                ),
              ),
            ),
            dropdownColor: Colors.grey,
            // dropdownColor: !isDarkMode? Colors.grey.shade300 : Color(0xff212327),
            // alignment: Alignment.bottomCenter,
            borderRadius: BorderRadius.circular(8),
            hint: Text(widget.hint ??
                "" /*appString.trans(context, appString.restaurantType),style: appStyles.hintTextStyle()*/),
            isDense: false,
            value: valueChoose,
            items: optionList!.map((option) => buildMenuItem(option)).toList(),
            onChanged: (value) =>
                setState(() {
                  valueChoose = value;
                })
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(Options option) {
    String value = option.value!;/*
    String item = option.displayValue!;
    bool isChecked = selectedOption!.contains(value)?true:option.checked!;*/

    return DropdownMenuItem(
        value: value,
        enabled: false,
        child: Column(
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

        isMultipleSelect = true;//dropDownModel.elementConfig!.isMultipleSelect??false;
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
    return InkWell(onTap: (){
      setState(() {
        isChecked = !isChecked;
      });
      onClicked?.call(!isChecked);
    },
      child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.start,mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Text(
              item,
              //style: appStyles.hintTextStyle()
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
    );
  }
}