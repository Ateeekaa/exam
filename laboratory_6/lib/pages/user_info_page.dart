// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../model/user.dart';

class UserInfoPage extends StatelessWidget {
  final User userInfo;

  const UserInfoPage({super.key, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpeg'), // фон
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 8,
              color: Colors.white.withOpacity(0.9),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(userInfo.name),
                      subtitle: const Text('Full Name'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: Text(userInfo.phone),
                      subtitle: const Text('Phone Number'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.mail),
                      title: Text(
                        userInfo.email.isEmpty ? 'Not specified' : userInfo.email,
                      ),
                      subtitle: const Text('Email'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.map),
                      title: Text(userInfo.country),
                      subtitle: const Text('Country'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.lock),
                      title: Text(userInfo.password),
                      subtitle: const Text('Password'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
