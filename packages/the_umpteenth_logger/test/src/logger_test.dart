// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:the_umpteenth_logger/the_umpteenth_logger.dart';

import '../util/test_printer.dart';

void main() {
  final printer = TestPrinter(
    minLevel: LoggerLevel.all,
    formatter: const Formatter(),
  );
  final logger = NthLogger('LoggerTest');

  group('Logger', () {
    test('should print info message', () {
      NthLogger.disableAllPrinters();
      NthLogger.enablePrinter(printer);
      logger.i('Info message');
      expect(
        printer.logItems.last.message.contains('Info message'),
        isTrue,
      );
    });
    test('should print many messages', () {
      NthLogger.disableAllPrinters();
      NthLogger.enablePrinter(NthLogger.consolePrinter);
      final random = Random();
      const words = [
        'apple',
        'banana',
        'cherry',
        'date',
        'elderberry',
        'fig',
        'grape',
        'honeydew',
        'kiwi',
        'lemon',
        'mango',
        'nectarine',
        'orange',
        'papaya',
        'quince',
        'raspberry',
        'strawberry',
        'tangerine',
        'ugli',
        'vanilla',
        'watermelon',
        'xigua',
        'yam',
        'zucchini',
      ];

      for (var i = 0; i < 100; i++) {
        final word = words[random.nextInt(words.length)];
        logger.i('Info message $i: $word');
      }
    });
  });
}
