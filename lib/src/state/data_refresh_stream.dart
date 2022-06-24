
import 'dart:async';

class DataRefreshStream {
  DataRefreshStream._internal();
  static final DataRefreshStream instance = DataRefreshStream._internal();

  //Inbox Stream
  StreamController<dynamic> firebaseLoggedDataStreamBroadcast = StreamController<dynamic>.broadcast();
  StreamController<dynamic> charRoomAppBarStreamBroadcast = StreamController<dynamic>.broadcast();
  StreamController<dynamic> charRoomAppDeleteBarStreamBroadcast = StreamController<dynamic>.broadcast();

  //get getNotificationBroadcast => _firebaseNotificationStreamBroadcast;


  //Inbox Stream
  StreamController<dynamic> _inboxStreamController =
      StreamController<dynamic>();

  StreamController<dynamic> get inboxStream {
    _inboxStreamController = StreamController<dynamic>();
    return _inboxStreamController;
  }
  void inboxRefresh(dynamic userData) {
    _inboxStreamController.sink.add(userData);
  }
  void disposeInboxStreamController() {
    _inboxStreamController.close();
    inboxStreamBroadcast.close();
  }
  StreamController<dynamic> inboxStreamBroadcast =
      StreamController<dynamic>.broadcast();

  StreamController<dynamic> emptyInboxStreamBroadcast =
      StreamController<dynamic>.broadcast();

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
