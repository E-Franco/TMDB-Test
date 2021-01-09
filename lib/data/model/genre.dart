class Genre {
  final int id;
  final String name;

  const Genre({
    this.id,
    this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Genre.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}
