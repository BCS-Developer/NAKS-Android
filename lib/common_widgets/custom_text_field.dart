import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:top_examer/utils/themes.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final String? error;
  final double height;
  final String? counterText;
  final ValueChanged<String>? onChanged;
  const CustomTextField(
      {super.key,
      required this.label,
      this.hint,
      required this.onChanged,
      this.error,
      required this.height,
      this.counterText});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String _selectedCountryCode = '+1';
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: widget.height,
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
        onChanged: widget.onChanged,
        cursorColor: colorScheme.onSurface,
        decoration: InputDecoration(
          prefix: GestureDetector(
            onTap: () {
              showCountryPicker(
                context: context,
                showPhoneCode: true,
                onSelect: (Country country) {
                  setState(() {
                    _selectedCountryCode =
                        '+${country.phoneCode}'; // Update country code
                  });
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _selectedCountryCode, // Display the selected country code
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: colorScheme.onSurface,
                  ),
                ],
              ),
            ),
          ),
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
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: isDarkMode
                ? colorScheme.onSurface.withOpacity(0.7)
                : colorScheme.onSurface.withOpacity(0.6),
          ),
          labelText: widget.label,
          labelStyle: TextStyle(
            color: isDarkMode ? colorScheme.onSurface : colorScheme.onSurface,
          ),
          errorText: widget.error,
          errorStyle: TextStyle(color: colorScheme.onPrimary),
        ),
      ),
    );
  }
}
