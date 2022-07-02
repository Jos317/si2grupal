import 'package:activos_app/controllers/facturasController.dart/factura.dart';
import 'package:activos_app/controllers/providers/factura_provider.dart';
import 'package:activos_app/controllers/services/factura_service.dart';
import 'package:activos_app/models/factura_model.dart';
import 'package:activos_app/screens/imagen_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:activos_app/screens/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class FacturaScreen extends StatefulWidget {
  @override
  State<FacturaScreen> createState() => _FacturaScreenState();
}

class _FacturaScreenState extends State<FacturaScreen> {
  List<FacturaModel> _facturas = [];

  @override
  void initState() {
    super.initState();
    FacturasService.getFacturas().then((facturas) {
      setState(() {
        _facturas = facturas;
      });
    });
    Provider.of<FacturaProvider>(context, listen: false).setFacturas();
  }

  @override
  Widget build(BuildContext context) {
    // final facturaProvider =
    //     Provider.of<FacturaProvider>(context, listen: false).facturas;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 1,
        actions: [
          IconButton(
              icon: const Icon(
                FontAwesomeIcons.fileExcel,
                color: Colors.white,
              ),
              onPressed: () => createExcelF(context)),
          IconButton(
              icon: const Icon(
                FontAwesomeIcons.filePdf,
                color: Colors.white,
              ),
              onPressed: () {
                // final pdf = pw.Document();
                // createPdfDocument(pdf);
              }
          )
        ],
        centerTitle: true,
        title: const Text('Facturas'),
      ),
      drawer: NavBar(),
      body: Center(
        child: Consumer<FacturaProvider>(builder: (context, value, child) {
          if (value.facturas == null) {
            return CircularProgressIndicator();
          }
          return Container(
            height: 700,
            child: ListView.builder(
              itemCount: _facturas.length,
              itemBuilder: (ctx, index) {
                FacturaModel factura = _facturas[index];
                return Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                            Colors.white,
                            Colors.lightBlueAccent.withOpacity(0.2)
                          ])),
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 15,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 133, 119, 119)
                                          .withOpacity(0.3),
                                      spreadRadius: 1.2,
                                      blurRadius: 7,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.note_add_rounded,
                                  color: Colors.purple[400],
                                ),
                              ),
                              padding: EdgeInsets.all(5),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.42,
                                  child: Text(
                                    "Nro: ${factura.id}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.42,
                                  child: Text(
                                    "Fecha Emitida: ${factura.fechaemitida}",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.42,
                                  child: Text(
                                    "Forma de Pago: ${factura.formapago}",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                    // 'From: ' +
                                    //     DateFormat.yMMMd()
                                    //         .format(widget.offers[index].dateFrom),
                                    // style: TextStyle(
                                    //   color: Colors.grey,
                                    // ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.42,
                                  child: Text(
                                    "Tipo de Pago: ${factura.tipo}",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  ElevatedButton.icon(
                                      onPressed: () {
                                        showDialog(
                                              context: context,
                                              builder: (_) => ImagenDialog(factura.foto !=''
                                                  ? factura.foto
                                                  : 'https://ec.europa.eu/info/funding-tenders/opportunities/portal/assets/img/user-icon.png'));
                                        // await eliminar(consulta.id);
                                      },
                                      label: const Text('Mostrar \nFactura'),
                                      icon: const Icon(Icons.remove_red_eye),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.blue)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
