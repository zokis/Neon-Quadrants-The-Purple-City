import 'utils.dart';

// Player class representing a player in the game
class Player {
  late String identifier;
  late String name;
  int score = 0; // Initialize score to 0

  // Constructor initializing a player with a name
  Player(String name) {
    this.name = name;
    this.identifier = generateRandomString();
  }
}
