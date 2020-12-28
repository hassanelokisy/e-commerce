import 'package:flutter/cupertino.dart';

class ModelHub extends ChangeNotifier{ 
  bool isLoading = false ;
  
  void changeState(bool value){
    isLoading = value ;
    notifyListeners();
  } 
}