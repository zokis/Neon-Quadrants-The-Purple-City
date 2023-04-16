import 'dart:math';
// Helper method to generate a random string as a unique identifier
String generateRandomString() {
  const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  final _rnd = Random();
  return String.fromCharCodes(Iterable.generate(10, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}

String getRndBg() {
  List<int> bgs = [1, 2, 3, 4];
  final _rnd = Random();
  int bgn = bgs[_rnd.nextInt(bgs.length)];
  return "url('static/bg${bgn}.png')";
}
