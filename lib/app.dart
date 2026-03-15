import 'package:flutter/material.dart';

import 'pages/user_form_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laboratory Exercise #4',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D6E6E)),
        useMaterial3: true,
      ),
      home: const UserFormPage(),
    );
  }
}
