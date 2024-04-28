import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({super.key, required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.lightBlueAccent),
              foregroundColor: MaterialStatePropertyAll(Colors.white)),
          onPressed: onPressed,
          child: Text(label, style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
