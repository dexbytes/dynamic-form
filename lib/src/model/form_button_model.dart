class FormButtonModel {
  String? elementType;
  ElementConfig? elementConfig;
  String? value;
  bool? valid;
  bool? onchange;

  FormButtonModel(
      {this.elementType,
        this.elementConfig,
        this.value,
        this.valid,
        this.onchange});

  FormButtonModel.fromJson(Map<String, dynamic> json) {
    elementType = json['elementType'];
    elementConfig = json['elementConfig'] != null
        ? new ElementConfig.fromJson(json['elementConfig'])
        : null;
    value = json['value'];
    valid = json['valid'];
    onchange = json['onchange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['elementType'] = this.elementType;
    if (this.elementConfig != null) {
      data['elementConfig'] = this.elementConfig!.toJson();
    }
    data['value'] = this.value;
    data['valid'] = this.valid;
    data['onchange'] = this.onchange;
    return data;
  }
}

class ElementConfig {
  String? type;
  String? name;
  String? label;
  bool? enableLabel;
  bool? resetIcon;
  int? minLine;
  int? maxLine;
  String? textCapitalization;

  ElementConfig(
      {this.type,
        this.name,
        this.label,
        this.enableLabel,
        this.resetIcon,
        this.minLine,
        this.maxLine,
        this.textCapitalization});

  ElementConfig.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    label = json['label'];
    enableLabel = json['enableLabel'];
    resetIcon = json['resetIcon'];
    minLine = json['minLine'];
    maxLine = json['maxLine'];
    textCapitalization = json['textCapitalization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['name'] = this.name;
    data['label'] = this.label;
    data['enableLabel'] = this.enableLabel;
    data['resetIcon'] = this.resetIcon;
    data['minLine'] = this.minLine;
    data['maxLine'] = this.maxLine;
    data['textCapitalization'] = this.textCapitalization;
    return data;
  }
}