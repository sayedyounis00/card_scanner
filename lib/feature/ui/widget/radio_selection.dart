
import 'package:flutter/material.dart';

class RadioSelection extends StatelessWidget {
  final List<String> companyOption;
  final void Function(int?) onChange;
  final int selectdOption;
  const RadioSelection({
    super.key,
    required this.companyOption,
    required this.onChange,
    required this.selectdOption,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: companyOption
          .map((option) => ListTile(
                leading: Radio(
                  value: companyOption.indexOf(option),
                  groupValue: selectdOption,
                  onChanged: onChange,
                ),
                title: Text(option),
              ))
          .toList(),
    );
  }
}
