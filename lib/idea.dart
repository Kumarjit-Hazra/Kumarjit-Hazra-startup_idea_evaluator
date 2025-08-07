import 'dart:math';

class Idea {
  final String id;
  String name;
  String tagline;
  String description;
  int rating;
  int votes;
  double viabilityScore;

  Idea({
    String? id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.rating,
    this.votes = 0,
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        viabilityScore = Random().nextDouble() * 10;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'tagline': tagline,
        'description': description,
        'rating': rating,
        'votes': votes,
        'viabilityScore': viabilityScore,
      };

  factory Idea.fromJson(Map<String, dynamic> json) => Idea(
        id: json['id'],
        name: json['name'],
        tagline: json['tagline'],
        description: json['description'],
        rating: json['rating'],
        votes: json['votes'],
      )..viabilityScore = json['viabilityScore'] ?? Random().nextDouble() * 10;
}
