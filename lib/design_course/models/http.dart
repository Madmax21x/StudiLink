import 'dart:convert';
import 'package:best_flutter_ui_templates/design_course/cours.dart';

import "package:http/http.dart" as http;

class RequestResult
{
  bool ok;
  dynamic data;
  RequestResult(this.ok, this.data);
}

Future<RequestResult> http_get(String route, [dynamic data]) async
{
  var url = "http://192.168.1.50/cours";
  var result = await http.get(url);
  return RequestResult(true, jsonDecode(result.body));
}
Future<RequestResult> http_post(String route, [dynamic data]) async
{
  var url = "http://192.168.1.50/$route";
  var dataStr = jsonEncode(data);
  var result = await http.post(url, body: dataStr, headers:{"Content-Type":"application/json"});
  return RequestResult(true, jsonDecode(result.body));
}

/// a modifier
Future<Cours> deleteCours(String id) async {
  final http.Response response = await http.delete(
    'https://192.168.1.50/cours/$id',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON. After deleting,
    // you'll get an empty JSON `{}` response.
    // Don't return `null`, otherwise `snapshot.hasData`
    // will always return false on `FutureBuilder`.
    return Cours.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to delete course.');
  }
}