class Actor {
  int id;
  String name;
  num popularity;
  String profilePath;
  String character;

  Actor({
    this.id,
    this.name,
    this.popularity,
    this.profilePath,
    this.character,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'popularity': popularity,
      'profile_path': profilePath,
      'character': character,
    };
  }

  factory Actor.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
  
    return Actor(
      id: json['id'],
      name: json['name'],
      popularity: json['popularity'],
      profilePath: json['profile_path'],
      character: json['character'],
    );
  }

}
