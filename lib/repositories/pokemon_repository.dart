import 'dart:convert';
import 'dart:io';
import 'package:check_install/models/pokemon.dart';
import 'package:http/http.dart' as http;

class PokemonRepository {
  static const _baseUrl = 'https://pokeapi.co/api/v2';
  static const _pokemonsPerPage = 20;

  Future<List<Pokemon>> getAll({
    int offset = 0,
  }) async {
    final url = Uri.parse('$_baseUrl/pokemon?offset=${_pokemonsPerPage * offset}/');

    final data = await http.get(url);
    final body = jsonDecode(data.body);
    final results = body['results'] as List;

    final pokes = [for(final pokemon in results) await getPokemonByUrl(pokemon['url'])];
    return pokes;
  }

  Future<Pokemon> getPokemonByUrl(url) async {
    final pokemonData = await http.get(Uri.parse(url));
    final pokemonBody = jsonDecode(pokemonData.body);

    return Pokemon.fromJson(pokemonBody);
  }

  Future<Pokemon> getPokemonById(id) async {
    return await getPokemonByUrl('$_baseUrl/pokemon/$id');
  }
}