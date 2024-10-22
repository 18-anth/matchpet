import 'package:flutter/material.dart';
import 'package:matchpet/Admin/admin_screen.dart';
import 'package:matchpet/Routes/login_screen.dart';
import '../Client/screens/feed_screen.dart';
import '../Client/screens/donations_screen.dart';
import '../Client/screens/adoptions_screen.dart';
import '../Client/screens/profile_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/login': (context) => LoginScreen(),
  '/admin': (context) => AdminScreen(),
  '/feed': (context) => FeedScreen(),
  '/donations': (context) => DonationsScreen(),
  '/adoptions': (context) => AdoptionsScreen(),
  '/profile': (context) => ProfileScreen(),
};
