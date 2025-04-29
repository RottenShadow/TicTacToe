class GameBaseModel {
  final String playerOName;
  final String playerXName;
  final int difficulty;
  final bool isAgainstAI;

  const GameBaseModel({
    required this.playerOName,
    required this.playerXName,
    required this.isAgainstAI,
    required this.difficulty, //Hard
  });

  factory GameBaseModel.isAgainstAI(
      {required bool isAgainstAI, int difficulty = 1}) {
    if (isAgainstAI) {
      return GameBaseModel(
        playerOName: 'AI',
        playerXName: 'You',
        difficulty: difficulty,
        isAgainstAI: true,
      );
    }
    return GameBaseModel(
      playerOName: 'Player 2',
      playerXName: 'Player 1',
      difficulty: difficulty,
      isAgainstAI: false,
    );
  }
}
