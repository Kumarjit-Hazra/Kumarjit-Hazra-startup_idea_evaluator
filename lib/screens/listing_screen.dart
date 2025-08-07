import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/idea.dart';
import '../providers/idea_provider.dart';
import '../services/ai_service.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  _ListingScreenState createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  bool _sortByVotes = true;

  @override
  Widget build(BuildContext context) {
    final ideaProvider = Provider.of<IdeaProvider>(context);
    final ideas = ideaProvider.ideas;

    if (ideas.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lightbulb_outline,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            const Text(
              'No ideas yet!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Be the first to submit an idea!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    final sortedIdeas = List<Idea>.from(ideas);
    sortedIdeas.sort((a, b) => _sortByVotes 
        ? b.votes.compareTo(a.votes) 
        : b.aiRating.compareTo(a.aiRating));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'All Ideas',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Text('Sort by:'),
                  const SizedBox(width: 8),
                  DropdownButton<bool>(
                    value: _sortByVotes,
                    items: const [
                      DropdownMenuItem(
                        value: true,
                        child: Text('Votes'),
                      ),
                      DropdownMenuItem(
                        value: false,
                        child: Text('AI Rating'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _sortByVotes = value);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => ideaProvider.loadIdeas(),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: sortedIdeas.length,
              itemBuilder: (context, index) {
                final idea = sortedIdeas[index];
                return _buildIdeaCard(idea);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIdeaCard(Idea idea) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        idea.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        idea.tagline,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getRatingColor(idea.aiRating),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${idea.aiRating}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              idea.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_up),
                  color: Colors.blue,
                  onPressed: () => _handleVote(idea.id),
                ),
                Text(
                  '${idea.votes} votes',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _confirmDelete(idea.id),
                ),
                TextButton(
                  onPressed: () => _showIdeaDetails(idea),
                  child: const Text('Read more'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getRatingColor(int rating) {
    if (rating >= 80) return Colors.green;
    if (rating >= 60) return Colors.orange;
    return Colors.red;
  }

  void _handleVote(String ideaId) async {
    final ideaProvider = Provider.of<IdeaProvider>(context, listen: false);
    await ideaProvider.upvoteIdea(ideaId);
  }

  void _confirmDelete(String ideaId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Idea'),
        content: const Text('Are you sure you want to delete this idea?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final ideaProvider = Provider.of<IdeaProvider>(context, listen: false);
              ideaProvider.deleteIdea(ideaId);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showIdeaDetails(Idea idea) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      idea.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                idea.tagline,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getRatingColor(idea.aiRating),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'AI Rating: ${idea.aiRating}% - ${AIService.generateFakeFeedback(idea.aiRating)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Description:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                idea.description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.thumb_up),
                    color: Colors.blue,
                    onPressed: () => _handleVote(idea.id),
                  ),
                  Text(
                    '${idea.votes} votes',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _confirmDelete(idea.id),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
