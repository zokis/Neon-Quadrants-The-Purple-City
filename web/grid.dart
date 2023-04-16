import 'square.dart';
import 'player.dart';

// Grid class representing the game grid
class Grid {
  List<List<Square>> matrix;

  // Constructor initializing a grid with a matrix of squares
  Grid(this.matrix);

  // Method to check if all squares in the grid are completed
  bool checkCompletion() {
    return matrix.every((row) => row.every((square) => square.completed));
  }

  List<Square> getLastCompletedSquare(Player p) {
    List<Square> qs = [];
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        Square q = matrix[i][j];
        if (!q.completed && q.checkCompletion(p)){
          qs.add(q);
        }
      }
    }
    return qs;
  }
}