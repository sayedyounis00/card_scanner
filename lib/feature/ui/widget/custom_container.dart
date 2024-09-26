import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onTap;
  const CustomContainer({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.teal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon),
              const SizedBox(
                height: 10,
              ),
              Text(title)
            ],
          ),
        ),
      ),
    );
  }
}
