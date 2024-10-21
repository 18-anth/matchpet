import 'package:flutter/material.dart';
import 'utils/theme.dart';
import 'utils/routes.dart';
import 'widgets/custom_drawer.dart';
import 'screens/feed_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App de Adopción y Fundación',
      theme: appTheme, // Importado desde utils/theme.dart
      initialRoute: '/feed', // Pantalla inicial
      routes: routes, // Definimos las rutas desde utils/routes.dart
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: const Text('Inicio'),
      ),

      drawer: CustomDrawer(), // Menú lateral
      body: const Center(
        child: Text(
          'Bienvenido a la App de Adopción y Fundación',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
