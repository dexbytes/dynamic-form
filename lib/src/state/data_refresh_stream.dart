import 'dart:async';

class DataRefreshStream {
  DataRefreshStream._internal();
  static final DataRefreshStream instance = DataRefreshStream._internal();

  //Message List Stream
  StreamController<List<dynamic>> _formFieldStreamController =
      StreamController<List<dynamic>>();

  StreamController<List<dynamic>> get getFormFieldsStream {
    _formFieldStreamController = StreamController<List<dynamic>>();
    return _formFieldStreamController;
  }

  void formFieldsRefresh(List<dynamic> userData) {
    print("?????????????????????? $userData");
    _formFieldStreamController.sink.add(userData);
  }

  void disposeMessageListStreamController() {
    _formFieldStreamController.close();
  }

}
