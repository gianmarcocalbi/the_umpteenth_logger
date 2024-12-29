import 'dart:async';
import 'dart:convert';

import 'package:ansicolor/ansicolor.dart';
import 'package:intl/intl.dart';

import '../common/log_item.dart';
import '../common/logger_level.dart';

class Formatter {
  const Formatter({
    this.useColors = true,
    this.includeClassReference = false,
    this.colorOnlyLevel = false,
    this.colorEachLine = false,
  });

  final bool includeClassReference;
  final bool useColors;
  final bool colorOnlyLevel;
  final bool colorEachLine;
  static const int sourceLength = 20;

  static final RegExp _classReference =
      RegExp(r'^#\d+\s+(?<method>.+) \(.+\/[^\/\:]+\:(?<line>[0-9:]+)\).*$');

  static final Map<LoggerLevel, String> _prefixes = {
    LoggerLevel.trace: '[TRACE]',
    LoggerLevel.debug: '[DEBUG]',
    LoggerLevel.info: '[INFO ]',
    LoggerLevel.warning: '[WARN ]',
    LoggerLevel.error: '[ERROR]',
    LoggerLevel.severe: '[WTF!!]',
  };

  static final Map<LoggerLevel, AnsiPen> _colors = {
    LoggerLevel.trace: AnsiPen()..gray(level: 0.5),
    LoggerLevel.debug: AnsiPen()..cyan(),
    LoggerLevel.info: AnsiPen()..green(),
    LoggerLevel.warning: AnsiPen()..yellow(),
    LoggerLevel.error: AnsiPen()..red(),
    LoggerLevel.severe: AnsiPen()..magenta(),
  };

  String _uniformSourceLength(String source) {
    if (source.length > sourceLength) {
      return source.substring(0, sourceLength);
    } else if (source.length < sourceLength) {
      return source.padRight(sourceLength, '─');
    }
    return source;
  }

  String _stringifyMessage(dynamic message) {
    if (message is Map || message is Iterable) {
      const encoder = JsonEncoder.withIndent(null);
      return encoder.convert(message);
    } else {
      return message.toString();
    }
  }

  LogItem format(
    LoggerLevel level,
    String source,
    Zone zone,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    assert(message != null, 'Message must not be null');
    final dateTime = DateTime.now().toUtc();
    ansiColorDisabled = false;
    final String Function(String) col = _colors[level]!.call;

    // Format the time as string
    final time = DateFormat('HH:mm:ss.SSS').format(dateTime);

    // Format source
    final src = _uniformSourceLength(source);

    // Format prefix
    var prefix = _prefixes[level]!;
    prefix = useColors ? col(prefix) : prefix;

    // Format message
    var msg = _stringifyMessage(message);
    if (includeClassReference) {
      final line = StackTrace.current.toString().split('\n').firstWhere(
            (line) => !line.contains('package:the_umpteenth_logger'),
            orElse: () => '',
          );
      if (line.isNotEmpty) {
        final match = _classReference.firstMatch(line);
        if (match != null) {
          final method = match.namedGroup('method')!;
          final line = match.namedGroup('line')!;
          msg = '$msg [$method:$line]';
        }
      }
    }

    // Format stackTrace and error
    final st = stackTrace == null ? '' : '\n\n## STACKTRACE\n$stackTrace';
    var err = error == null
        ? ''
        : '''
####################
## ERROR
$error$st
####################
''';

    // Colorize message and error
    if (useColors && !colorOnlyLevel) {
      if (colorEachLine) {
        msg = msg.split('\n').map(col).join('\n');
        err = err
            .split('\n')
            .map((e) => _colors[LoggerLevel.error]!(e))
            .join('\n');
      } else {
        msg = col(msg);
        err = _colors[LoggerLevel.error]!(err);
      }
    }

    return LogItem(
      source: src,
      message: msg,
      timestamp: time,
      prefix: prefix,
      error: err,
      dateTime: dateTime,
    );
  }
}
