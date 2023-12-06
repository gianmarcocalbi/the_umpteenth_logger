import 'package:flutter/foundation.dart';

import '../../the_umpteenth_logger.dart';

/// Mixin to provide a [NthLogger] instance to a class.
///
/// Prefer using this mixin instead of defining a static const [NthLogger]
/// instance directly in the class! In this way parent classes and
/// implementations can share the same logger.
///
/// ### Do
///
/// ```dart
/// abstract class Parent with LoggerMixin {
///   @nonVirtual
///   void parentMethod() {
///     logger.i('Parent method called');
///   }
/// }
///
/// class Child extends Parent {
///   @override
///   Logger get logger => const Logger('Child');
/// }
/// ```
///
/// ### Avoid
///
/// ```dart
/// abstract class Parent with LoggerMixin {
///   static const _logger = Logger('Parent');
///   @nonVirtual
///   void parentMethod() {
///     _logger.i('Parent method called');
///   }
/// }
///
/// class Child extends Parent {
///   static const _logger = Logger('Child');
/// }
/// ```
mixin LoggerMixin {
  late final NthLogger _logger = NthLogger(runtimeType.toString());

  @protected
  NthLogger get logger => _logger;
}
