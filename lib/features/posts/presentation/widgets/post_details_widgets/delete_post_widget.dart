import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/strings/bloc_strings.dart';
import '../../bloc/operations/operations_bloc.dart';

class DeletePostWidget extends StatelessWidget {
  final int postId;
  const DeletePostWidget({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(PublicStrings.postDetailAlertDialogTitle),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(PublicStrings.postDetailAlertDialogNo)),
        TextButton(
            onPressed: () => BlocProvider.of<OperationsBloc>(context).add(DeletePostEvent(postId: postId)),
            child: const Text(PublicStrings.postDetailAlertDialogYes)),
      ],
    );
  }
}
