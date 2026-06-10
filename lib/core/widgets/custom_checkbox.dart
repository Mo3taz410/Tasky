import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({super.key, required this.value, required this.onChanged});
  final bool value;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      activeColor: Color(0xFF15B86C),
    );
  }
}
