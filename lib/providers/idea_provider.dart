import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/idea.dart';
import '../services/storage_service.dart';
import '../services/ai_service.dart';

class IdeaProvider extends ChangeNotifier {
  List<Idea> _ideas = [];
  List<Idea> get ideas => _ideas;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  IdeaProvider() {
    loadIdeas();
  }

  Future<void> loadIdeas() async {
    _isLoading = true;
    notifyListeners();
    _ideas = await StorageService.getIdeas();
    _ideas.sort((a, b) => b.votes.compareTo(a.votes));
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addIdea(String name, String tagline, String description) async {
    final id = Uuid().v4();
    final aiRating = AIService.generateFakeRating(name, tagline, description);
    final newIdea = Idea(
      id: id,
      name: name,
      tagline: tagline,
      description: description,
      aiRating: aiRating,
      votes: 0,
      createdAt: DateTime.now(),
    );
    await StorageService.saveIdea(newIdea);
    _ideas.add(newIdea);
    notifyListeners();
  }

  Future<void> upvoteIdea(String ideaId) async {
    final hasVoted = await StorageService.hasVoted(ideaId);
    if (hasVoted) return;

    final index = _ideas.indexWhere((idea) => idea.id == ideaId);
    if (index != -1) {
      final idea = _ideas[index];
      final updatedIdea = idea.copyWith(votes: idea.votes + 1);
      _ideas[index] = updatedIdea;
      await StorageService.updateIdea(updatedIdea);
      await StorageService.recordVote(ideaId);
      notifyListeners();
    }
  }

  List<Idea> getTopIdeas(int count) {
    final sorted = List<Idea>.from(_ideas);
    sorted.sort((a, b) {
      final scoreA = a.votes + a.aiRating;
      final scoreB = b.votes + b.aiRating;
      return scoreB.compareTo(scoreA);
    });
    return sorted.take(count).toList();
  }

  Future<void> deleteIdea(String ideaId) async {
    final index = _ideas.indexWhere((idea) => idea.id == ideaId);
    if (index != -1) {
      _ideas.removeAt(index);
      await StorageService.deleteIdea(ideaId);
      notifyListeners();
    }
  }
}
