import 'package:intl/intl.dart';

extension DoubleX on double {
  String toSmartString({int maxDecimals = 6}) {
    if (isInfinite || isNaN) return '—';
    if (abs() >= 1e12 || (abs() < 1e-4 && abs() > 0)) {
      return toStringAsExponential(4);
    }
    final formatted = NumberFormat('#,##0.######').format(this);
    return formatted;
  }
}
