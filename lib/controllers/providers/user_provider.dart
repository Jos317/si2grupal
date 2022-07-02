import 'package:activos_app/controllers/services/user_service.dart';
import 'package:activos_app/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserModel? user = null; 

  setUser() async
  {
    user = await UserService.getUser();
    notifyListeners();
  }

}
