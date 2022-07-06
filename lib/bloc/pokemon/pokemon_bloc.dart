import 'dart:developer';
import 'package:check_install/bloc/pokemon/pokemon_event.dart';
import 'package:check_install/bloc/pokemon/pokemon_state.dart';
import 'package:check_install/repositories/pokemon_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc({
    required PokemonRepository pokemonRepository,
  }) : _pokemonRepository = pokemonRepository,
    super(const PokemonState()) {
    on<LoadPokemons>(_onLoadPokemons);
    on<DeletePokemon>(_onDeletePokemon);
    on<LoadNextPage>(_onLoadNextPage);
  }

  final PokemonRepository _pokemonRepository;

  Future<void> _onLoadPokemons(
    LoadPokemons event,
    Emitter<PokemonState> emit,
  ) async {
    emit(
      state.copyWith(status: () => PokemonStatus.loading)
    );

    try{
      final pokemons = await _pokemonRepository.getAll();

      emit(
        state.copyWith(
          status: () => PokemonStatus.success,
          pokemons: () => pokemons,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: () => PokemonStatus.failure,),);
    }
  }

  void _onDeletePokemon(
    DeletePokemon event,
    Emitter<PokemonState> emit,
  ) {
    final pokemons = List.of(state.pokemons)..remove(event.pokemon);

    emit(
      state.copyWith(
        pokemons: () => pokemons,
      ),
    );
  }

  Future<void> _onLoadNextPage(
    LoadNextPage event,
    Emitter<PokemonState> emit,
  ) async {
    emit(
      state.copyWith(status: () => PokemonStatus.loadingNextPage)
    );

    try{
      final pokemonsForAdd = await _pokemonRepository.getAll(offset: event.offset);
      final pokemons = List.of(state.pokemons)..addAll(pokemonsForAdd);

      emit(
        state.copyWith(
          status: () => PokemonStatus.success,
          pokemons: () => pokemons,
          offset: () => event.offset,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: () => PokemonStatus.success,),);
    }
  }
}