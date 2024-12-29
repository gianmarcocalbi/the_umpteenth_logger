import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:the_umpteenth_logger/the_umpteenth_logger.dart';

final class TestPrinter extends Printer {
  final List<LogItem> logItems = [];

  TestPrinter({
    required super.minLevel,
    required super.formatter,
  });

  @override
  void log(
    LoggerLevel level,
    String source,
    Zone zone,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    final item = formatter.format(
      level,
      source,
      zone,
      message,
      error,
      stackTrace,
    );
    logItems.add(item);
    debugPrint('''
item: {
    source: ${item.source},
    dateTime: ${item.dateTime},
    timestamp: ${item.timestamp},
    prefix: ${item.prefix},
    message: ${item.message},
    error: ${item.error},
}
''');
  }
}
