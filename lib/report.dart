import 'dart:developer';

import 'package:flutter/foundation.dart';

void report(Object object) {
  if (kDebugMode) {
    final now = DateTime.now().toIso8601String().split("T")[1];

    log("[$now] $object");
  }
}
