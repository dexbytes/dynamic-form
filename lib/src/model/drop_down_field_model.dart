class DropDownModel {
  String? elementType;
  ElementConfig? elementConfig;
  String? value;
  Validation? validation;
  bool? valid;

  DropDownModel({this.elementType, this.elementConfig, this.value, this.validation, this.valid});

  DropDownModel.fromJson(Map<String, dynamic> json) {
    elementType = json['elementType'];
    elementConfig = json['elementConfig'] != null ?  ElementConfig.fromJson(json['elementConfig']) : null;
    value = json['value'];
    validation = json['validation'] != null ?  Validation.fromJson(json['validation']) : null;
    valid = json['valid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['elementType'] = this.elementType;
    if (this.elementConfig != null) {
      data['elementConfig'] = this.elementConfig!.toJson();
    }
    data['value'] = this.value;
    if (this.validation != null) {
      data['validation'] = this.validation!.toJson();
    }
    data['valid'] = this.valid;
    return data;
  }
}

class ElementConfig {
  String? name;
  String? label;
  String? placeholder;
  String? classProperty;
  List<Options>? options;
  bool? isMultipleSelect;
  bool? isInline;

  ElementConfig({this.name, this.label, this.placeholder, this.classProperty, this.options, this.isMultipleSelect = false,this.isInline = false});

  ElementConfig.fromJson(Map<String, dynamic> json) {
  name = json['name'];
  label = json['label'];
  placeholder = json['placeholder'];
  classProperty = json.containsKey('class')?json['class']:"";
  if (json['options'] != null) {
  options = <Options>[];
  json['options'].forEach((v) { options!.add(new Options.fromJson(v)); });
  }
  isMultipleSelect = json.containsKey('isMulitpleSelect')?json['isMulitpleSelect']:false;
  isInline = json.containsKey('isInline')?json['isInline']:false;
  }
  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data =  Map<String, dynamic>();
  data['name'] = this.name;
  data['label'] = this.label;
  data['placeholder'] = this.placeholder;
  data['class'] = this.classProperty;
  if (this.options != null) {
  data['options'] = this.options!.map((v) => v.toJson()).toList();
  }
  data['isMultipleSelect'] = this.isMultipleSelect;
  data['isInline'] = this.isInline;
  return data;
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

class Validation {
  bool? required;
  bool? isReadOnly;
  bool? isDisabled;

  Validation({this.required, this.isReadOnly, this.isDisabled});

  Validation.fromJson(Map<String, dynamic> json) {
    required = json['required'];
    isReadOnly = json['isReadOnly'];
    isDisabled = json['isDisabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['required'] = this.required;
    data['isReadOnly'] = this.isReadOnly;
    data['isDisabled'] = this.isDisabled;
    return data;
  }
}