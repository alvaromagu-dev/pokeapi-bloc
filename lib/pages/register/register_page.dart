import 'package:check_install/routes/paths.dart';
import 'package:check_install/utils/gender.dart';
import 'package:check_install/utils/int_extensions.dart';
import 'package:check_install/utils/string_extensions.dart';
import 'package:check_install/utils/validations.dart';
import 'package:check_install/widgets/list_with_footer.dart';
import 'package:check_install/widgets/password_input.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final passwordValidation = const PasswordValidation();
  final password = TextEditingController();
  final email = TextEditingController();
  final usernameValidation = const UsernameValidation(
    usernames: ['alvaro', 'pablo', 'jose', 'david']
  );
  final emailValidation = const EmailValidation(
    emails: ['alvaro@alvaro.es', 'pablo@pablo.es', 'jose@jose.es', 'david@david.es']
  );
  Gender? selectedGender;

  void onGenderSelected(value) {
    setState(() => selectedGender = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 600,
            maxHeight: 800,
          ),
          child: Form(
            key: _formKey,
            child: ListWithFooter(
              footer: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  width: double.infinity,
                  child: ElevatedButton(
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
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text('CREATE ACCOUNT'),
                    ),
                  ),
                ),
              ],
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
                    controller: email,
                    validator: emailValidation.validate,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                      labelText: 'Repeat Email',
                    ),
                    validator: (value) {
                      if(value != email.text){
                        return 'Emails must be equal';
                      }

                      return null;
                    },
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
                  controller: password,
                ),
                PasswordInput(
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  labelText: 'Repeat Password',
                  padding: const EdgeInsets.all(10),
                  validator: (value) {
                    if(value != password.text){
                      return 'Passwords must be equal';
                    }

                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: DropdownButtonFormField<Gender>(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      prefixIcon: Icon(
                        genderIcon[selectedGender]
                      )
                    ),
                    validator: (value) {
                      if(value == null){
                        return 'Select a gender';
                      }

                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: onGenderSelected,
                    value: selectedGender,
                    hint: const Text('Select a gender'),
                    items: Gender.values.map((gender) {
                      return DropdownMenuItem<Gender>(
                        value: gender,
                        child: Text(gender.name.capitalize),
                      );
                    }).toList(),
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}