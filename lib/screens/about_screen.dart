import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registro_app/providers/user_provider.dart';
import 'dart:io';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: user == null
            ? Text('No user information available.')
            : Column(
                children: [
                  Text('Nombre: ${user.name}'),
                  Text('Matrícula: ${user.matricula}'),
                  user.photoPath.isNotEmpty
                      ? Image.file(File(user.photoPath))
                      : Text('No photo available.'),
                ],
              ),
      ),
    );
  }
}
