import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ClientScreen extends StatefulWidget {
  @override
  _ClientScreenState createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final User? user = FirebaseAuth.instance.currentUser; // Usuario actual
  String displayName = 'Nombre del Usuario'; // Valor por defecto
  String email = 'correo@ejemplo.com'; // Valor por defecto

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
        title: const Text('Panel de Cliente'),
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
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Centra verticalmente los elementos
                      children: [
                        // Contenedor que envuelve la imagen del logo
                        Container(
                          decoration: BoxDecoration(
                            shape:
                                BoxShape.circle, // Hacer el contorno circular
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.2), // Sombra alrededor
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: Offset(0, 3), // Posición de la sombra
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 40, // Tamaño del avatar
                            backgroundImage: AssetImage(
                                'assets/images/matchpet_logo.jpeg'), // Ruta de la imagen del logo
                          ),
                        ),
                        const SizedBox(
                            height: 10), // Espacio entre la imagen y el texto
                        Text(
                          displayName, // Mostrar el nombre desde la base de datos
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 16, // Tamaño de fuente para el nombre
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                            height: 4), // Espacio entre el nombre y el correo
                        Text(
                          email, // Mostrar el correo desde la base de datos
                          style: const TextStyle(
                            color: Color.fromARGB(255, 100, 100, 100),
                            fontSize: 12, // Tamaño de fuente para el correo
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Feed'),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/feed');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Donations'),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/donations');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Adoptions'),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/adoptions');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Profile'),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/profile');
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
                  ), // Opcional: bordes redondeados
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(10, 10),
                      color: Color.fromARGB(80, 0, 0, 0),
                      blurRadius: 10,
                    ),
                    BoxShadow(
                        offset: Offset(-10, -10),
                        color: Color.fromARGB(150, 255, 255, 255),
                        blurRadius: 10),
                  ],
                ),
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Cerrar sesión'),
                  onTap: () async {
                    // Llama a la función de cerrar sesión
                    await FirebaseAuth.instance.signOut();
                    // Redirige a la pantalla de login
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: const Column(
        children: [
          Expanded(child: _getScreenContent(_selectedScreen)),
        ],
      ),
    );
  }
}
