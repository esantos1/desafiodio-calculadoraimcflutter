import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.onChanged,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String labelText;
  final ValueChanged? onChanged;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        label: Text(labelText),
        border: OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}
