// To parse this JSON data, do
//
//     final activosModel = activosModelFromJson(jsonString);

import 'dart:convert';

ActivosModel activosModelFromJson(String str) => ActivosModel.fromJson(json.decode(str));

String activosModelToJson(ActivosModel data) => json.encode(data.toJson());

class ActivosModel {
    ActivosModel({
        required this.codigo,
        required this.nombre,
        required this.detalle,
        required this.tipo,
        required this.fechaIngreso,
        required this.costo,
        required this.estado,
        required this.proveedor,
        required this.dAnual,
        required this.ubicacionPais,
        required this.ubicacionCiudad,
        required this.ubicacionEdificio,
        required this.departamentoNombre,
        required this.depreciacionNombre,
        required this.depreciacionDescripcion,
        required this.depreciacionVidaUtil,
        required this.depreciacionValorResidual,
    });

    String codigo;
    String nombre;
    String detalle;
    String tipo;
    String fechaIngreso;
    String costo;
    String estado;
    String proveedor;
    String? dAnual;
    String ubicacionPais;
    String ubicacionCiudad;
    String ubicacionEdificio;
    String departamentoNombre;
    String depreciacionNombre;
    String depreciacionDescripcion;
    int depreciacionVidaUtil;
    String depreciacionValorResidual;

    factory ActivosModel.fromJson(Map<String, dynamic> json) => ActivosModel(
        codigo: json["codigo"],
        nombre: json["nombre"],
        detalle: json["detalle"],
        tipo: json["tipo"],
        fechaIngreso: json["fecha_ingreso"],
        costo: json["costo"],
        estado: json["estado"],
        proveedor: json["proveedor"],
        dAnual: json["d_anual"],
        ubicacionPais: json["ubicacion_pais"],
        ubicacionCiudad: json["ubicacion_ciudad"],
        ubicacionEdificio: json["ubicacion_edificio"],
        departamentoNombre: json["departamento_nombre"],
        depreciacionNombre: json["depreciacion_nombre"],
        depreciacionDescripcion: json["depreciacion_descripcion"],
        depreciacionVidaUtil: json["depreciacion_vidaUtil"],
        depreciacionValorResidual: json["depreciacion_valorResidual"],
    );

    Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "nombre": nombre,
        "detalle": detalle,
        "tipo": tipo,
        "fecha_ingreso": fechaIngreso,
        "costo": costo,
        "estado": estado,
        "proveedor": proveedor,
        "d_anual": dAnual,
        "ubicacion_pais": ubicacionPais,
        "ubicacion_ciudad": ubicacionCiudad,
        "ubicacion_edificio": ubicacionEdificio,
        "departamento_nombre": departamentoNombre,
        "depreciacion_nombre": depreciacionNombre,
        "depreciacion_descripcion": depreciacionDescripcion,
        "depreciacion_vidaUtil": depreciacionVidaUtil,
        "depreciacion_valorResidual": depreciacionValorResidual,
    };
}
