import 'dart:async';

import '../../the_umpteenth_logger.dart';

export 'console_printer.dart';
export 'dev_log_printer.dart';
export 'hive_log_printer.dart';

/// {@template printer}
/// A printer is responsible for printing the log message.
///
/// This class is the parent of all printers implementations.
/// {@endtemplate}
abstract class Printer {
  /// {@macro printer}
  Printer({
    required this.minLevel,
    required this.formatter,
  });

  final LoggerLevel minLevel;
  final Formatter formatter;

  void log(
    LoggerLevel level,
    String source,
    Zone zone,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]);
}
