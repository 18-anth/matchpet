import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Menú'),
          ),
          ListTile(
            title: Text('Feed de Noticias'),
            onTap: () {
              Navigator.pushNamed(context, '/feed');
            },
          ),
          ListTile(
            title: Text('Donaciones'),
            onTap: () {
              Navigator.pushNamed(context, '/donations');
            },
          ),
          ListTile(
            title: Text('Adopciones'),
            onTap: () {
              Navigator.pushNamed(context, '/adoptions');
            },
          ),
        ],
      ),
    );
  }
}
