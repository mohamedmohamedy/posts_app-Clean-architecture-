import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/snack_bar.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../bloc/operations/operations_bloc.dart';
import '../../pages/home.dart';
import 'delete_post_widget.dart';

class DeleteButtonWidget extends StatelessWidget {
  final int postId;

  const DeleteButtonWidget({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(primary: Colors.redAccent),
      icon: const Icon(Icons.delete_outline_outlined),
      label: const Text('Delete'),
      onPressed: () => deletePost(context),
    );
  }

  void deletePost(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<OperationsBloc, OperationsState>(
          listener: (context, state) {
            if (state is SuccessState) {
              SnackBarUtil().getSnackBar(
                  context: context,
                  message: state.successMessage,
                  color: Colors.green);
              Navigator.of(context).pushNamed(HomeScreen.routeName);
            } else if (state is FailState) {
              Navigator.of(context).pop();
              SnackBarUtil().getSnackBar(
                  context: context,
                  message: state.failMessage,
                  color: Colors.redAccent);
            }
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return const AlertDialog(
                title: LoadingWidget(),
              );
            }
            return DeletePostWidget(postId: postId);
          },
        );
      },
    );
  }
}
