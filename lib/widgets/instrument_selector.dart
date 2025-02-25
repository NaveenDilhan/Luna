import 'package:flutter/material.dart';

class InstrumentSelector extends StatelessWidget {
  final String selectedInstrument;
  final ValueChanged<String> onInstrumentChanged;

  const InstrumentSelector({
    Key? key,
    required this.selectedInstrument,
    required this.onInstrumentChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedInstrument,
      items: ['Piano', 'Guitar', 'Drums'].map((String value) {
        return DropdownMenuItem(value: value, child: Text(value));
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          onInstrumentChanged(newValue);
        }
      },
    );
  }
}
