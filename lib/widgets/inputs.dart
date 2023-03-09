import 'package:flutter/material.dart';

class InputPadding extends StatelessWidget {
  final Widget child;
  const InputPadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(243, 240, 238, 1),
      ),
      child: child,
    );
  }
}
