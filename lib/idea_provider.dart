import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'idea.dart';

class IdeaProvider with ChangeNotifier {
  List<Idea> _ideas = [];
  List<String> _upvotedIdeaIds = [];

  List<Idea> get ideas => _ideas;

  IdeaProvider() {
    loadIdeas();
  }

  Future<Idea> addIdea(String name, String tagline, String description) async {
    final rating = Random().nextInt(101);
    final newIdea = Idea(
      name: name,
      tagline: tagline,
      description: description,
      rating: rating,
    );
    _ideas.add(newIdea);
    await saveIdeas();
    notifyListeners();
    return newIdea;
  }

  Future<void> upvote(String ideaId) async {
    if (_upvotedIdeaIds.contains(ideaId)) {
      return;
    }

    final ideaIndex = _ideas.indexWhere((idea) => idea.id == ideaId);
    if (ideaIndex != -1) {
      _ideas[ideaIndex].votes++;
      _upvotedIdeaIds.add(ideaId);
      await saveIdeas();
      notifyListeners();
    }
  }

  void deleteIdea(String ideaId) {
    _ideas.removeWhere((i) => i.id == ideaId);
    saveIdeas();
    notifyListeners();
  }

  bool isUpvoted(String ideaId) {
    return _upvotedIdeaIds.contains(ideaId);
  }

  void sortIdeasByRating() {
    _ideas.sort((a, b) => b.rating.compareTo(a.rating));
    notifyListeners();
  }

  void sortIdeasByVotes() {
    _ideas.sort((a, b) => b.votes.compareTo(a.votes));
    notifyListeners();
  }

  Future<void> saveIdeas() async {
    final prefs = await SharedPreferences.getInstance();
    final ideasJson =
        _ideas.map((idea) => jsonEncode(idea.toJson())).toList();
    await prefs.setStringList('ideas', ideasJson);
    await prefs.setStringList('upvoted_ideas', _upvotedIdeaIds);
  }

  Future<void> loadIdeas() async {
    final prefs = await SharedPreferences.getInstance();
    final ideasJson = prefs.getStringList('ideas');
    if (ideasJson != null) {
      _ideas = ideasJson
          .map((json) => Idea.fromJson(jsonDecode(json)))
          .toList();
    }
    _upvotedIdeaIds = prefs.getStringList('upvoted_ideas') ?? [];
    notifyListeners();
  }
}
