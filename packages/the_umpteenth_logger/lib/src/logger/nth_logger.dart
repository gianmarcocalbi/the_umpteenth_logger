import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../the_umpteenth_logger.dart';

export '../common/log_item.dart';
export '../common/log_utils.dart';
export '../common/logger_level.dart';
export '../formatter/formatter.dart';
export 'logger_mixin.dart';

/// {@template logger}
/// The main logger class.
/// {@endtemplate}
class NthLogger {
  /// {@macro logger}
  const NthLogger(this._source, [this._zone = Zone.root]);

  final String _source;
  final Zone _zone;

  static final Printer consolePrinter = ConsolePrinter(
    minLevel: LoggerLevel.trace,
    formatter: const Formatter(
      useColors: false,
      colorOnlyLevel: false,
    ),
  );

  static final Printer devLogPrinter = DevLogPrinter(
    minLevel: LoggerLevel.trace,
    formatter: const Formatter(
      useColors: true,
      colorOnlyLevel: false,
    ),
  );

  static Set<Printer> _printers = {
    // Enable a console log.
    if (kDebugMode) NthLogger.devLogPrinter else NthLogger.consolePrinter,
  };

  static void enablePrinter(Printer printer) {
    _printers.add(printer);
  }

  static void disablePrinter(Printer printer) {
    _printers.remove(printer);
  }

  static void disableAllPrinters() {
    _printers = {};
  }

  /// Log a message at level [LoggerLevel.verbose].
  void v(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    for (final p in _printers) {
      p.log(
        LoggerLevel.trace,
        _source,
        _zone,
        message,
        error,
        stackTrace,
      );
    }
  }

  /// Log a message at level [LoggerLevel.debug].
  void d(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    for (final p in _printers) {
      p.log(
        LoggerLevel.debug,
        _source,
        _zone,
        message,
        error,
        stackTrace,
      );
    }
  }

  /// Log a message at level [LoggerLevel.info].
  void i(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    for (final p in _printers) {
      p.log(
        LoggerLevel.info,
        _source,
        _zone,
        message,
        error,
        stackTrace,
      );
    }
  }

  /// Log a message at level [LoggerLevel.warning].
  void w(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    for (final p in _printers) {
      p.log(
        LoggerLevel.warning,
        _source,
        _zone,
        message,
        error,
        stackTrace,
      );
    }
  }

  /// Log a message at level [LoggerLevel.error].
  void e(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    for (final p in _printers) {
      p.log(
        LoggerLevel.error,
        _source,
        _zone,
        message,
        error,
        stackTrace,
      );
    }
  }

  /// Log a message at level [LoggerLevel.severe].
  void wtf(
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    for (final p in _printers) {
      p.log(
        LoggerLevel.severe,
        _source,
        _zone,
        message,
        error,
        stackTrace,
      );
    }
  }
}
