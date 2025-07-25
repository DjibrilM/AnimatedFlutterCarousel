import 'package:flutter/material.dart';

class TransparentInput extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final void Function() onTap;
  final TapRegionCallback onTapOut;
  final TextEditingController controller;
  final FocusNode focusNode;

  const TransparentInput({
    required this.focusNode,
    required this.controller,
    required this.onTap,
    required this.onTapOut,
    super.key,
    required this.onChanged,
    this.hintText = 'Search...',
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onTap: onTap,
      onChanged: onChanged,
      onTapOutside: onTapOut,
      focusNode: focusNode,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white54),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        isDense: true,
      ),
    );
  }
}
