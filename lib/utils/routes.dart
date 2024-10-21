import 'package:flutter/material.dart';
import '../screens/feed_screen.dart';
import '../screens/donations_screen.dart';
import '../screens/adoptions_screen.dart';
import '../screens/profile_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/feed': (context) => FeedScreen(),
  '/donations': (context) => DonationsScreen(),
  '/adoptions': (context) => AdoptionsScreen(),
  '/profile': (context) => ProfileScreen(),
};
