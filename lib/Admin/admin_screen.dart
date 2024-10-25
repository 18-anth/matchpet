import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:matchpet/Admin/Screens/AdopcionAdminScreen.dart';
import 'package:matchpet/Admin/Screens/NoticiasFeedScreen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final User? user = FirebaseAuth.instance.currentUser; // Usuario actual
  String displayName = 'Nombre del Usuario'; // Valor por defecto
  String email = 'correo@ejemplo.com';

  @override
  void initState() {
    super.initState();
    _getUserData(); // Llamada para obtener los datos del usuario
  }

  Future<void> _getUserData() async {
    if (user != null) {
      // Obtener el UID del usuario autenticado
      String uid = user!.uid;

      // Referencia a la base de datos
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child('User').child(uid);

      try {
        // Obtener los datos del usuario desde la base de datos
        DatabaseEvent event = await userRef.once();

        if (event.snapshot.exists) {
          // Extraer los datos
          final data = event.snapshot.value as Map<dynamic, dynamic>?;

          if (data != null) {
            setState(() {
              displayName = data['displayName'] ??
                  'Nombre del Usuario'; // Asignar displayName
              email = data['email'] ?? 'correo@ejemplo.com'; // Asignar email
            });
          }
        } else {
          print('Usuario no encontrado en la base de datos.');
        }
      } catch (e) {
        print('Error al obtener los datos del usuario: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de Administrador'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu), // Icono de hamburguesa
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Abre el Drawer
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 11, 91, 74),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          AssetImage('assets/images/matchpet_logo.jpeg'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    displayName,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 225, 225, 225),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            // Opción para ir al feed de noticias
            ListTile(
              leading: const Icon(Icons.article),
              title: const Text('Gestionar Noticias'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NoticiasFeedScreen(),
                  ),
                );
              },
            ),
            // Opción para ir a la sección de adopciones
            ListTile(
              leading: const Icon(Icons.pets),
              title: const Text('Gestionar Adopciones'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AdopcionAdminScreen(),
                  ),
                );
              },
            ),
            // Opción para cerrar sesión
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed('/login');
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Bienvenido Administrador'),
      ),
    );
  }
}
