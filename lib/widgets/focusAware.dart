import 'package:flutter/material.dart';

class FocusAware extends StatefulWidget {
  final Widget child;
  final ValueChanged<bool> onFocusChange;

  const FocusAware({
    Key? key,
    required this.child,
    required this.onFocusChange,
  }) : super(key: key);

  @override
  State<FocusAware> createState() => _FocusAwareState();
}

class _FocusAwareState extends State<FocusAware> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      widget.onFocusChange(_focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      child: widget.child,
    );
  }
}
