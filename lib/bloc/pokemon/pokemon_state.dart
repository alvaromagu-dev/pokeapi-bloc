import 'package:check_install/bloc/pokemon/constants.dart';
import 'package:check_install/models/pokemon.dart';
import 'package:equatable/equatable.dart';

enum PokemonStatus { initial, loading, success, failure, loadingNextPage }

class PokemonState extends Equatable {
  const PokemonState({
    this.status = PokemonStatus.initial,
    this.pokemons = const [],
    this.offset = initialOffset,
  });

  final PokemonStatus status;
  final List<Pokemon> pokemons;
  final int offset;

  PokemonState copyWith({
    PokemonStatus Function()? status,
    List<Pokemon> Function()? pokemons,
    int Function()? offset,
  }) {
    return PokemonState(
      status: status != null ? status() : this.status,
      pokemons: pokemons != null ? pokemons() : this.pokemons,
      offset: offset != null ? offset() : this.offset,
    );
  }

  @override
  List<Object?> get props => [
    status, pokemons, offset
  ];
}
