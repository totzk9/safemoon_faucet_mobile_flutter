import 'dart:async';

import 'package:http/http.dart' as http;

class Api {
  factory Api() {
    return _instance;
  }

  Api._internal();

  static final Api _instance = Api._internal();

  final String url = 'https://api.coinranking.com/v2/coin/';
  final Map<String, String> _headers = <String, String>{
    'x-access-token':
        'coinranking319ae0db0bed03a9b2c99768f7cfb4909db70c2ed2558d6d',
    'Content-type': 'application/json'
  };

  /// Http GET request.
  ///
  ///
  Future<http.Response> get(String endpoint) async =>
      await http.get(Uri.parse('$url$endpoint'), headers: _headers);
}
