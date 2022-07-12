// ignore_for_file: non_constant_identifier_names

import 'package:activos_app/controllers/providers/activo_provider.dart';
import 'package:activos_app/controllers/services/activo_service.dart';
import 'package:activos_app/models/activo_model.dart';
import 'package:activos_app/screens/activo/activos_detalles_screen.dart';
import 'package:activos_app/screens/nav_bar.dart';
import 'package:activos_app/widgets/perspective_list_view.dart';
import 'package:flutter/src/gestures/events.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/gestures.dart';

class ActivoScreen extends StatefulWidget {
  const ActivoScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ActivoScreenState createState() => _ActivoScreenState();
}

class _ActivoScreenState extends State<ActivoScreen> {
  var myMenuItems = <String>[
    'Escanner \nCódigo de Barras',
    'Escanner \nCódigo de QR',
    'Buscador',
  ];

  void onSelect(item) {
    switch (item) {
      case 'Escanner \nCódigo de Barras':
        scan();
        break;
      case 'Escanner \nCódigo de QR':
        scanQR();
        break;
      case 'Buscador':
        print('Profile clicked');
        break;
    }
  }

  String _data = "";
  String _data2 = "";
  int? _visibleItems;
  double? _itemExtent;
  List<ActivoModel> _activos = [];

  Future<void> scan() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE);

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _data = barcodeScanRes;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ActivosDetallesScreen(_data, 0)),
    );
  }

  Future<void> scanQR() async {
    String qrScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    qrScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.QR);

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _data2 = qrScanRes;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ActivosDetallesScreen("", int.parse(_data2))),
    );
  }

  @override
  void initState() {
    _visibleItems = 8;
    _itemExtent = 270.0;
    super.initState();
    ActivosService.getActivos().then((activos) {
      setState(() {
        _activos = activos;
      });
    });
    Provider.of<ActivoProvider>(context, listen: false).setActivos();
  }

  @override
  Widget build(BuildContext context) {
    // final activoProvider =
    //     Provider.of<ActivoProvider>(context, listen: false).activos;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 1,
        actions: <Widget>[
          PopupMenuButton<String>(
              onSelected: onSelect,
              itemBuilder: (BuildContext context) {
                return myMenuItems.map((String choice) {
                  return PopupMenuItem<String>(
                    child: Text(choice),
                    value: choice,
                  );
                }).toList();
              })
        ],
        // actions: [
        //   IconButton(
        //       icon: const Icon(
        //         FontAwesomeIcons.fileExcel,
        //         color: Colors.white,
        //       ),
        //       onPressed: () => createExcel(context)),
        //   IconButton(
        //       icon: const Icon(
        //         FontAwesomeIcons.filePdf,
        //         color: Colors.white,
        //       ),
        //       onPressed: () {
        //         // final pdf = pw.Document();
        //         // createPdfDocument(pdf);
        //       }
        //   )
        // ],
        centerTitle: true,
        title: const Text('Activos Fijos'),
      ),
      drawer: NavBar(),
      body: Center(
        child: Consumer<ActivoProvider>(builder: (context, value, child) {
          if (value.activos == null) {
            return CircularProgressIndicator();
          }
          return PerspectiveListView(
              visualizedItems: _visibleItems,
              itemExtent: _itemExtent,
              initialIndex: 2,
              enableBackItemsShadow: true,
              backItemsShadowColor: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.all(10),
              onTapFrontItem: (value) {},
              children: List.generate(_activos.length, (index) {
                final borderColor =
                    Colors.accents[index % Colors.accents.length];
                ActivoModel activo = _activos[index];
                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //-----------------------------
                      // Card Tab
                      //-----------------------------
                      Align(
                        heightFactor: .9,
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 45,
                          width: 70,
                          decoration: BoxDecoration(
                            color: borderColor,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      //-----------------------------
                      // Card Body
                      //-----------------------------
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: borderColor,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          //-----------------------------
                          // Card Body
                          //-----------------------------
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.monetization_on_rounded,
                                      size: 40,
                                    ),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: Text.rich(
                                        TextSpan(
                                          text: "Código: ${activo.codigo}",
                                          // text: "${value.activos!.codigo}",
                                          children: [
                                            TextSpan(
                                              text:
                                                  "\nDetalle: ${activo.detalle}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            )
                                          ],
                                        ),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.home_outlined,
                                      size: 40,
                                    ),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: Text.rich(
                                        TextSpan(
                                          text:
                                              "Fecha de Ingreso: ${activo.fechaIngreso}",
                                          // text: "${value.activos!.codigo}",
                                          children: [
                                            TextSpan(
                                              text:
                                                  "\nCosto: ${activo.costo} Bs",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.deepPurple,
                                              ),
                                            )
                                          ],
                                        ),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.person,
                                      size: 40,
                                    ),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: Text.rich(
                                        TextSpan(
                                          text:
                                              "Proveedor: ${activo.proveedor}",
                                          // text: "${value.activos!.codigo}",
                                          children: [
                                            TextSpan(
                                              text:
                                                  "\nUbicación: ${activo.ubicacionEdificio}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            )
                                          ],
                                        ),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ActivosDetallesScreen("", activo.id)),
                                      );
                                    },
                                    child: Text("Más detalles", style: TextStyle(
                                      color: Colors.green[300],
                                    ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }));
        }),
      ),
    );
  }
}
