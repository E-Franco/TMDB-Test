class Review {
  String id;
  String author;
  _AuthorDetails authorDetails;
  String content;
  DateTime createdAt;

  Review({
    this.id,
    this.author,
    this.authorDetails,
    this.content,
    this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return Review(
        id: json['id'],
        author: json['author'],
        authorDetails: _AuthorDetails.fromJson(json['author_details']),
        content: json['content'],
        createdAt: DateTime.parse(json['created_at']));
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'author_details': authorDetails?.toJson(),
      'content': content,
      'id': id,
      'created_at': createdAt,
    };
  }
}

class _AuthorDetails {
  String name;
  String username;
  String avatarPath;
  num rating;

  _AuthorDetails({
    this.name,
    this.username,
    this.avatarPath,
    this.rating,
  });

  factory _AuthorDetails.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return _AuthorDetails(
      name: json['name'],
      username: json['username'],
      avatarPath: json['avatar_path'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'avatar_path': avatarPath,
      'rating': rating,
    };
  }
}
