import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/buttons/buttons_constants.dart';

class TextIconButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final void Function() onPressed;

  const TextIconButton({super.key, required this.text, required this.icon, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          const SizedBox(
            width: iconSpacing,
          ),
          Icon(icon),
        ],
      ),
    );
  }
}
