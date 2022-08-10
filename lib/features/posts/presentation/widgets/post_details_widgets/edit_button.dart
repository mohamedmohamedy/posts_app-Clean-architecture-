import 'package:flutter/material.dart';

import '../../../../../core/strings/bloc_strings.dart';
import '../../../domain/entities/post_entitiy.dart';
import '../../pages/add_update.dart';

class EditButtonWidget extends StatelessWidget {
  const EditButtonWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  final PostEntity post;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddOrUpdateScreen(
            isUpdate: true,
            post: post,
          ),
        ),
      ),
      icon: const Icon(Icons.edit),
      label: const Text(PublicStrings.postDetailEditButton),
    );
  }
}
