import 'dart:math';

class AIService {
  static int generateFakeRating(String name, String tagline, String description) {
    final random = Random();
    
    // Generate a pseudo-random rating based on content
    final content = '$name $tagline $description'.toLowerCase();
    
    // Keywords that might influence rating
    final buzzwords = [
      'ai', 'blockchain', 'crypto', 'metaverse', 'web3', 'machine learning',
      'neural', 'quantum', 'disrupt', 'innovative', 'revolutionary', 'unicorn'
    ];
    
    final negativeWords = [
      'boring', 'old', 'traditional', 'slow', 'expensive', 'complicated'
    ];
    
    int baseRating = 50 + random.nextInt(30);
    
    // Adjust based on buzzwords
    for (final word in buzzwords) {
      if (content.contains(word)) {
        baseRating += random.nextInt(10);
      }
    }
    
    // Adjust based on negative words
    for (final word in negativeWords) {
      if (content.contains(word)) {
        baseRating -= random.nextInt(10);
      }
    }
    
    // Add some randomness
    baseRating += random.nextInt(20) - 10;
    
    // Ensure rating is between 0-100
    return baseRating.clamp(0, 100);
  }

  static String generateFakeFeedback(int rating) {
    if (rating >= 90) {
      return "Revolutionary concept! This could be the next unicorn! 🦄";
    } else if (rating >= 80) {
      return "Strong idea with great potential! Investors will love this! 💰";
    } else if (rating >= 70) {
      return "Solid concept! With some refinement, this could be big! 📈";
    } else if (rating >= 60) {
      return "Good foundation! Consider pivoting or adding unique features 🤔";
    } else if (rating >= 40) {
      return "Interesting start, but needs significant development 🛠️";
    } else {
      return "Back to the drawing board! Keep brainstorming! 💡";
    }
  }
}
