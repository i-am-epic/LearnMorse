class CharacterAnalytics {
  int correctAttempts;
  int totalAttempts;
  int totalTime; // Add time property
  int hintsUsed; // Add hintsUsed property

  CharacterAnalytics({
    required this.correctAttempts,
    required this.totalAttempts,
    required this.totalTime,
    required this.hintsUsed,
  });
}
