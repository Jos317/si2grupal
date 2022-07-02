import 'package:activos_app/controllers/providers/providers.dart';
import 'package:activos_app/controllers/services/shared_preference.dart';
import 'package:activos_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final keyNavegacionNotificacion = GlobalKey<NavigatorState>(debugLabel: 'Texto');
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesMemory().init();
  // NotificationService().initNotificacion();
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => ServerProvider()),
        ChangeNotifierProvider(create: (_) => ActivoProvider()),
        ChangeNotifierProvider(create: (_) => ActivofijoProvider()),
        ChangeNotifierProvider(create: (_) => FacturaProvider()),
        ChangeNotifierProvider(create: (_) => ServerProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        navigatorKey: keyNavegacionNotificacion,
        debugShowCheckedModeBanner: false,
        title: 'Activos App',
        initialRoute: 'login',
        routes: {
          'login': (_) => LoginScreen(),
          'home': (_) => HomeScreen(),
          'user': (_) => UserScreen(),
          'activos': (_) => ActivoScreen(),
          'facturas': (_) => FacturaScreen(),
        },
        // if(SharedPreferencesMemory().obtenerToken() != null)
        //     {
        //       return PacienteScreen();
        //     }else{
        //       return LoginScreen();
        //     }
        theme:
            ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.black),
        
        // supportedLocales: [
        //   const Locale('en'), // English
        //   const Locale('es'), // Spanish
        //   const Locale('fr'), // French
        //   const Locale('zh'), // Chinese
        // ],
        // home: JsonParseDemo(),
      ),
    );
  }
}
