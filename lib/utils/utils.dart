import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

extension LocationExtension on BuildContext {
  AppLocalizations get l10n {
    final localizations = AppLocalizations.of(this);
    if (localizations == null) {
      throw FlutterError('AppLocalizations.of(context) returned null. ');
    }
    return localizations;
  }
}
