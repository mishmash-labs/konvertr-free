class Unit {
  Unit({
    this.name,
    this.symbol,
    this.conversion,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        name: json['name'],
        symbol: json['symbol'],
        conversion: json['conversion'].toDouble(),
      );

  double conversion;
  String name;
  String symbol;
}
