import 'package:activos_app/controllers/providers/server_provider.dart';
import 'package:activos_app/controllers/services/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:activos_app/widgets/helpers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

login(String email, String password, BuildContext context) async {
  mostrarLoading(context);
  final url = ServerProvider().url;
  final response = await http.post(Uri.parse(url + '/api/login'),
      body: {'email': email, 'password': password});
  final respuesta = jsonDecode(response.body);
  // print(respuesta);
  Navigator.pop(context);
  if (200 == response.statusCode) {
    // serverProvider.token = respuesta['token'];
    // SharedPreferencesMemory().setearId(respuesta['data']['id']);
    SharedPreferencesMemory().setearToken(respuesta['token']);
    Navigator.pushReplacementNamed(context, 'user');
  } else {
    final mensajeErroneo = jsonEncode(respuesta['mensaje']);
    mostrarAlerta(context, 'Error', mensajeErroneo);
  }
}

edit(int id, String nombre, String edad, String direccion, String telefono, String email,
      BuildContext context) async {
    mostrarLoading(context);
    final token = SharedPreferencesMemory().obtenerToken();
    final url = ServerProvider().url;
    final response = await http.post(Uri.parse(url + '/api/editUser'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'id': id,
          'nombre': nombre,
          'edad': edad,
          'direccion': direccion,
          'telefono': telefono,
          'email': email,
        }));
    final respuesta = jsonDecode(response.body);
    // print(respuesta);
    Navigator.pop(context);
    // if (200 == response.statusCode) {
    //   // serverProvider.token = respuesta['token'];
    //   Provider.of<ConsultaProvider>(context, listen: false).consultas = null;
    //   Navigator.pushReplacementNamed(context, 'consulta');
    // } else {
    //   final mensajeErroneo = jsonEncode(respuesta['mensaje']);
    //   mostrarAlerta(context, 'Error', mensajeErroneo);
    // }
    if (200 == response.statusCode) {
    // serverProvider.token = respuesta['token'];
    // SharedPreferencesMemory().setearId(respuesta['data']['id']);
    SharedPreferencesMemory().setearToken(respuesta['token']);
    Navigator.pushReplacementNamed(context, 'user');
  } else {
    final mensajeErroneo = jsonEncode(respuesta['mensaje']);
    mostrarAlerta(context, 'Error', mensajeErroneo);
  }
  }
