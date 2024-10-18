import 'package:flutter/material.dart';
import 'package:top_examer/utils/themes.dart';

class textFormField extends StatelessWidget {
  final String label;
  final String? hint;

  final double? height;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;
  final EdgeInsets? contentPadding;
  final int? minLines;
  final int? maxLines;
  const textFormField({
    super.key,
    required this.label,
    this.hint,
    required this.onChanged,
      this.height,
    this.keyboardType = TextInputType.text,
    required this.validator,
    required this.controller,
    this.contentPadding,
      this.minLines,
      this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: height,
      child: TextFormField(
        minLines: minLines,
        maxLines: maxLines,
        keyboardType: keyboardType,
        controller: controller,
        style: TextStyle(
          fontFamily: Themes.fontFamily,
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: colorScheme.onSurface,
        ),
        autofocus: false,
        onChanged: onChanged,
        validator: validator,
        cursorColor: colorScheme.onSurface,
        decoration: InputDecoration(
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: colorScheme.onSurface,
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: colorScheme.onSurface,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            // Focused error border color
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
          errorStyle: TextStyle(color: colorScheme.onPrimary),
        ),
      ),
    );
  }
}
