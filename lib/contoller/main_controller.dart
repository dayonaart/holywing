import 'package:flutter/material.dart';

class MainController extends ChangeNotifier {
  int sendProgress = 0;
  void onSendProgresss(int send, int total) {
    var _send = ((send / total) * 100).toInt();
    // print("SEND $_send");
    sendProgress = _send;
    notifyListeners();
  }

  int receiveProgress = 0;
  void onReceiveProgresss(int send, int total) {
    var _receive = ((total / send) * 100).toInt();
    // print("RECEIVE $_receive");
    receiveProgress = _receive;
    notifyListeners();
  }
}
