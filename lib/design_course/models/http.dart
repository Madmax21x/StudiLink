import 'dart:convert';
import 'package:flutter/rendering.dart';
import "package:http/http.dart" as http;


class RequestResult {
  bool ok;
  dynamic data;
  RequestResult(this.ok, this.data);
}

Future<RequestResult> http_get(String route, [dynamic data]) async {
  var url = "http://studilink.online/studibase.group";
  var result = await http.get(url);
  return RequestResult(true, jsonDecode(result.body));
}

Future<RequestResult> http_post(String route, [dynamic data]) async {
  var url = "http://studilink.online/$route";
  var dataStr = jsonEncode(data);
  var result = await http.post(url, body: dataStr,
      headers: {
          'Content-Type': 'application/json; charset=UTF-8',
      });

  return RequestResult (true, jsonDecode(result.body));
}

Future<RequestResult> http_update(String route, String id, [dynamic bio]) async {
  var url = "http://studilink.online/$route/$id";
  var dataStr = jsonEncode(bio);
  var result = await http.post(url, body: dataStr,
      headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
      });

  return RequestResult (true, jsonDecode(result.body));
}

/// a modifier
Future<bool> deleteCours(String id) async {
  final http.Response response = await http.delete(
    'http://studilink.online/studibase.group/$id',
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
  }
}
