import 'dart:convert';

import 'package:activos_app/controllers/providers/server_provider.dart';
import 'package:activos_app/controllers/services/shared_preference.dart';
import 'package:activos_app/models/activo_model.dart';
import 'package:activos_app/models/activos_model.dart';
import 'package:http/http.dart' as http;

class ActivosService {
  static Future<List<ActivoModel>> getActivos() async {
    final urlPrincipal = ServerProvider().url;
    final token = SharedPreferencesMemory().obtenerToken();
    final url = Uri.parse(urlPrincipal + '/api/obtenerActivos');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (200 == response.statusCode) {
      final respuesta = jsonDecode(response.body);
      // print('aeea');
      final List<ActivoModel> activos =
          activoModelFromJson(jsonEncode(respuesta['data']));
      // print(respuesta['data']);
      return activos;
    } else {
      return List.empty();
    }
  }

  static Future<ActivosModel?> getActivo(String codigo, int id) async {
    var params = {"id": id.toString(), "codigo": codigo};
    final urlPrincipal = ServerProvider().url;
    final token = SharedPreferencesMemory().obtenerToken();
    final url = Uri.parse(urlPrincipal + '/api/obtenerActivo');
    final urlP = url.replace(queryParameters: params);
    final response = await http.get(urlP, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (200 == response.statusCode) {
      final respuesta = jsonDecode(response.body);
      // print('aeea');
      final ActivosModel activo =
          activosModelFromJson(jsonEncode(respuesta['data']));
      // print(respuesta['data']);
      return activo;
    } else {
      return null;
    }
  }
}
