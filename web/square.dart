import 'line.dart';
import 'player.dart';

// Square class representing a square in the game grid
class Square {
  Line left;
  Line top;
  Line right;
  Line bottom;
  String name;
  bool completed = false;
  Player? player;

  // Constructor initializing a square with four lines
  Square(this.left, this.top, this.right, this.bottom, this.name) {
    checkCompletion();
  }

  Line getLineByP(String p) {
    if (p == 'left'){
      return left;
    }
    if (p == 'top'){
      return top;
    }
    if (p == 'right'){
      return right;
    }
    return bottom;
  }

  // Method to check if a square is completed and update score of the player if so
  bool checkCompletion([Player? p]) {
    if (completed) {
      return true;
    }
    if (right.player != null && left.player != null && top.player != null && bottom.player != null) {
      completed = true;
      if (p != null) {
        p.score += 1;
        player = p;
      }
    }
    return completed;
  }
}