import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

enum ResterResponseState {
  success,
  failure,
}

extension ResterResponseMapper on Response {
  ResterResponseState get state {
    if (statusCode < 400) {
      return ResterResponseState.success;
    } else {
      return ResterResponseState.failure;
    }
  }

  dynamic get json {
    return body.isNotEmpty ? jsonDecode(utf8.decode(bodyBytes)) : null;
  }

  FutureOr<T> map<T>(FutureOr<T> Function(dynamic json) mapper) {
    return mapper(json);
  }

  String? get message {
    return json?["message"];
  }
}
