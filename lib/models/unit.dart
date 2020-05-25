class Unit {
  String name;
  String symbol;
  double conversion;
  bool baseUnit;

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

  Map<String, dynamic> toJson() => {
        "name": name,
        "symbol": symbol,
        "conversion": conversion,
        "base_unit": baseUnit == null ? null : baseUnit,
      };
}
