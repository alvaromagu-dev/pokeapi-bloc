import 'package:check_install/models/pokemon.dart';
import 'package:check_install/utils/string_extensions.dart';
import 'package:check_install/widgets/password_input.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.pokemon}) :super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name.capitalize),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          SizedBox(
            width: 100,
            height: 100,
            child: CircleAvatar(
              backgroundImage: NetworkImage(pokemon.image),
            ),
          ),
          const SizedBox(height: 10,),
          Text(pokemon.name, textAlign: TextAlign.center,),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: pokemon.types
              .map((type) => Text(type)).toList(),
          ),
        ],
      ),
    );
  }
}