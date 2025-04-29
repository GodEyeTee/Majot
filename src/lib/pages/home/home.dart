import 'package:flutter/material.dart';
import 'package:majot/pages/auths/login.dart';
import 'package:majot/pages/auths/register.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register/Login'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const RegisterScreen();
                      }));
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Register')),
              ),
              SizedBox(
                child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const LoginScreen();
                      }));
                    },
                    icon: const Icon(Icons.login),
                    label: const Text('Login')),
              )
            ],
          ),
        ));
  }
}
