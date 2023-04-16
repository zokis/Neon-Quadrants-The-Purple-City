import 'grid.dart';
import 'player.dart';
import 'square.dart';
import 'line.dart';

class Game {
  late Grid grid;
  List<Player> players;
  int rows;
  int cols;
  int currentPlayerIndex = 0;

  // Constructor initializing a game with a list of players and two integers for creating the grid
  Game(this.players, this.rows, this.cols) {
    if (players.length > 4) {
      throw ArgumentError('The game supports up to 4 players.');
    } else if (players.length < 2){
      throw ArgumentError('The game needs at least 2 players.');
    }
    grid = createNewGrid(rows, cols);
  }

  // Method to create a new grid
  static Grid createNewGrid(int rows, int cols) {
    List<List<Square>> matrix = [];
    int n = 0;
    // Create the matrix of squares
    for (int i = 0; i < rows; i++) {
      List<Square> row = [];
      for (int j = 0; j < cols; j++) {
        Line left = Line("left");
        Line top = Line("top");
        if (i > 0) {
          top = matrix[i - 1][j].bottom;
        }
        if (j > 0) {
          left = row[j - 1].right;
        }
        n = n + 1;
        row.add(Square(left, top, Line("right"), Line("bottom"), '${n}'));
      }
      matrix.add(row);
    }
    
    // Return a new instance of the Grid class with the generated matrix
    return Grid(matrix);
  }

  // Method to play a turn
  List<Square> playTurn(int row, int col, Line selectedLine) {
    Player currentPlayer = getCurrentPlayer();
    if (!selectedLine.click(currentPlayer)) {
      throw ArgumentError('Line already clicked or invalid side provided.');
    }
    List<Square> qs = grid.getLastCompletedSquare(currentPlayer);
    if (qs.length == 0){
      currentPlayerIndex = (currentPlayerIndex + 1) % players.length;
    }
    return qs;
  }

  Player getCurrentPlayer() {
    return players[currentPlayerIndex];
  }
}