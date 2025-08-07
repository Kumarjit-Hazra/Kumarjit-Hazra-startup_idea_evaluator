import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/idea.dart';

class StorageService {
  static const String _ideasKey = 'ideas_list';
  static const String _votesKey = 'user_votes';

  static Future<List<Idea>> getIdeas() async {
    final prefs = await SharedPreferences.getInstance();
    final ideasJson = prefs.getString(_ideasKey);
    
    if (ideasJson == null) return [];
    
    final List<dynamic> decoded = jsonDecode(ideasJson);
    return decoded.map((json) => Idea.fromJson(json)).toList();
  }

  static Future<void> saveIdea(Idea idea) async {
    final prefs = await SharedPreferences.getInstance();
    final ideas = await getIdeas();
    ideas.add(idea);
    
    final encoded = jsonEncode(ideas.map((i) => i.toJson()).toList());
    await prefs.setString(_ideasKey, encoded);
  }

  static Future<void> updateIdea(Idea updatedIdea) async {
    final prefs = await SharedPreferences.getInstance();
    final ideas = await getIdeas();
    
    final index = ideas.indexWhere((idea) => idea.id == updatedIdea.id);
    if (index != -1) {
      ideas[index] = updatedIdea;
      final encoded = jsonEncode(ideas.map((i) => i.toJson()).toList());
      await prefs.setString(_ideasKey, encoded);
    }
  }

  static Future<bool> hasVoted(String ideaId) async {
    final prefs = await SharedPreferences.getInstance();
    final votedIdeas = prefs.getStringList(_votesKey) ?? [];
    return votedIdeas.contains(ideaId);
  }

  static Future<void> recordVote(String ideaId) async {
    final prefs = await SharedPreferences.getInstance();
    final votedIdeas = prefs.getStringList(_votesKey) ?? [];
    if (!votedIdeas.contains(ideaId)) {
      votedIdeas.add(ideaId);
      await prefs.setStringList(_votesKey, votedIdeas);
    }
  }

  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_ideasKey);
    await prefs.remove(_votesKey);
  }

  static Future<void> deleteIdea(String ideaId) async {
    final prefs = await SharedPreferences.getInstance();
    final ideas = await getIdeas();
    
    ideas.removeWhere((idea) => idea.id == ideaId);
    final encoded = jsonEncode(ideas.map((i) => i.toJson()).toList());
    await prefs.setString(_ideasKey, encoded);
  }
}
