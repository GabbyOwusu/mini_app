import 'dart:developer';

import 'package:flutter/foundation.dart';

void handleError(dynamic e, {StackTrace? stackTrace, bool fatal = false}) {
  if (kDebugMode) {
    log(
      ">>>>>>>>> $e",
      stackTrace: stackTrace ?? StackTrace.current,
      name: 'handleError',
      time: DateTime.now(),
    );
  } else {
    /// Send the error to logging service
  }
}
