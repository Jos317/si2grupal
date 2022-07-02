// To parse this JSON data, do
//
//     final facturaModel = facturaModelFromJson(jsonString);

import 'dart:convert';

List<FacturaModel> facturaModelFromJson(String str) => List<FacturaModel>.from(json.decode(str).map((x) => FacturaModel.fromJson(x)));

String facturaModelToJson(List<FacturaModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FacturaModel {
    FacturaModel({
        required this.id,
        required this.nit,
        required this.ciudad,
        required this.telefono,
        required this.formapago,
        required this.fechaemitida,
        required this.totalneto,
        required this.tipo,
        required this.foto,
    });

    int id;
    String nit;
    String ciudad;
    String telefono;
    String formapago;
    String fechaemitida;
    String totalneto;
    String tipo;
    String foto;

    factory FacturaModel.fromJson(Map<String, dynamic> json) => FacturaModel(
        id: json["id"],
        nit: json["nit"],
        ciudad: json["ciudad"],
        telefono: json["telefono"],
        formapago: json["formapago"],
        fechaemitida: json["fechaemitida"],
        totalneto: json["totalneto"],
        tipo: json["tipo"],
        foto: json["foto"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nit": nit,
        "ciudad": ciudad,
        "telefono": telefono,
        "formapago": formapago,
        "fechaemitida": fechaemitida,
        "totalneto": totalneto,
        "tipo": tipo,
        "foto": foto,
    };
}
