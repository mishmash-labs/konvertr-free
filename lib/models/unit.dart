class Unit {
  String name;
  double conversion;
  bool baseUnit;

  Unit({
    this.name,
    this.conversion,
    this.baseUnit,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        name: json["name"],
        conversion: json["conversion"].toDouble(),
        baseUnit: json["base_unit"] == null ? null : json["base_unit"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "conversion": conversion,
        "base_unit": baseUnit == null ? null : baseUnit,
      };
}
