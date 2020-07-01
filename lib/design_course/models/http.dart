import 'dart:convert';
import 'package:best_flutter_ui_templates/design_course/cours.dart';
import 'package:flutter/rendering.dart';

import "package:http/http.dart" as http;

class RequestResult {
  bool ok;
  dynamic data;
  RequestResult(this.ok, this.data);
}

Future<RequestResult> http_get(String route, [dynamic data]) async {
  var url = "http://192.168.0.27/cours";
  var result = await http.get(url);
  return RequestResult(true, jsonDecode(result.body));
}

Future<RequestResult> http_post(String route, [dynamic data]) async {
  var url = "http://192.168.0.27/$route";
  var dataStr = jsonEncode(data);
  var result = await http
      .post(url, body: dataStr, headers: {"Content-Type": "application/json"});
  return RequestResult(true, jsonDecode(result.body));
}

/// a modifier
Future deleteCours(String id) async {
  final http.Response response = await http.delete(
    'http://192.168.0.27/cours/$id',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    debugPrint(id);
    debugPrint((response.body));
    return;
  } else {
    throw Exception('Failed to delete course.');
  }
}
