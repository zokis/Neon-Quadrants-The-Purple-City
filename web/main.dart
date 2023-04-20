import 'dart:math';
import 'dart:html';
import 'utils.dart';
import 'game.dart';
import 'line.dart';
import 'grid.dart';
import 'square.dart';
import 'player.dart';
import 'bridge.dart';


Game gameUriFactory(){
  final String? param = Uri.base.queryParameters['rabfle'];
  if (param != null){
    final Map<String, dynamic> gameMap = decodeZ(param);
    final List<dynamic> playersList = gameMap['players'] as List<dynamic>;
    final List<Player> players = playersList.map((playerData) => Player(playerData['name'] as String)).toList();
    return Game(players, gameMap["grid"][0] as int, gameMap["grid"][1] as int);
  }
  return Game([Player('human'), Player('computer 1')], 4, 4);
}


void main() {
  final Game g = gameUriFactory();
  final TableElement table = querySelector('#battleground-table') as TableElement;
  final DivElement battleground = querySelector('#battleground') as DivElement;
  final DivElement loading = querySelector('#loading-screen') as DivElement;

  g.players.asMap().forEach((int i, Player p){
    final Element playerHtml = querySelector('#player${i+1}') as Element;
    playerHtml.text = g.players[i].name;
  });

  // Printing the matrix
  // List<List<Square>> matrix = g.grid.matrix;
  // for (int i = 0; i < matrix.length; i++) {
  //   for (int j = 0; j < matrix[i].length; j++) {
  //     print('Square at ($i, $j, ${matrix[i][j].completed}):');
  //     print('Left: ${matrix[i][j].left}');
  //     print('Top: ${matrix[i][j].top}');
  //     print('Right: ${matrix[i][j].right}');
  //     print('Bottom: ${matrix[i][j].bottom}');
  //     print('');
  //   }
  // }

  final Bridge bridge = Bridge(table, g);
  bridge.renderGridHTML();

  battleground.style.setProperty("background-image", getRndBg());
  loading.animate([{"opacity": 100}, {"opacity": 0}], 700);
  loading.remove();
  table.animate([{"opacity": 0}, {"opacity": 100}], 800);
  table.style.setProperty("opacity", "100");

  print(encodeZ({
    "grid": [8, 8],
    "players": [
      {
        "name": "Zokis",
        "d": 0
      },
      {
        "name": "Marília",
        "d": 1
      }
    ]
  }));
}