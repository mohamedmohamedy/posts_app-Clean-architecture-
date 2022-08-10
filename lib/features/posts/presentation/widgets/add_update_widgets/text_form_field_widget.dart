import 'package:flutter/material.dart';

class TexTFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isMultiLine;
  const TexTFormFieldWidget({
    Key? key,
    required this.controller, required this.hint, required this.isMultiLine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration:  InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
        validator: (value) => value!.isEmpty ? '$hint can\'t be empty' : null,
        minLines: isMultiLine ? 6 : 1,
        maxLines: isMultiLine ? 6 : 1,
      ),
    );
  }
}
