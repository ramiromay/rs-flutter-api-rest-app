import 'package:flutter/material.dart';

class InputText extends StatelessWidget {

  final String label;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool borderEnable;
  final double fontSize;
  final void Function(String text)? onChanged;
  final String? Function(String? text)? validator;

  const InputText({
    super.key,
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.borderEnable = true,
    this.fontSize = 15,
    this.onChanged,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    const UnderlineInputBorder underlineInputBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black12),
    );
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: TextStyle(fontSize: fontSize),
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 5),
        enabledBorder: borderEnable ? underlineInputBorder : InputBorder.none,
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.black45,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
