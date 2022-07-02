// To parse this JSON data, do
//
//     final activoModel = activoModelFromJson(jsonString);

import 'dart:convert';

List<ActivoModel> activoModelFromJson(String str) => List<ActivoModel>.from(json.decode(str).map((x) => ActivoModel.fromJson(x)));

String activoModelToJson(List<ActivoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivoModel {
    ActivoModel({
        required this.id,
        required this.codigo,
        required this.detalle,
        required this.costo,
        required this.fechaIngreso,
        required this.proveedor,
        required this.estado,
        required this.idFactura,
        required this.ubicacionEdificio,
    });

    int id;
    String codigo;
    String detalle;
    String costo;
    String fechaIngreso;
    String proveedor;
    String estado;
    int idFactura;
    String ubicacionEdificio;

    factory ActivoModel.fromJson(Map<String, dynamic> json) => ActivoModel(
        id: json["id"],
        codigo: json["codigo"],
        detalle: json["detalle"],
        costo: json["costo"],
        fechaIngreso: json["fecha_ingreso"],
        proveedor: json["proveedor"],
        estado: json["estado"],
        idFactura: json["id_factura"],
        ubicacionEdificio: json["ubicacion_edificio"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "detalle": detalle,
        "costo": costo,
        "fecha_ingreso": fechaIngreso,
        "proveedor": proveedor,
        "estado": estado,
        "id_factura": idFactura,
        "ubicacion_edificio": ubicacionEdificio,
    };
}
