import 'package:activos_app/controllers/services/activo_service.dart';
import 'package:activos_app/models/activos_model.dart';
import 'package:flutter/material.dart';

class ActivofijoProvider extends ChangeNotifier {
  ActivosModel? activo = null;

  setActivo(String codigoQr, int codigo) async {
    activo = await ActivosService.getActivo(codigoQr, codigo);
    notifyListeners();
  }
}
