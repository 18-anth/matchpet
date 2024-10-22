import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:matchpet/Admin/admin_screen.dart';
import 'package:matchpet/Client/client_screen.dart';
import 'package:matchpet/Routes/RegisterScreen.dart'; // Importar la pantalla de registro

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = '';

  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      User? user = userCredential.user;

      if (user != null) {
        _checkUserRole(user);
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error al iniciar sesión: $e';
      });
    }
  }

  Future<void> _checkUserRole(User user) async {
    final DatabaseReference userRef = _dbRef.child('User').child(user.uid);

    userRef.once().then((DatabaseEvent event) {
      if (event.snapshot.exists) {
        final value = event.snapshot.value;

        if (value != null && value is Map) {
          String? role = value['role']?.toString();

          if (role != null) {
            if (role == 'ADMIN') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AdminScreen()),
              );
            } else if (role == 'CLIENT') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ClientScreen()),
              );
            } else {
              setState(() {
                errorMessage = 'Rol desconocido.';
              });
            }
          } else {
            setState(() {
              errorMessage = 'Rol no encontrado.';
            });
          }
        } else {
          setState(() {
            errorMessage =
                'Los datos del usuario no son válidos o no tienen el formato esperado.';
          });
        }
      } else {
        setState(() {
          errorMessage = 'Usuario no encontrado.';
        });
      }
    }).catchError((error) {
      setState(() {
        errorMessage = 'Error al obtener los datos del usuario: $error';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 8,
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFF4F4F4),
                    Color.fromARGB(255, 253, 219, 255)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.2), // Sombra negra con opacidad del 20%
                    spreadRadius: 2, // Expansión de la sombra
                    blurRadius: 5, // Desenfoque de la sombra
                    offset: const Offset(
                        0, 3), // Desplazamiento de la sombra en el eje X y Y
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          20.0), // Bordes redondeados de 20px
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(
                              0.2), // Sombra negra con opacidad del 20%
                          spreadRadius: 2, // Expansión de la sombra
                          blurRadius: 5, // Desenfoque de la sombra
                          offset: const Offset(0,
                              3), // Desplazamiento de la sombra en el eje X y Y
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          20.0), // Bordes redondeados de la imagen
                      child: Image.asset(
                        'assets/images/matchpet_logo.jpeg', // Ruta de tu imagen de logo
                        height: 100,
                        width: 100,
                        fit: BoxFit
                            .cover, // Ajusta la imagen para que llene el contenedor
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text('Iniciar Sesión'),
                  ),
                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()),
                      );
                    },
                    child: const Column(
                      children: [
                        Text(
                          '¿No tienes cuenta? ',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 27, 27, 27)),
                        ),
                        Text(
                          'Regístrate aquí',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 255, 47, 47)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
