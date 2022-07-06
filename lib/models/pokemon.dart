class Pokemon {
  final int id;
  final String name;
  final String image;
  final List<String> types;

  Pokemon({required this.id, required this.name, required this.types, required this.image});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final image = json['sprites']['other']['official-artwork']['front_default'];
    final types = (json['types'] as List).map((type) {
      return type['type']['name'].toString();
    }).toList();

    return Pokemon(id: id, name: name, image: image, types: types);
  }

  @override
  String toString() {
    return 'Pokemon{name: $name, image: $image}';
  }
}