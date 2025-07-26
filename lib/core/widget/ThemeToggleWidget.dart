import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery_flutter_task/core/Theam/ThemeCubit.dart';

class ThemeToggleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().isDarkMode(context);

    return AnimatedToggleSwitch<bool>.dual(
      current: isDark,
      first: false,
      second: true,
      spacing: 3.0,
      height: 44,
      borderWidth: 2.0,
      animationDuration: const Duration(milliseconds: 350),
      onChanged: (value) => context.read<ThemeCubit>().toggleTheme(),
      iconBuilder: (value) => Icon(
        value ? Icons.nightlight_round : Icons.wb_sunny,
        color: value ? Colors.white : Colors.orange.shade600,
        size: 22,
      ),
      style: ToggleStyle(
        borderRadius: BorderRadius.circular(30.0),
        backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        borderColor: isDark ? Colors.grey.shade700 : Colors.grey.shade400,
        indicatorColor: isDark ? Colors.black : Colors.white,
        indicatorBorderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
    );
  }
}
