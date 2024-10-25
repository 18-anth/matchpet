import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:matchpet/Client/screens/adoptions_screen.dart';
import 'package:matchpet/Client/screens/donations_screen.dart';
import 'package:matchpet/Client/screens/feed_screen.dart';
import 'package:matchpet/Client/screens/profile_screen.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  _ClientScreenState createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final User? user = FirebaseAuth.instance.currentUser; // Usuario actual
  String displayName = 'Nombre del Usuario'; // Valor por defecto
  String email = 'correo@ejemplo.com'; // Valor por defecto
  String _selectedScreen = 'feed'; // Valor por defecto para la pantalla
  String _selectedScreenText = 'Puppy Tail'; // Texto por defecto del AppBar

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

  // Método para cambiar el contenido basado en la opción seleccionada
  Widget _getScreenContent(String screen) {
    switch (screen) {
      case 'feed':
        return FeedScreen();
      case 'donations':
        return DonationsScreen();
      case 'adoptions':
        return AdoptionsScreen();
      case 'profile':
        return ProfileScreen();
      default:
        return const Center(child: Text('Pantalla no encontrada'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedScreenText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
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
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 239, 239, 239),
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
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          email,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 100, 100, 100),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Feed'),
                    onTap: () {
                      setState(() {
                        _selectedScreen = 'feed';
                        _selectedScreenText =
                            'Feed de Noticias'; // Actualiza el título
                      });
                      Navigator.of(context).pop(); // Cerrar Drawer
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.money),
                    title: const Text('Donations'),
                    onTap: () {
                      setState(() {
                        _selectedScreen = 'donations';
                        _selectedScreenText =
                            'Donaciones'; // Actualiza el título
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.pets),
                    title: const Text('Adoptions'),
                    onTap: () {
                      setState(() {
                        _selectedScreen = 'adoptions';
                        _selectedScreenText =
                            'Adopciones'; // Actualiza el título
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Profile'),
                    onTap: () {
                      setState(() {
                        _selectedScreen = 'profile';
                        _selectedScreenText = 'Perfil'; // Actualiza el título
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              height: 1,
              color: Color.fromARGB(38, 0, 0, 0),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffcacdd3), Color(0xffeae5e5)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(10, 10),
                      color: Color.fromARGB(80, 0, 0, 0),
                      blurRadius: 10,
                    ),
                    BoxShadow(
                      offset: Offset(-10, -10),
                      color: Color.fromARGB(150, 255, 255, 255),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Cerrar sesión'),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: _getScreenContent(_selectedScreen),
    );
  }
}
