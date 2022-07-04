import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class CountryPicker extends StatelessWidget {
  final String? text;
  final String? initialSelection;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final void Function(CountryCode)?  onChanged;
  final void Function(CountryCode?)?  onInit;
  final List<String> countryFilter;

  const CountryPicker(
      {Key? key,
        this.text,
        this.textStyle,
        this.margin = const EdgeInsets.symmetric(horizontal: 21),
        this.padding = const EdgeInsets.symmetric(horizontal: 21),
        this.initialSelection,
        this.onChanged,
        this.onInit,
        this.countryFilter =  const ['Sa','In'],
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Container(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.only(top: 0,left:9,right: 0),
      child: Stack(
        children: [
          Padding(
            padding: padding,
            child: VerticalDivider(
              width: 10,
              thickness: 1,
              endIndent: 0,
              indent: 0,
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          CountryCodePicker(
            searchDecoration: InputDecoration(
                contentPadding:  const EdgeInsets.all(10),
                prefixIcon: const Icon(Icons.search,color: Colors.grey,),
                hintText: "Search country code",
                hintStyle: const TextStyle(
                  fontSize: 15.5,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,//Color(0xff828588),
                ),
                fillColor:Colors.grey.withOpacity(0.1),
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderSide: const  BorderSide(width: 0.1,color: Colors.grey),
                    borderRadius: BorderRadius.circular(12)),
                enabledBorder:OutlineInputBorder(
                    borderSide: const BorderSide(width: 0.1,color: Colors.grey),
                    borderRadius: BorderRadius.circular(12)),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0.1,color: Colors.grey),
                    borderRadius: BorderRadius.circular(12))
            ),
            dialogSize: Size(queryData.size.width/1.15,queryData.size.height/3.8),
            padding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            countryFilter: countryFilter,
            initialSelection: initialSelection,
            showCountryOnly: false,
            showFlag: true,
            flagWidth: 20,
            showFlagDialog: true,
            showOnlyCountryWhenClosed: false,
            dialogBackgroundColor:Colors.white,
            dialogTextStyle: const TextStyle(
                fontSize: 16,
                color:Colors.black),
            closeIcon: const Icon(Icons.clear,size: 26,color:Colors.black),
            hideSearch: true,
            hideMainText: false,
            textStyle: const TextStyle(fontSize: 15,color:Colors.black),
            onChanged: onChanged,
            onInit:onInit
            // flagWidth: ,
          ),
        ],
      ),
    );
  }
}
