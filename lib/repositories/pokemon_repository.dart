import 'dart:convert';
import 'dart:io';
import 'package:check_install/bloc/pokemon/constants.dart';
import 'package:check_install/models/pokemon.dart';
import 'package:http/http.dart' as http;

class PokemonRepository {
  final baseUrl = '/api/v2/pokemon?limit=251/';
  final client = HttpClient();
  static const _pokemonsPerPage = 20;

  Future<List<Pokemon>> getAll({
    int offset = initialOffset,
  }) async {
    final uri = Uri.parse('https://pokeapi.co/api/v2/pokemon?offset=${_pokemonsPerPage * offset}/');

    final data = await http.get(uri);
    final body = jsonDecode(data.body);
    final result = body['results'] as List;

    final pokes = [for(final pokemon in result) await decodePokemon(pokemon)];
    return pokes;
  }

  Future<Pokemon> decodePokemon(pokemon) async {
    final pokemonUrl = Uri.parse(pokemon['url']);
    final pokemonData = await http.get(pokemonUrl);
    final body = jsonDecode(pokemonData.body);

    return Pokemon.fromJson(body);
  }
}