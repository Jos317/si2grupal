import 'package:activos_app/controllers/loginController/login.dart';
import 'package:activos_app/controllers/providers/server_provider.dart';
import 'package:activos_app/controllers/providers/user_provider.dart';
import 'package:activos_app/ui/input_decorationsV2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'Services.dart';

class EditUserScreen extends StatefulWidget {
  EditUserScreen() : super();

  @override
  State<StatefulWidget> createState() => _EditUserState();
}

class _EditUserState extends State<EditUserScreen> {
  final GlobalKey<FormState> edituserKey = GlobalKey<FormState>();
  late var serverProvider;
  late var user;
  TextEditingController name = TextEditingController();
  TextEditingController edad = TextEditingController();
  TextEditingController direccion = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  void initState() {
    super.initState();
    serverProvider = ServerProvider();
    Provider.of<UserProvider>(context, listen: false).setUser();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    name = TextEditingController(text: userProvider!.name);
    edad = TextEditingController(text: userProvider.edad.toString());
    direccion = TextEditingController(text: userProvider.direccion);
    telefono = TextEditingController(text: userProvider.telefono.toString());
    email = TextEditingController(text: userProvider.email);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text('Activos App'),
      ),
      body: Center(
        child: Consumer<UserProvider>(builder: (context, value, child) {
          if (value.user == null) {
            return CircularProgressIndicator();
          }
          return Container(
            padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                key: edituserKey,
                children: [
                  Text(
                    "Editar perfil del usuario",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    (value.user!.foto != ''
                                        ? value.user!.foto
                                        : 'https://ec.europa.eu/info/funding-tenders/opportunities/portal/assets/img/user-icon.png'),
                                  ))),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Text('Nombre:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  TextFormField(
                    enabled: true,
                    decoration: InputDecorationsV2.authInputDecoration(
                      hintText: 'Nombre(s)',
                      prefixIcon: Icons.face_unlock_sharp,
                    ),
                    onChanged: (value) => value,
                    validator: (value) {
                      return (value != null)
                          ? null
                          : 'Ingrese el nuevo nombre';
                    },
                    controller: name),
                  SizedBox(
                    height: 35,
                  ),
                  Text('Edad:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  TextFormField(
                      enabled: true,
                      decoration: InputDecorationsV2.authInputDecoration(
                        hintText: 'Edad',
                        prefixIcon: Icons.person,
                      ),
                      controller: edad),
                  SizedBox(
                    height: 35,
                  ),
                  Text('Dirección:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  TextFormField(
                      enabled: true,
                      decoration: InputDecorationsV2.authInputDecoration(
                        hintText: 'Dirección',
                        prefixIcon: Icons.house,
                      ),
                      controller: direccion),
                  SizedBox(
                    height: 35,
                  ),
                  Text('Teléfono:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  TextFormField(
                      enabled: true,
                      decoration: InputDecorationsV2.authInputDecoration(
                        hintText: 'Teléfono',
                        prefixIcon: Icons.phone,
                      ),
                      controller: telefono),
                  SizedBox(
                    height: 35,
                  ),
                  Text('Email:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  TextFormField(
                      enabled: true,
                      decoration: InputDecorationsV2.authInputDecoration(
                        hintText: '${value.user!.email}',
                        prefixIcon: Icons.alternate_email_sharp,
                      ),
                      controller: email),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromARGB(248, 132, 19, 132),
                              Color.fromARGB(248, 115, 57, 151),
                              Color.fromARGB(248, 12, 102, 127),
                            ]
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Editar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                        ),
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        edit(userProvider.id, name.text, edad.text, direccion.text, telefono.text, email.text, context);
                      }      
                    ),
                    SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
