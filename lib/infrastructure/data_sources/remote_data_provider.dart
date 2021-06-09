import 'dart:convert';

import 'package:safemoon_faucet_mobile_flutter/infrastructure/repository/api.dart';
import 'package:http/http.dart' as http;

class RemoteDataProvider {

  Api api = Api();

  Future<Map<String, dynamic>> getSafemoonData() async {
    final http.Response res = await api.get('7gHjBh7YK');
    return json.decode(res.body)['data']['coin'];
  }
}