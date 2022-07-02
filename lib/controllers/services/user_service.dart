import 'dart:convert';

import 'package:activos_app/controllers/providers/server_provider.dart';
import 'package:activos_app/controllers/services/shared_preference.dart';
import 'package:activos_app/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<UserModel?> getUser() async {
    final urlPrincipal = ServerProvider().url;
    final token = SharedPreferencesMemory().obtenerToken();
    final url = Uri.parse(urlPrincipal + '/api/obtenerUser');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (200 == response.statusCode) {
      final respuesta = jsonDecode(response.body);
      // print('aeea');
      // print(respuesta);
      return UserModel.fromJson(respuesta['data']);
    } else {
      return null;
    }
  }
}
