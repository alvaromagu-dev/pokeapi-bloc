import 'package:check_install/routes/paths.dart';
import 'package:check_install/widgets/list_with_footer.dart';
import 'package:check_install/widgets/password_input.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool keepLogged = false;

  void onKeepLoggedChange(value) => setState(() => keepLogged = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping'),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 600,
            maxHeight: 800
          ),
          child: ListWithFooter(
            footer: [
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(pokemons);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('LOGIN'),
                  )
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(register);
                },
                child: const Text('Don\'t have account? Register now!'),
              ),
            ],
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Username'
                  ),
                ),
              ),
              const PasswordInput(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.password),
                padding: EdgeInsets.all(10),
                labelText: 'Password',
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: CheckboxListTile(
                  value: keepLogged,
                  onChanged: onKeepLoggedChange,
                  title: const Text('Keep logged?'),
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}