import 'package:activos_app/controllers/services/factura_service.dart';
import 'package:activos_app/models/factura_model.dart';
import 'package:flutter/material.dart';

class FacturaProvider extends ChangeNotifier {
  List<FacturaModel>? facturas = null; 

  setFacturas() async
  {
    facturas = await FacturasService.getFacturas();
    notifyListeners();
  }

}