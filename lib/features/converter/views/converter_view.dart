import 'package:flutter/material.dart';
import '../../../core/enums/conversion_category.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../controllers/converter_controller.dart';
import '../widgets/unit_dropdown.dart';
import '../widgets/conversion_input.dart';
import '../widgets/result_display.dart';
import '../widgets/swap_button.dart';

class ConverterView extends StatefulWidget {
  final ConversionCategory category;
  const ConverterView({super.key, required this.category});

  @override
  State<ConverterView> createState() => _ConverterViewState();
}

class _ConverterViewState extends State<ConverterView> {
  late final ConverterController _controller;
  final TextEditingController _inputTec = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = ConverterController(category: widget.category);
  }

  @override
  void dispose() {
    _controller.dispose();
    _inputTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(_controller.category.label),
            actions: [
              if (_controller.hasInput)
                GestureDetector(
                  onTap: () {
                    _controller.clear();
                    _inputTec.clear();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text('clear', style: AppTextStyles.bodySecondary),
                  ),
                ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),

                Text('FROM', style: AppTextStyles.label),
                const SizedBox(height: 10),
                UnitDropdown(
                  units: _controller.units,
                  selected: _controller.fromUnit,
                  onChanged: _controller.setFromUnit,
                ),
                const SizedBox(height: 12),
                ConversionInput(
                  controller: _inputTec,
                  onChanged: _controller.setInput,
                  hint: '0',
                ),

                const SizedBox(height: 24),
                Center(
                  child: SwapButton(
                    onTap: () {
                      _controller.swap();
                      if (_controller.hasInput) {
                        _inputTec.text = _controller.inputValue
                            .toStringAsFixed(
                              _controller.inputValue.truncateToDouble() ==
                                      _controller.inputValue
                                  ? 0
                                  : 4,
                            )
                            .replaceAll(RegExp(r'0+$'), '')
                            .replaceAll(RegExp(r'\.$'), '');
                      }
                    },
                  ),
                ),
                const SizedBox(height: 24),

                Text('TO', style: AppTextStyles.label),
                const SizedBox(height: 10),
                UnitDropdown(
                  units: _controller.units,
                  selected: _controller.toUnit,
                  onChanged: _controller.setToUnit,
                ),
                const SizedBox(height: 20),

                ResultDisplay(
                  result: _controller.result,
                  unit: _controller.toUnit,
                  hasInput: _controller.hasInput,
                ),

                const SizedBox(height: 48),
              ],
            ),
          ),
        );
      },
    );
  }
}
