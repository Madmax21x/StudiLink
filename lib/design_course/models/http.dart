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
  var url = "http://192.168.1.50/cours";
  var result = await http.get(url);
  return RequestResult(true, jsonDecode(result.body));
}

Future<RequestResult> http_post(String route, [dynamic data]) async {
  var url = "http://192.168.1.50/$route";
  print("data print :");
  debugPrint(data.toString());
  var dataStr = jsonEncode(data);
  var result = await http
      .post(url, body: dataStr, headers: {"Content-Type": "application/json"});
  debugPrint("on est ici 1 ==========");
  print(result.body);
  return RequestResult(true, jsonDecode(result.body));
}

/// a modifier
Future<bool> deleteCours(String id) async {
  final http.Response response = await http.delete(
    'http://192.168.1.50/cours/$id',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    debugPrint(id);
    debugPrint((response.body));
    return true;
  } else {
    throw Exception('Failed to delete course.');
  };
  
}
