import 'package:check_install/routes/paths.dart';
import 'package:check_install/utils/int_extensions.dart';
import 'package:check_install/utils/validations.dart';
import 'package:check_install/widgets/password_input.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final passwordValidation = const PasswordValidation();
  final usernameValidation = const UsernameValidation(
    usernames: ['alvaro', 'pablo', 'jose', 'david']
  );
  final emailValidation = const EmailValidation(
    emails: ['alvaro@alvaro.es', 'pablo@pablo.es', 'jose@jose.es', 'david@david.es']
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
                validator: usernameValidation.validate,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                validator: emailValidation.validate,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            PasswordInput(
              prefixIcon: const Icon(Icons.lock),
              border: const OutlineInputBorder(),
              labelText: 'Password',
              padding: const EdgeInsets.all(10),
              validator: passwordValidation.validate,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            ElevatedButton(
              onPressed: () {
                if(!_formKey.currentState!.validate()){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error, Check Fields!')
                    ),
                  );

                  return;
                }

                Navigator.of(context).pushNamed(pokemons);
              },
              child: const Text('CREATE ACCOUNT'),
            ),
          ],
        )
      ),
    );
  }
}