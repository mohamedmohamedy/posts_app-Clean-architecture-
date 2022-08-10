import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/strings/bloc_strings.dart';
import '../../../../core/util/snack_bar.dart';
import '../../domain/entities/post_entitiy.dart';
import '../bloc/operations/operations_bloc.dart';
import 'home.dart';
import '../widgets/add_update_widgets/form_builder.dart';

class AddOrUpdateScreen extends StatelessWidget {
  static const String routeName = RoutesName.addOrUpdateRoute;

  final PostEntity? post;
  final bool isUpdate;

  const AddOrUpdateScreen({Key? key, this.post, required this.isUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: _getBody(context),
    );
  }

  AppBar _getAppBar() => AppBar(
        title: Text(isUpdate ? 'Update post' : 'Add post'),
      );
  Widget _getBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocConsumer<OperationsBloc, OperationsState>(
          listener: (context, state) {
            if (state is SuccessState) {
              SnackBarUtil().getSnackBar(
                context: context,
                message: state.successMessage,
                color: Colors.green,
              );
              Navigator.of(context).pushNamedAndRemoveUntil(
                  HomeScreen.routeName, (route) => false);
            } else if (state is FailState) {
              SnackBarUtil().getSnackBar(
                context: context,
                message: state.failMessage,
                color: Colors.redAccent,
              );
            }
          },
          builder: (context, state) => FormBuilder(
            isUpdate: isUpdate,
            post: isUpdate ? post : null,
          ),
        ),
      ),
    );
  }
}
