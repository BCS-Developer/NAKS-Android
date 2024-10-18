import 'package:flutter/material.dart';
import 'package:top_examer/utils/themes.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final String? error;
  final double height;
  final ValueChanged<String>? onChanged;
  const CustomTextField({
    super.key,
    required this.label,
    this.hint,
    required this.onChanged,
    this.error,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      // width: width,
      height: height,
      //padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        style: TextStyle(
          fontFamily: Themes.fontFamily,
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: colorScheme.onSurface,
        ),
        maxLines: 1,
        keyboardType: TextInputType.number,
        autofocus: false,
        maxLength: 10,
        onChanged: onChanged,
        cursorColor: colorScheme.onSurface,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: colorScheme
                  .onSurface, // Set the border color for enabled state
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: colorScheme.secondary,
              width: 2.0,
            ),
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: isDarkMode
                ? colorScheme.onSurface.withOpacity(0.7)
                : colorScheme.onSurface.withOpacity(0.6),
          ),
          labelText: label,
          labelStyle: TextStyle(
            color: isDarkMode ? colorScheme.onSurface : colorScheme.onSurface,
          ),
          errorText: error,
          errorStyle: TextStyle(color: colorScheme.onPrimary),
        ),
      ),
    );
  }
}
