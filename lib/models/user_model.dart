// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        required this.id,
        required this.name,
        required this.foto,
        required this.sexo,
        required this.edad,
        required this.cargo,
        required this.direccion,
        required this.telefono,
        required this.email,
        required this.emailVerifiedAt,
        required this.createdAt,
        required this.updatedAt,
        required this.rolName,
    });

    int id;
    String name;
    String foto;
    String sexo;
    int edad;
    String cargo;
    String direccion;
    int telefono;
    String email;
    dynamic emailVerifiedAt;
    DateTime createdAt;
    DateTime updatedAt;
    String rolName;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        foto: json["foto"],
        sexo: json["sexo"],
        edad: json["edad"],
        cargo: json["cargo"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        rolName: json["rol_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "foto": foto,
        "sexo": sexo,
        "edad": edad,
        "cargo": cargo,
        "direccion": direccion,
        "telefono": telefono,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "rol_name": rolName,
    };
}
