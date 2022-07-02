import 'package:activos_app/controllers/services/activo_service.dart';
import 'package:activos_app/models/activo_model.dart';
import 'package:flutter/material.dart';

class ActivoProvider extends ChangeNotifier {
  List<ActivoModel>? activos = null;

  setActivos() async {
    activos = null;
    activos = await ActivosService.getActivos();
    notifyListeners();
  }
}
