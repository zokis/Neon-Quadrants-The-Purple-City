import 'dart:math';
import 'dart:html';
import 'utils.dart';
import 'game.dart';
import 'line.dart';
import 'grid.dart';
import 'square.dart';
import 'player.dart';
import 'bridge.dart';


void main() {
  final TableElement table = querySelector('#battleground-table') as TableElement;
  final DivElement battleground = querySelector('#battleground') as DivElement;
  final DivElement loading = querySelector('#loading-screen') as DivElement;
  final Game g = Game([Player('human'), Player('computer 1')], 8, 13);
  final Element player1Html = querySelector('#player1') as Element;
  final Element player2Html = querySelector('#player2') as Element;

  player1Html.text = g.players[0].name;
  player2Html.text = g.players[1].name;

  // Printing the matrix
  List<List<Square>> matrix = g.grid.matrix;
  for (int i = 0; i < matrix.length; i++) {
    for (int j = 0; j < matrix[i].length; j++) {
      print('Square at ($i, $j, ${matrix[i][j].completed}):');
      print('Left: ${matrix[i][j].left}');
      print('Top: ${matrix[i][j].top}');
      print('Right: ${matrix[i][j].right}');
      print('Bottom: ${matrix[i][j].bottom}');
      print('');
    }
  }

  final Bridge bridge = Bridge(table, g);
  bridge.renderGridHTML();

  battleground.style.setProperty("background-image", getRndBg());
  loading.animate([{"opacity": 100}, {"opacity": 0}], 700);
  loading.remove();
  table.animate([{"opacity": 0}, {"opacity": 100}], 800);
  table.style.setProperty("opacity", "100");
}