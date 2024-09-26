import 'package:flutter/material.dart';

class OutPutCardInfo extends StatelessWidget {
  final TextEditingController cont1;
  final TextEditingController cont2;
  const OutPutCardInfo({
    super.key,
    required this.cont1,
    required this.cont2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: cont1,
            decoration: const InputDecoration(
                enabled: false, disabledBorder: UnderlineInputBorder()),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextField(
            controller: cont2,
            decoration: const InputDecoration(
                enabled: false, disabledBorder: UnderlineInputBorder()),
          ),
        ),
      ],
    );
  }
}
