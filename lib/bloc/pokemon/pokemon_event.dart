import 'package:check_install/models/pokemon.dart';
import 'package:equatable/equatable.dart';

abstract class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object> get props => [];
}

class LoadPokemons extends PokemonEvent {
  const LoadPokemons();
}

class DeletePokemon extends PokemonEvent {
  const DeletePokemon({required this.pokemon});
  final Pokemon pokemon;

  @override
  List<Object> get props => [pokemon];
}

class LoadNextPage extends PokemonEvent {
  const LoadNextPage({required this.offset,});
  final int offset;

  @override
  List<Object> get props => [offset];
}