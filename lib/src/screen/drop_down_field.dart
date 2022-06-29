//for Restaurant type dropdown
part of dynamic_json_form;

class DropDown extends StatefulWidget {
  final List<String> itemList;
  final String? hint;
  final Function? selectedValue;
  final Map<String,dynamic> jsonData;
  final Function (String fieldKey,String fieldValue) onChangeValue ;

  const DropDown({Key? key,required this.jsonData,required this.onChangeValue,
    required this.itemList,
    this.hint,this.selectedValue
  }) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState(restaurantTypeList: this.itemList);
}

class _DropDownState extends State<DropDown> {
  String? valueChoose;
  List<String>? restaurantTypeList;

  _DropDownState({this.restaurantTypeList});

  @override
  Widget build(BuildContext context) {


    return Container(
      height: 50,
      padding: EdgeInsets.only(right: 6),
      margin: EdgeInsets.only(
          left: 20,right: 20,
          top: 0,
          bottom: 0
      ),
      decoration: BoxDecoration(
        color:Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: DropdownButton<String> (
            alignment: AlignmentDirectional.centerStart,
            iconEnabledColor:Colors.grey ,
            icon: Icon(Icons.keyboard_arrow_down),
            iconSize: 28,
            elevation: 0,
            isExpanded: true,
            underline:Container(
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
            hint: Text( widget.hint ??"" /*appString.trans(context, appString.restaurantType),style: appStyles.hintTextStyle()*/),
            isDense: false,
            value: valueChoose,
            items: restaurantTypeList!.map(buildMenuItem).toList(),
            onChanged: (value) => setState(() {
              this.valueChoose = value;
              widget.selectedValue?.call(value);
            })
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
        value:item,
        child: Text(
            item,
            //style: appStyles.hintTextStyle()
        )
    );}

}
