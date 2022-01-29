import 'dart:convert';
import 'dart:math';

import 'package:flutter_wordle/constants/constants.dart';
import 'package:http/http.dart' as http;

class API {
  Future<List<dynamic>> getRandomWords() async {
    var headers = <String, String>{};
    headers['x-rapidapi-host'] = host;
    headers['x-rapidapi-key'] = apiKey;
    var rawResponse = await http.get(Uri.parse(baseUrl), headers: headers);
    var response = jsonDecode(rawResponse.body);
    return response;
  }
}
