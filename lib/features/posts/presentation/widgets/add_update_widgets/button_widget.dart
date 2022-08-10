import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final void Function() function;
  final bool isUpdate;
  const ButtonWidget({Key? key, required this.function, required this.isUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: function,
      icon: isUpdate ? const Icon(Icons.edit) : const Icon(Icons.add),
      label: isUpdate ? const Text('Update') : const Text('Add'),
    );
  }
}
