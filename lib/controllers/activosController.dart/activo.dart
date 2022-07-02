import 'dart:io';

import 'package:activos_app/controllers/providers/activo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:activos_app/models/activo_model.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

Future<List<ExcelDataRow>> _buildCustomersDataRowsIH(BuildContext context) async {
  List<ExcelDataRow> excelDataRows = <ExcelDataRow>[];
  final Future<List<ActivoModel>> reports = _getCustomersImageHyperlink(context);

  List<ActivoModel> reports_1 = await Future.value(reports);

  excelDataRows = reports_1.map<ExcelDataRow>((ActivoModel dataRow) {
    return ExcelDataRow(cells: <ExcelDataCell>[
      ExcelDataCell(columnHeader: 'Codigo', value: dataRow.codigo),
      ExcelDataCell(
          columnHeader: 'Nombre', value: dataRow.detalle),
      ExcelDataCell(
          columnHeader: 'Costo', value: dataRow.costo),
      ExcelDataCell(columnHeader: 'Fecha de Ingreso', value: dataRow.fechaIngreso),
      ExcelDataCell(columnHeader: 'Proveedor', value: dataRow.proveedor),
      ExcelDataCell(columnHeader: 'Estado', value: dataRow.estado),
      ExcelDataCell(columnHeader: 'Ubicación', value: dataRow.ubicacionEdificio),
      ExcelDataCell(columnHeader: 'Factura', value: dataRow.idFactura),
    ]);
  }).toList();

  return excelDataRows;
}

Future<List<ActivoModel>> _getCustomersImageHyperlink(context) async {
  final activoProvider =
      Provider.of<ActivoProvider>(context, listen: false).activos;
  final List<ActivoModel>? reports = activoProvider;

  return reports!;
}

Future<void> createExcel(BuildContext context) async {
  final Workbook workbook = Workbook();
  final Worksheet sheet = workbook.worksheets[0];
  //List of data to import data.
  final Future<List<ExcelDataRow>> dataRows = _buildCustomersDataRowsIH(context);

  List<ExcelDataRow> dataRows_1 = await Future.value(dataRows);

  //Import the list to Sheet.
  sheet.importData(dataRows_1, 1, 1);

  //Auto-Fit columns.
  sheet.getRangeByName('A1:H1').autoFitColumns();
  final List<int> bytes = workbook.saveAsStream();
  workbook.dispose();

  final String path = (await getApplicationSupportDirectory()).path;
  final String fileName = '$path/Activos.xlsx';
  final File file = File(fileName);
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open(fileName);
}
