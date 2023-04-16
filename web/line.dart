import 'utils.dart';
import 'player.dart';
// Line class representing a line in the game grid
class Line {
  String? p;
  Player? player;
  late String identifier;

  // Constructor initializing a line with an optional player
  Line(this.p){
    this.identifier = generateRandomString();
  }

  // Override the toString method for better representation
  @override
  String toString() {
    String playerName = this.player?.name ?? 'empty';
    return '${playerName} - (${p}) ${identifier}';
  }

  bool click(Player p){
  	if (player == null){
  		player = p;
      return true;
  	}
    return false;
  }
}