import 'dart:math';
import 'dart:convert';

// Helper method to generate a random string as a unique identifier
String generateRandomString() {
  const String _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  final _rnd = Random();
  return String.fromCharCodes(Iterable.generate(10, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}

String getRndBg() {
  final List<int> bgs = [1, 2, 3, 4];
  final _rnd = Random();
  final int bgn = bgs[_rnd.nextInt(bgs.length)];
  return "url('static/bg${bgn}.png')";
}

Map<String, dynamic> decodeZ(String p){
	final List<int> decodedBytes = base64.decode(p.split('').reversed.join());
	final String decodedJson = utf8.decode(decodedBytes);
	final String jsonWithoutSalt = decodedJson.replaceAll('EMTAd3.1', '');
	return jsonDecode(jsonWithoutSalt);
}

String encodeZ(Map<String, dynamic> m){
	final String jsonStr = jsonEncode(m);
	final List<int> bytesToEncode = utf8.encode(jsonStr + 'EMTAd3.1');
	final String base64Str = base64.encode(bytesToEncode);
	return base64Str.split('').reversed.join();
}