import "dart:developer";

import "package:flutter/foundation.dart";
import 'package:rester/types.dart';

Rester withRetry(
  Rester rester, [
  int count = 5,
  Iterable<int> statusCodes = const [429, 500, 501, 502, 503],
]) {
  return (url, {headers, body, encoding}) async {
    final response = await rester(url, headers: headers, body: body);

    if (count == 0) {
      return response;
    }

    if (statusCodes.contains(response.statusCode)) {
      if (kDebugMode) {
        log("Response status code is ${response.statusCode}. Retrying...");
      }

      await Future.delayed(const Duration(milliseconds: 1000));

      return withRetry(rester, count - 1, statusCodes)(
        url,
        headers: headers,
        body: body,
        encoding: encoding,
      );
    }

    return response;
  };
}
