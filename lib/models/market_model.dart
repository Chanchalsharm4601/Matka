class Market {
  final String name;
  final String result;
  final String openTime;
  final String closeTime;

  Market({
    required this.name,
    required this.result,
    required this.openTime,
    required this.closeTime,
  });

  factory Market.fromJson(Map<String, dynamic> json) {
    return Market(
      name: json['name'],
      result: json['result'],
      openTime: json['open_time'],
      closeTime: json['close_time'],
    );

  }
  String getStatus() {
    final now = DateTime.now();
    final open = _convertTime(openTime);
    final close = _convertTime(closeTime);

    return (now.isAfter(open) && now.isBefore(close))
        ? "Market Running"
        : "Market Closed";
  }
  DateTime _convertTime(String time) {
    final split = time.split(':');
    final hour = int.parse(split[0]);
    final minute = int.parse(split[1].split(' ')[0]);
    final isPM = split[1].contains('PM');
    return DateTime.now().copyWith(
      hour: isPM && hour != 12 ? hour + 12 : hour,
      minute: minute,
      second: 0,
    );
  }

}