import 'dart:html';
import 'game.dart';
import 'square.dart';
import 'line.dart';
import 'player.dart';

class Bridge {
  final Element _htmlElement;
  final Game _game;
  late final Element modalGameOver;
  late final Element playAgain;
  late final Element overlay;

  Bridge(this._htmlElement, this._game){
    modalGameOver = querySelector('#modalGameOver') as Element;
    playAgain = querySelector('#playAgain') as Element;
    overlay = querySelector('#overlay') as Element;
    playAgain.onClick.listen(newGame);
  }
  static int n = 0;
  static Map<String, Map<String, dynamic>> squareMap = new Map();

  static String getSquareName(){
    n = n + 1;
    return '${n}';
  }

  void newGame(MouseEvent me) {
    window.location.reload();
  }

  void renderGridHTML() {
    List<List<Square>> matrix = _game.grid.matrix;
    for (int i = 0; i < matrix.length; i++) {
      _htmlElement.children.add(createHorizontalLines(matrix[i].length, i));
      _htmlElement.children.add(createSquares(matrix[i].length, i));
    }
    _htmlElement.children.add(
      createHorizontalLines(
        matrix[matrix.length - 1].length,
        matrix.length
      )
    );
  }

  List<int> translateLineXYtoSquareXY(int x, int y) {
    if (y >= _game.grid.matrix.length) {
      y = _game.grid.matrix.length - 1;
    }
    if (x >= _game.grid.matrix[y].length) {
      x = _game.grid.matrix[y].length - 1;
    }
    return [x, y];
  }

  Square getSquareByXY(int x, int y) {
    return _game.grid.matrix[y][x];
  }

  Line getLineByXY(int x, int y, String p){
    Line l = Line("aux");
    String xAttr = "left";
    String yAttr = "top";
    List<int> translated = translateLineXYtoSquareXY(x, y);
    if (y > translated[1]) {
      yAttr = "bottom";
      y = _game.grid.matrix.length - 1;
    }
    if (x > translated[0]) {
      xAttr = "right";
      x = _game.grid.matrix[y].length - 1;
    }
    if (p == 'horizontal'){
      l = getSquareByXY(x, y).getLineByP(yAttr);
    } else {
      l = getSquareByXY(x, y).getLineByP(xAttr);
    }
    return l;
  }
  Line getHorizontalLineByXY(int x, int y){
    return getLineByXY(x, y, 'horizontal');
  }
  Line getVerticalLineByXY(int x, int y){
    return getLineByXY(x, y, 'vertical');
  }

  void lineCallback(MouseEvent me, String pos) {
    TableCellElement tdLine = me.target as TableCellElement;
    int dX = int.parse((tdLine.getAttribute("data-x") ?? '0'));
    int dY = int.parse((tdLine.getAttribute("data-y") ?? '0'));
    Line l = getLineByXY(dX, dY, pos);
    if (l != null && l.player != null){
      return null;
    }
    Player p = _game.getCurrentPlayer();
    List<int> translated = translateLineXYtoSquareXY(dX, dY);
    tdLine.classes.add('td-clicked${_game.currentPlayerIndex}');
    List<Square> qs = _game.playTurn(translated[0], translated[1], l);
    int cP = _game.currentPlayerIndex;
    for (final q in qs) {
      TableCellElement? tdSquare = squareMap[q.name]?['td'] as TableCellElement;
      if (tdSquare != null){
        tdSquare.text = p.name[0];
        tdSquare.classes = ["square", "square-c${cP}"];
        SpanElement span = querySelector("#score-player${cP+1}") as SpanElement;
        span.text = "${p.score}";
      }
    }

    _game.players.asMap().forEach((int i, Player p){
      Element playerHtml = querySelector('#player${i+1}') as Element;
      if (cP == i){
        playerHtml.classes = ["red", "blink"];
      } else {
        playerHtml.classes = ["white"];
      }
    });
    if (_game.grid.checkCompletion()) {
      overlay.classes = ["overlay"];
      modalGameOver.classes = ["modal"];
    }
  }

  void lineHorizontalCallback(MouseEvent me){
    lineCallback(me, 'horizontal');
  }
  void lineVerticalCallback(MouseEvent me){
    lineCallback(me, 'vertical');
  }

  TableCellElement createIntersection () {
    final TableCellElement td = TableCellElement();
    td.classes = ['intersection'];
    return td;
  }

  TableCellElement createHorizontalLine (int x, int y) {
    final TableCellElement td = TableCellElement();
    td.classes = ['horizontal-line'];
    td.onClick.listen(lineHorizontalCallback);
    td.setAttribute("data-y", y);
    td.setAttribute("data-x", x);
    return td;
  }

  TableCellElement createVerticalLine (int x, int y) {
    final TableCellElement td = TableCellElement();
    td.classes = ['vertical-line'];
    td.onClick.listen(lineVerticalCallback);
    td.setAttribute("data-y", y);
    td.setAttribute("data-x", x);
    return td;
  }

  TableCellElement createSquare (int x, int y) {
    final TableCellElement td = TableCellElement();
    td.classes = ['square'];
    String sqName = getSquareName();
    // td.text = sqName;
    td.setAttribute("data-y", y);
    td.setAttribute("data-x", x);
    squareMap[sqName] = new Map<String, dynamic>();
    squareMap[sqName]?['td'] = td;
    squareMap[sqName]?['square'] = getSquareByXY(x, y);
    return td;
  }

  TableRowElement createHorizontalLines (int c, int y) {
    final TableRowElement tr = TableRowElement();
    tr.classes = ['horizontal-lines'];
    for(int i = 0; i < c; i++){
      tr.children.add(createIntersection());
      tr.children.add(createHorizontalLine(i, y));
    }
    tr.children.add(createIntersection());
    return tr;
  }

  TableRowElement createSquares (int c, int x) {
    final TableRowElement tr = TableRowElement();
    tr.classes = ['row'];
    for(int i = 0; i < c; i++){
      tr.children.add(createVerticalLine(i, x));
      tr.children.add(createSquare(i, x));
    }
    tr.children.add(createVerticalLine(c, x));
    return tr;
  }
}
