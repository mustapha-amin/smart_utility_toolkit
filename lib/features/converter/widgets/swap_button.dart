import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SwapButton extends StatefulWidget {
  final VoidCallback onTap;
  const SwapButton({super.key, required this.onTap});

  @override
  State<SwapButton> createState() => _SwapButtonState();
}

class _SwapButtonState extends State<SwapButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animCtrl;
  late final Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _rotation = Tween(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  void _handleTap() {
    _animCtrl.forward(from: 0.0);
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.cardGradient,
          border: Border.all(color: AppColors.border),
        ),
        child: RotationTransition(
          turns: _rotation,
          child: const Icon(
            Icons.swap_vert_rounded,
            color: AppColors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
