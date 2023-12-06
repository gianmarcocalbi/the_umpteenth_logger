import 'package:flutter/foundation.dart';

@immutable
class LogItem {
  final String source;
  final String message;
  final String timestamp;
  final String prefix;
  final String? error;
  final DateTime dateTime;

  LogItem({
    required this.source,
    required this.message,
    required this.timestamp,
    required this.prefix,
    required this.dateTime,
    this.error,
  });
}
