import 'package:http/http.dart';
import 'package:rester/types.dart';

Rester multipartRequest([String method = "POST"]) {
  return (url, {headers, body, encoding}) async {
    if (body is! MultipartFile) {
      throw Exception("The body parameter should be a mutlipart file");
    }

    final request = MultipartRequest(method, url);

    if (headers != null) {
      request.headers.addAll(headers);
    }

    request.files.add(body);

    final stream = await request.send();

    return Response.fromStream(stream);
  };
}
