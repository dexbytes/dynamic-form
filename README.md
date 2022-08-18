# Dynamic form

A flutter package that render dynamic form wit different input field which is manage from API json response. This plugin supports both iOS and Android.

|               | Android   | iOS    |
| :-------------| :---------| :------|
| **Support**   | SDK 21+   | 10.0+  |

# Dynamic form Implementation Guide

## Features

Use this plugin in your Flutter app to:

* To manage dynamic from filed from server according to filed type.
* Auto manage field validation according to field type.
* Easy to manage field decoration by developers.

## Getting started

This plugin relies on the flutter core.

## Usage

To use the plugin you just need to add dynamic_form: ^1.0.0 into your pubspec.yaml file and run pub get.


#Images


## Add following into your package's pubspec.yaml (and run an implicit dart pub get):
dynamic_form: ^1.0.0

## Example

            Column(
             children: [
            //Get all fields of form
                   DynamicFormScreen(jsonString,dynamicFormKey: _formKeyNew, finalSubmitCallBack: (Map<String, dynamic> data) async {
                   Navigator.push(
                   context,MaterialPageRoute(builder: (context) => SecondScreen(data: data)),);},),
                Align(alignment: Alignment.center,
                  child: ElevatedButton(clipBehavior: Clip.hardEdge,
                    onPressed: () async {
                      if(_formKeyNew.currentState!.validateFields()){
                     var data =  _formKeyNew.currentState!.getFormData();
                     if(data!.isNotEmpty){
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => SecondScreen(data: data)),
                       );
                     }
                     }
                    },
                    child: const Text('Submit Form'),
                    //color: Colors.green,
                  ),
                )
              ],
            )

## Changelog

All notable changes to this project will be documented in [this file](./CHANGELOG.md).

## Issues

To report your issues, submit them directly in the [Issues](https://github.com/dexbytes/dynamic-form/issues) section.

## License

[Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0)