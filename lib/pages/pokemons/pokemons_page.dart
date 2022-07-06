import 'dart:developer';

import 'package:check_install/bloc/pokemon/pokemon_bloc.dart';
import 'package:check_install/bloc/pokemon/pokemon_event.dart';
import 'package:check_install/bloc/pokemon/pokemon_state.dart';
import 'package:check_install/models/pokemon.dart';
import 'package:check_install/routes/paths.dart';
import 'package:check_install/utils/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonsPage extends StatelessWidget {
  const PokemonsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Pokemons'),),
        body: BlocBuilder<PokemonBloc, PokemonState>(
          buildWhen: (prev, cur) {
            return prev.status != cur.status || prev.pokemons != cur.pokemons;
          },
          builder: (context, state) {
            if(state.status == PokemonStatus.loading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if(state.status == PokemonStatus.failure){
              return const Center(child: Text('An error occurred'),);
            }

            final bloc = context.read<PokemonBloc>();
            final isLoadingNextPage = state.status == PokemonStatus.loadingNextPage;

            return ListView.builder(
              itemCount: state.pokemons.length,
              itemBuilder: (context, index) {
                if(index == state.pokemons.length - 5 && !isLoadingNextPage){
                  bloc.add(LoadNextPage(offset: state.offset + 1));
                }

                final pokemon = state.pokemons[index];

                if(index == state.pokemons.length - 1 && isLoadingNextPage) {
                  return Column(
                    children: [
                      PokemonItem(pokemon: pokemon),
                      const Center(child: CircularProgressIndicator(),)
                    ],
                  );
                }

                return PokemonItem(pokemon: pokemon);
              },
            );
          },
        )
    );
  }
}

class PokemonItem extends StatelessWidget {
  const PokemonItem({Key? key, required this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(pokemon.name.capitalize),
      leading: Text('${pokemon.id}.'),
      trailing: Image.network(pokemon.image),
      onTap: () {
        Navigator.of(context).pushNamed(detail, arguments: pokemon);
      },
    );
  }
}

