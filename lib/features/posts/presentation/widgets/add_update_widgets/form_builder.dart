import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/post_entitiy.dart';
import '../../bloc/operations/operations_bloc.dart';
import 'button_widget.dart';
import 'text_form_field_widget.dart';

class FormBuilder extends StatefulWidget {
  final PostEntity? post;
  final bool isUpdate;
  const FormBuilder({Key? key, this.post, required this.isUpdate})
      : super(key: key);

  @override
  State<FormBuilder> createState() => _FormBuilderState();
}

class _FormBuilderState extends State<FormBuilder> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdate) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TexTFormFieldWidget(
                controller: _titleController,
                hint: 'Title',
                isMultiLine: false),
            TexTFormFieldWidget(
                controller: _bodyController, hint: 'Body', isMultiLine: true),
            ButtonWidget(function: _submitForm, isUpdate: widget.isUpdate),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    final isValid = _formKey.currentState!.validate();
    final post = PostEntity(
      id: widget.isUpdate ? widget.post!.id : 0,
      title: _titleController.text,
      body: _bodyController.text,
    );
    if (isValid) {
      if (widget.isUpdate) {
        BlocProvider.of<OperationsBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<OperationsBloc>(context).add(AddPostEvent(post: post));
      }
    }
  }
}
