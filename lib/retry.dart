import "package:rester/report.dart";
import 'package:rester/types.dart';

Rester withRetry(
  Rester rester, {
  int count = 5,
  Duration duration = const Duration(seconds: 5),
  Iterable<int> statusCodes = const [429, 500, 501, 502, 503],
}) {
  return (url, {headers, body, encoding}) async {
    final response = await rester(url, headers: headers, body: body);

    if (count == 0) {
      return response;
    }

    if (statusCodes.contains(response.statusCode)) {
      report("Response status code is ${response.statusCode}. Retrying...");

      await Future.delayed(duration);

      return withRetry(
        rester,
        count: count - 1,
        duration: duration,
        statusCodes: statusCodes,
      )(
        url,
        headers: headers,
        body: body,
        encoding: encoding,
      );
    }

    return response;
  };
}
