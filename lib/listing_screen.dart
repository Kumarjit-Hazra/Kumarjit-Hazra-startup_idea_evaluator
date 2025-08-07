import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'idea_provider.dart';
import 'submission_screen.dart';

class ListingScreen extends StatelessWidget {
  const ListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'rating') {
                Provider.of<IdeaProvider>(context, listen: false)
                    .sortIdeasByRating();
              } else if (value == 'votes') {
                Provider.of<IdeaProvider>(context, listen: false)
                    .sortIdeasByVotes();
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'rating',
                child: Text('Sort by Rating'),
              ),
              PopupMenuItem(
                value: 'votes',
                child: Text('Sort by Votes'),
              ),
            ],
          ),
        ],
      ),
      body: Consumer<IdeaProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.ideas.length,
            itemBuilder: (context, index) {
              final idea = provider.ideas[index];
              return Dismissible(
                key: Key(idea.id),
                onDismissed: (direction) {
                  provider.deleteIdea(idea.id);
                  Fluttertoast.showToast(
                    msg: "${idea.name} deleted",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                },
                background: Container(
                  color: Theme.of(context).colorScheme.error,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20.0),
                  child: FaIcon(FontAwesomeIcons.trash, color: Theme.of(context).colorScheme.onError),
                ),
                child: Card(
                  child: ExpansionTile(
                    title: Text(idea.name),
                    subtitle: Text(idea.tagline),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(idea.description),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Rating: ${idea.rating}'),
                          IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.thumbsUp,
                              color: provider.isUpvoted(idea.id)
                                  ? Theme.of(context).primaryColor
                                  : null,
                            ),
                            onPressed: () {
                              if (!provider.isUpvoted(idea.id)) {
                                provider.upvote(idea.id);
                                Fluttertoast.showToast(
                                  msg: "You upvoted ${idea.name}",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: "You've already upvoted this idea",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                );
                              }
                            },
                          ),
                          Text('${idea.votes}'),
                          IconButton(
                            icon: const FaIcon(FontAwesomeIcons.share),
                            onPressed: () {
                              Share.share(
                                  'Check out this startup idea: ${idea.name} - ${idea.tagline}');
                            },
                          ),
                          Text('AI Score: ${idea.viabilityScore.toStringAsFixed(2)}'),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SubmissionScreen()),
          );
        },
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}
