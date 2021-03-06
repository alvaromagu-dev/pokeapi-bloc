import 'package:check_install/bloc/pokemon/pokemon_bloc.dart';
import 'package:check_install/bloc/pokemon/pokemon_event.dart';
import 'package:check_install/models/pokemon.dart';
import 'package:check_install/pages/detail/detail_page.dart';
import 'package:check_install/pages/login/login_page.dart';
import 'package:check_install/pages/register/register_page.dart';
import 'package:check_install/pages/splash/splash_page.dart';
import 'package:check_install/repositories/pokemon_repository.dart';
import 'package:check_install/routes/paths.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:check_install/pages/pokemons/pokemons_page.dart';

final routes = <String, WidgetBuilder>{
  pokemons: (context) => BlocProvider(
    create: (_) => PokemonBloc(
      pokemonRepository: PokemonRepository()
    )..add(
      const LoadPokemons()
    ),
    child: const PokemonsPage(),
  ),
  detail: (context) {
    final pokemon = ModalRoute.of(context)?.settings.arguments as Pokemon;
    return DetailPage(pokemon: pokemon,);
  },
  login: (context) {
    return const LoginPage();
  },
  register: (context) {
    return const RegisterPage();
  },
  splash: (context) {
    return const SplashPage();
  }
};