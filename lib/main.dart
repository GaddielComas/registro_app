import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registro_app/providers/user_provider.dart';
import 'package:registro_app/screens/about_screen.dart';
import 'package:registro_app/screens/data_entry_screen.dart';
import 'package:registro_app/screens/login_screen.dart';
import 'package:registro_app/screens/register_screen.dart';
//Gaddiel Comas #2019-8909
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'Registro App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/login': (context) => LoginScreen(),
          '/home': (context) => HomeScreen(),
          '/about': (context) => AboutScreen(),
          '/data_entry': (context) => DataEntryScreen(),
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/data_entry');
              },
              child: Text('Registro de Datos'),
            ),
          ],
        ),
      ),
    );
  }
}
