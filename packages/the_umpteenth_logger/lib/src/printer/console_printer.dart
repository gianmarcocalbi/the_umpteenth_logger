import 'dart:async';

import 'package:flutter/foundation.dart';

import '../common/logger_level.dart';
import 'printer.dart';

/// {@template console_printer}
/// A simple printer that prints log messages to the default console.
/// {@endtemplate}
class ConsolePrinter extends Printer {
  /// {@macro console_printer}
  ConsolePrinter({
    required super.minLevel,
    required super.formatter,
  });

  @override
  void log(
    LoggerLevel level,
    String source,
    Zone zone,
    message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    if (minLevel > level) {
      return;
    }
    final parts = formatter.format(
      level,
      source,
      zone,
      message,
      error,
      stackTrace,
    );
    // If the error is not null with add a new line before it to print it
    // below the log message.
    var err = parts.error ?? '';
    if (error != null) {
      err = '\n$err';
    }
    // Prefer print in web, debugPrint otherwise.
    (kIsWeb ? print : debugPrint).call(
      '[${parts.source}] ${parts.timestamp} ${parts.prefix} '
      '${parts.message}$err',
    );
  }
}
