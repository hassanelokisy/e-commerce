import 'package:flutter/cupertino.dart';

class AdminMode extends ChangeNotifier{
  bool isAdmin = false ;
  void changeAdminState(bool value){
    isAdmin = value ;
    notifyListeners();
  }
}