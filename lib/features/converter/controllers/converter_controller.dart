import 'package:flutter/foundation.dart';
import '../../../core/enums/conversion_category.dart';
import '../../../utils/converter_utils.dart';

class ConverterController extends ChangeNotifier {
  final ConversionCategory category;

  late String fromUnit;
  late String toUnit;
  double inputValue = 0;
  double? result;
  bool hasInput = false;

  ConverterController({required this.category}) {
    fromUnit = category.defaultFrom;
    toUnit = category.defaultTo;
  }

  List<String> get units => category.units;

  void setInput(String raw) {
    final parsed = double.tryParse(raw.replaceAll(',', ''));
    if (parsed == null || raw.trim().isEmpty) {
      inputValue = 0;
      result = null;
      hasInput = false;
    } else {
      inputValue = parsed;
      hasInput = true;
      _compute();
    }
    notifyListeners();
  }

  void setFromUnit(String unit) {
    fromUnit = unit;
    if (hasInput) _compute();
    notifyListeners();
  }

  void setToUnit(String unit) {
    toUnit = unit;
    if (hasInput) _compute();
    notifyListeners();
  }

  void swap() {
    final temp = fromUnit;
    fromUnit = toUnit;
    toUnit = temp;
    if (result != null) {
      inputValue = result!;
      _compute();
    }
    notifyListeners();
  }

  void clear() {
    inputValue = 0;
    result = null;
    hasInput = false;
    notifyListeners();
  }

  void _compute() {
    result = ConverterUtils.convert(
      value: inputValue,
      from: fromUnit,
      to: toUnit,
      category: category,
    );
  }
}
