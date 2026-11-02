import 'package:flutter/material.dart';

import 'ui/screens/home_screen.dart';

void main() {
  runApp(const WorldlyApp());
}

class WorldlyApp extends StatelessWidget {
  const WorldlyApp({super.key});

  static const Color ivory = Color(0xFFF8F3EA);
  static const Color terracotta = Color(0xFFDC795F);
  static const Color charcoal = Color(0xFF292725);
  static const Color seaBlue = Color(0xFF7CA7B2);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Worldly',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: ivory,

        colorScheme: ColorScheme.fromSeed(
          seedColor: terracotta,
          primary: terracotta,
          secondary: seaBlue,
          surface: ivory,
          onSurface: charcoal,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: ivory,
          foregroundColor: charcoal,
          elevation: 0,
          centerTitle: true,
        ),

        fontFamily: 'Roboto',

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: terracotta,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),

      home: const HomeScreen(),
    );
  }
}
