import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/idea.dart';
import '../providers/idea_provider.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ideaProvider = Provider.of<IdeaProvider>(context);
    final topIdeas = ideaProvider.getTopIdeas(5);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Leaderboard',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: topIdeas.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.emoji_events,
                    size: 100,
                    color: Colors.amber,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'No leaderboard yet!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Submit ideas to see them climb the ranks!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: topIdeas.length,
              itemBuilder: (context, index) {
                final idea = topIdeas[index];
                return _buildLeaderboardItem(idea, index + 1, context);
              },
            ),
    );
  }

  Widget _buildLeaderboardItem(Idea idea, int rank, BuildContext context) {
    Color medalColor;
    IconData medalIcon;
    
    switch (rank) {
      case 1:
        medalColor = Colors.amber;
        medalIcon = Icons.emoji_events;
        break;
      case 2:
        medalColor = Colors.grey;
        medalIcon = Icons.emoji_events;
        break;
      case 3:
        medalColor = Colors.brown;
        medalIcon = Icons.emoji_events;
        break;
      default:
        medalColor = Colors.blue;
        medalIcon = Icons.star;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: medalColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$rank',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(medalIcon, color: medalColor, size: 24),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          idea.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    idea.tagline,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.thumb_up, size: 16, color: Colors.blue),
                      const SizedBox(width: 4),
                      Text(
                        '${idea.votes} votes',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.auto_graph, size: 16, color: Colors.green),
                      const SizedBox(width: 4),
                      Text(
                        '${idea.aiRating}% AI',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
