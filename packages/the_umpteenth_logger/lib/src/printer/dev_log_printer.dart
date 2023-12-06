// ignore_for_file: type_annotate_public_apis

import 'dart:async';
import 'dart:developer' as developer;

import '../../the_umpteenth_logger.dart';

/// {@template dev_log_printer}
/// A printer that prints log messages to the dart developer console.
/// {@endtemplate}
class DevLogPrinter extends Printer {
  /// {@macro dev_log_printer}
  DevLogPrinter({
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
    developer.log(
      '${parts.timestamp} ${parts.prefix} ${parts.message}',
      time: DateTime.now().toUtc(),
      level: level.value,
      name: parts.source,
      zone: zone,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
