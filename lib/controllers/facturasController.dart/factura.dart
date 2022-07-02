import 'dart:io';

import 'package:activos_app/controllers/providers/providers.dart';
import 'package:activos_app/models/factura_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

Future<List<ExcelDataRow>> _buildCustomersDataRowsIH(BuildContext context) async {
  List<ExcelDataRow> excelDataRows = <ExcelDataRow>[];
  final Future<List<FacturaModel>> reports = _getCustomersImageHyperlink(context);

  List<FacturaModel> reports_1 = await Future.value(reports);

  excelDataRows = reports_1.map<ExcelDataRow>((FacturaModel dataRow) {
    return ExcelDataRow(cells: <ExcelDataCell>[
      ExcelDataCell(columnHeader: 'Nro', value: dataRow.id),
      ExcelDataCell(
          columnHeader: 'Nit', value: dataRow.nit),
      ExcelDataCell(
          columnHeader: 'Forma de Pago', value: dataRow.formapago),
      ExcelDataCell(columnHeader: 'Fecha Emitida', value: dataRow.fechaemitida),
      ExcelDataCell(columnHeader: 'Ciudad', value: dataRow.ciudad),
      ExcelDataCell(columnHeader: 'Tipo de Factura', value: dataRow.tipo),
      ExcelDataCell(columnHeader: 'Total Neto', value: dataRow.totalneto),
    ]);
  }).toList();

  return excelDataRows;
}

Future<List<FacturaModel>> _getCustomersImageHyperlink(context) async {
  final facturaProvider =
      Provider.of<FacturaProvider>(context, listen: false).facturas;
  final List<FacturaModel>? reports = facturaProvider;

  return reports!;
}

Future<void> createExcelF(BuildContext context) async {
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
  final String fileName = '$path/Facturas.xlsx';
  final File file = File(fileName);
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open(fileName);
}