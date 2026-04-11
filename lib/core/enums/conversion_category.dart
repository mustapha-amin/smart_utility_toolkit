import 'package:flutter/material.dart';

enum ConversionCategory {
  length(
    ['m', 'km', 'mi', 'ft', 'in', 'cm', 'yd', 'nmi'],
    'Length',
    Icons.straighten,
  ),
  temperature(['°C', '°F', 'K'], 'Temperature', Icons.thermostat),
  weight(['kg', 'g', 'lb', 'oz', 't', 'st'], 'Weight', Icons.scale),
  speed(['m/s', 'km/h', 'mph', 'kn', 'ft/s'], 'Speed', Icons.speed),
  area(['m²', 'km²', 'ft²', 'ac', 'ha', 'mi²'], 'Area', Icons.crop_square),
  data(['B', 'KB', 'MB', 'GB', 'TB', 'bit'], 'Data', Icons.sd_storage);

  final List<String> units;
  final String label;
  final IconData icon;

  const ConversionCategory(this.units, this.label, this.icon);

  String get defaultFrom => units[0];
  String get defaultTo => units[1];
}
