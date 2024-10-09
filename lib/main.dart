// ignore_for_file: avoid_print

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_fudo/core/constants/palette.dart';
import 'package:prueba_fudo/presentation/screens/create_post_screen.dart';
import 'package:prueba_fudo/presentation/screens/login_screen.dart';
import 'package:prueba_fudo/presentation/screens/post_screen.dart';

Future<void> main() async {
  runZonedGuarded<void>(() async {
    EquatableConfig.stringify = true;
    runApp(const ProviderScope(child: MyApp()));
  }, (error, stack) {
    print(error.toString());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fudo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Palette.white,
          iconTheme: const IconThemeData(),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        scaffoldBackgroundColor: Palette.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginScreen(),
        '/posts': (context) => const PostScreen(),
        '/create': (context) => const CreatePostScreen(),
      },
    );
  }
}
