class Unit {
  Unit({
    this.name,
    this.symbol,
    this.conversion,
    this.baseUnit,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        name: json["name"],
        symbol: json["symbol"],
        conversion: json["conversion"].toDouble(),
        baseUnit: json["base_unit"] == null ? null : json["base_unit"],
      );

  bool baseUnit;
  double conversion;
  String name;
  String symbol;

  Map<String, dynamic> toJson() => {
        "name": name,
        "symbol": symbol,
        "conversion": conversion,
        "base_unit": baseUnit == null ? null : baseUnit,
      };
}
