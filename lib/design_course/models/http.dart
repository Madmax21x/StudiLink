import 'dart:convert';

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
Future<RequestResult> http_delete(String route, [dynamic data]) async
{
  var url = "http://192.168.1.50/$route";
  var result = await http.delete(url, headers:{"Content-Type":"application/json"});
  return RequestResult(true, jsonDecode(result.body));
}
