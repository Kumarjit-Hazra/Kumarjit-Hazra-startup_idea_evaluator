import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'idea_provider.dart';


class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: Consumer<IdeaProvider>(
        builder: (context, provider, child) {
          final topIdeas = provider.ideas.toList()
            ..sort((a, b) => b.votes.compareTo(a.votes));
          final top5 = topIdeas.take(5).toList();

          return ListView.builder(
            itemCount: top5.length,
            itemBuilder: (context, index) {
              final idea = top5[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: _getBadge(context, index),
                  title: Text(
                    idea.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Votes: ${idea.votes}',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _getBadge(BuildContext context, int index) {
    switch (index) {
      case 0:
        return const Text('🥇', style: TextStyle(fontSize: 24));
      case 1:
        return const Text('🥈', style: TextStyle(fontSize: 24));
      case 2:
        return const Text('🥉', style: TextStyle(fontSize: 24));
      default:
        return Text('${index + 1}',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor));
    }
  }
}
