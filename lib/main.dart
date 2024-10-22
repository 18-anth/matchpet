import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart'; // Importa Realtime Database
import 'package:matchpet/Admin/admin_screen.dart';
import 'package:matchpet/Client/client_screen.dart';
import 'package:matchpet/Client/widgets/custom_drawer.dart';
import 'utils/theme.dart';
import 'utils/routes.dart';
import 'Routes/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicializamos Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App de Adopción y Fundación',
      theme: appTheme,
      home: const AuthenticationWrapper(),
      routes: routes,
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    // Si el usuario está autenticado, verifica su rol
    if (user != null) {
      return FutureBuilder<DatabaseEvent>(
        future: FirebaseDatabase.instance
            .ref() // Referencia a la raíz de la base de datos
            .child('User') // Accede a la colección de usuarios
            .child(user.uid) // Usa el UID del usuario
            .once(), // Realiza una única lectura
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Muestra un indicador de carga
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error al obtener el rol del usuario.'));
          }

          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return LoginScreen();
          }

          var userData = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
          String role = userData['role'] ?? '';

          // Redirige según el rol
          if (role == 'CLIENT') {
            return ClientScreen(); // Pantalla para CLIENT
          } else if (role == 'ADMIN') {
            return AdminScreen(); // Asegúrate de definir esta pantalla
          } else {
            return const Center(child: Text('Rol no reconocido.'));
          }
        },
      );
    } else {
      // Si no, muestra la pantalla de login
      return LoginScreen();
    }
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      drawer: CustomDrawer(),
      body: const Center(
        child: Text(
          'Bienvenido a la App de Adopción y Fundación',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
