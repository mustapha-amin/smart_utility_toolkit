import 'package:units_converter/units_converter.dart';
import '../core/enums/conversion_category.dart';

abstract final class ConverterUtils {
  static double convert({
    required double value,
    required String from,
    required String to,
    required ConversionCategory category,
  }) {
    if (from == to) return value;
    return switch (category) {
      ConversionCategory.length => _convertLength(value, from, to),
      ConversionCategory.temperature => _convertTemperature(value, from, to),
      ConversionCategory.weight => _convertWeight(value, from, to),
      ConversionCategory.speed => _convertSpeed(value, from, to),
      ConversionCategory.area => _convertArea(value, from, to),
      ConversionCategory.data => _convertData(value, from, to),
    };
  }

  static double _convertLength(double value, String from, String to) {
    final fromUnit = _lengthMap[from];
    final toUnit = _lengthMap[to];
    if (fromUnit == null || toUnit == null) return value;
    return value.convertFromTo(fromUnit, toUnit) ?? value;
  }

  static double _convertTemperature(double value, String from, String to) {
    final fromUnit = _temperatureMap[from];
    final toUnit = _temperatureMap[to];
    if (fromUnit == null || toUnit == null) return value;
    return value.convertFromTo(fromUnit, toUnit) ?? value;
  }

  static double _convertWeight(double value, String from, String to) {
    final fromUnit = _weightMap[from];
    final toUnit = _weightMap[to];
    if (fromUnit == null || toUnit == null) return value;
    return value.convertFromTo(fromUnit, toUnit) ?? value;
  }

  static double _convertSpeed(double value, String from, String to) {
    final fromUnit = _speedMap[from];
    final toUnit = _speedMap[to];
    if (fromUnit == null || toUnit == null) return value;
    return value.convertFromTo(fromUnit, toUnit) ?? value;
  }

  static double _convertArea(double value, String from, String to) {
    final fromUnit = _areaMap[from];
    final toUnit = _areaMap[to];
    if (fromUnit == null || toUnit == null) return value;
    return value.convertFromTo(fromUnit, toUnit) ?? value;
  }

  static double _convertData(double value, String from, String to) {
    final fromUnit = _dataMap[from];
    final toUnit = _dataMap[to];
    if (fromUnit == null || toUnit == null) return value;
    return value.convertFromTo(fromUnit, toUnit) ?? value;
  }

  static final _lengthMap = <String, dynamic>{
    'm': LENGTH.meters,
    'km': LENGTH.kilometers,
    'mi': LENGTH.miles,
    'ft': LENGTH.feet,
    'in': LENGTH.inches,
    'cm': LENGTH.centimeters,
    'yd': LENGTH.yards,
    'nmi': LENGTH.nauticalMiles,
  };

  static final _temperatureMap = <String, dynamic>{
    '°C': TEMPERATURE.celsius,
    '°F': TEMPERATURE.fahrenheit,
    'K': TEMPERATURE.kelvin,
  };

  static final _weightMap = <String, dynamic>{
    'kg': MASS.kilograms,
    'g': MASS.grams,
    'lb': MASS.pounds,
    'oz': MASS.ounces,
    't': MASS.tonnes,
    'st': MASS.stones,
  };

  static final _speedMap = <String, dynamic>{
    'm/s': SPEED.metersPerSecond,
    'km/h': SPEED.kilometersPerHour,
    'mph': SPEED.milesPerHour,
    'kn': SPEED.knots,
    'ft/s': SPEED.feetsPerSecond,
  };

  static final _areaMap = <String, dynamic>{
    'm²': AREA.squareMeters,
    'km²': AREA.squareKilometers,
    'ft²': AREA.squareFeet,
    'ac': AREA.acres,
    'ha': AREA.hectares,
    'mi²': AREA.squareMiles,
  };

  static final _dataMap = <String, dynamic>{
    'B': DIGITAL_DATA.byte,
    'KB': DIGITAL_DATA.kilobyte,
    'MB': DIGITAL_DATA.megabyte,
    'GB': DIGITAL_DATA.gigabyte,
    'TB': DIGITAL_DATA.terabyte,
    'bit': DIGITAL_DATA.bit,
  };
}
