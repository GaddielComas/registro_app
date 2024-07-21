import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registro_app/providers/user_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();

  void _login() {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user != null && user.name == _nameController.text) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            ElevatedButton(
              onPressed: _login,
              child: Text('Ingresar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
