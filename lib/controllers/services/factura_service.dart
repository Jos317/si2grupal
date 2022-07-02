import 'dart:convert';

import 'package:activos_app/controllers/providers/server_provider.dart';
import 'package:activos_app/controllers/services/shared_preference.dart';
import 'package:activos_app/models/factura_model.dart';
import 'package:http/http.dart' as http;

class FacturasService {
  static Future<List<FacturaModel>> getFacturas() async {
    final urlPrincipal = ServerProvider().url;
    final token = SharedPreferencesMemory().obtenerToken();
    final url = Uri.parse(urlPrincipal + '/api/obtenerFacturas');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (200 == response.statusCode) {
      final respuesta = jsonDecode(response.body);
      // print('aeea');
      final List<FacturaModel> facturas = facturaModelFromJson(jsonEncode(respuesta['data']));
      // print(respuesta['data']);
      return facturas;
    } else {
      return List.empty();
    }
  }
}