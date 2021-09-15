import 'package:flutter/material.dart';

import 'src/views/login_page.dart';
import 'src/views/profile_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'instagram',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}