import 'package:flutter/material.dart';
import 'package:palindromos/vistas/palindromo.vista.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Palindromos',
      debugShowCheckedModeBanner: false, // Opcional: quita la etiqueta de debug
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), // ✅ Corregido
        useMaterial3: true, // Opcional: usa Material 3
      ),
      home: const PalindromoVista(),
    );
  }
}