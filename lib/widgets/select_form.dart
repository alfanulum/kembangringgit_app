import 'package:flutter/material.dart';

class SelectForm extends StatelessWidget {
  SelectForm({
    Key? key,
    required this.items,
    required this.onChanged,
    required this.value,
    required this.textEditingController,
    required this.text,
  }) : super(key: key);

  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? value;
  final TextEditingController textEditingController;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: (newValue) {
          // Update the controller's value when the selection changes
          textEditingController.text = newValue!;
          onChanged(newValue);
        },
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        decoration: InputDecoration(
          hintText: text,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
