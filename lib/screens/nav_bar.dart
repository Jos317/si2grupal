import 'package:activos_app/controllers/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('${userProvider!.name}'),
            // accountName: Text('${pacienteProvider!.nombre} ${pacienteProvider.email}'),
            accountEmail: Text(userProvider.email),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: (userProvider.foto == '' ? 
                  Image.network('https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ):
                  // Image.network('${ServerProvider().url}/${userProvider.foto}',
                  Image.network(userProvider.foto,
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  )
                ),
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromARGB(248, 146, 64, 146),
                    Color.fromARGB(248, 136, 30, 202),
                    Color.fromARGB(248, 7, 175, 221),
                  ]),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () => Navigator.pushReplacementNamed(context, 'user'),
          ),
          ListTile(
            leading: const Icon(Icons.padding_outlined),
            title: const Text('Factura'),
            onTap: () => Navigator.pushReplacementNamed(context, 'facturas'),
          ),
          if(userProvider.cargo=='Analista')...[
            ListTile(
              leading: const Icon(Icons.arrow_circle_down),
              title: const Text('Baja'),
              onTap: () => Navigator.pushReplacementNamed(context, 'activos'),
            ),
            ListTile(
              leading: const Icon(Icons.terminal),
              title: const Text('Activos'),
              onTap: () => Navigator.pushReplacementNamed(context, 'activos'),
            ),
          ],
          const Divider(),
          ListTile(
            title: const Text('Exit'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () => Navigator.pushReplacementNamed(context, 'login'),
          ),
        ],
      ),
    );
  }
}