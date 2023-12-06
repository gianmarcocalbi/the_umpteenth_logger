/// Enum for the different levels of logging.
enum LoggerLevel implements Comparable<LoggerLevel> {
  /// Special key to turn on logging for all levels.
  all(0),
  trace(300),
  debug(400),
  info(500),
  warning(700),
  error(800),
  severe(1000),

  /// Special key to turn off all logging.
  off(2000);

  factory LoggerLevel.fromName(String name) =>
      values.firstWhere((element) => element.name == name.toUpperCase());

  final int value;

  const LoggerLevel(this.value);

  bool operator <(LoggerLevel other) => value < other.value;

  bool operator <=(LoggerLevel other) => value <= other.value;

  bool operator >(LoggerLevel other) => value > other.value;

  bool operator >=(LoggerLevel other) => value >= other.value;

  @override
  int compareTo(LoggerLevel other) => value - other.value;
}
