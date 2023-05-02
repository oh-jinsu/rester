import 'dart:convert';

import 'package:http/http.dart';

typedef Getter = Future<Response> Function(
  Uri url, {
  Map<String, String>? headers,
});

Getter toGetter(Rester rester) {
  return (url, {headers}) {
    return rester(url, headers: headers);
  };
}

typedef Rester = Future<Response> Function(
  Uri url, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
});

Rester toRester(Getter getter) {
  return (url, {headers, body, encoding}) {
    return getter(url, headers: headers);
  };
}
