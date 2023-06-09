import 'dart:convert';
import 'package:http/http.dart';
import 'package:rester/report.dart';
import 'package:rester/response.dart';
import 'package:rester/types.dart';

String _prettyJson(Object? value) {
  if (value is String) {
    return const JsonEncoder.withIndent(" ").convert(jsonDecode(value));
  }

  return const JsonEncoder.withIndent(" ").convert(value);
}

String _getRequestInfo(Uri url, String? method) {
  return "${url.path}${method != null ? " ($method)" : ""}";
}

void _logRequest(Uri url, String? method,
    {Map<String, String>? headers, Object? body}) {
  report(
      "Request ${_getRequestInfo(url, method)}${headers?.isNotEmpty == true ? "\nHeaders: ${_prettyJson(headers)}" : ""}${body != null ? "\nBody: ${_prettyJson(body)}" : ""}");
}

void _logResponse(Uri url, String? method, Response response) {
  report(
      "Response ${response.statusCode} ${_getRequestInfo(url, method)}${response.body.isEmpty ? "" : "\nBody: ${_prettyJson(response.json)}"}");
}

Rester Function(Rester rester) withLog([String? method]) {
  return (rester) {
    return (url, {headers, body, encoding}) async {
      _logRequest(url, method, headers: headers);

      final response = await rester(
        url,
        headers: headers,
        body: body,
        encoding: encoding,
      );

      _logResponse(url, method, response);

      return response;
    };
  };
}

Rester withGetLog(Getter getter) => withLog("GET")(toRester(getter));

final withPostLog = withLog("POST");

final withPutLog = withLog("PUT");

final withPatchLog = withLog("PATCH");

final withDeleteLog = withLog("DELETE");
