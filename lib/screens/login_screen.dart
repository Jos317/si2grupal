import 'package:activos_app/controllers/loginController/login.dart';
import 'package:activos_app/controllers/providers/server_provider.dart';
import 'package:flutter/material.dart';
import 'package:activos_app/ui/input_decorations.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        key: loginKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(248, 132, 19, 132),
                  Color.fromARGB(248, 115, 57, 151),
                  Color.fromARGB(248, 12, 102, 127),
                ]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Image.asset(
                'images/pngegg.png',
                width: 100,
                height: 100,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Activos Fijos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Hola',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Por favor ingrese su cuenta',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecorations.authInputDecoration(
                          hintText: 'Email',
                          labelText: 'Correo electrónico',
                          suffixIcon: Icons.alternate_email_sharp,
                        ),
                        onChanged: (value) => value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Ingrese el correo del usuario';
                          }
                          return null;
                        },
                        controller: email,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextFormField(
                        autocorrect: false,
                        obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecorations.authInputDecoration(
                          hintText: 'Password',
                          labelText: 'Contraseña',
                          suffixIcon: Icons.lock_outline,
                        ),
                        onChanged: (value) => value,
                        validator: (value) {
                          return (value != null)
                              ? null
                              : 'Ingrese la contraseña del correo';
                        },
                        controller: password
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Olvidaste tu contraseña?',
                            style: TextStyle(
                              color: Colors.purpleAccent
                            ),
                          )
                        ],
                      ),
                    ),
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
                            'Ingresar',
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
                        login(email.text, password.text, context);
                      }

                      // onPressed: loginForm.isLoading
                      //     ? null
                      //     : () async {
                      //         FocusScope.of(context).unfocus();
                      //         if (!loginForm.isValidForm()) return;
                      //         loginForm.isLoading = true;
                      //         await Future.delayed(Duration(seconds: 2));
                      //         //TODO:validar si el login es correcto
                      //         loginForm.isLoading = false;
                      //         Navigator.pushReplacementNamed(context, 'proveedores');
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
