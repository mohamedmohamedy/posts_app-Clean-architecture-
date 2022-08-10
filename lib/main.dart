import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/posts/presentation/pages/add_update.dart';
import 'features/posts/presentation/pages/post_details.dart';
import 'features/posts/presentation/pages/home.dart';

import 'dependency_container.dart' as di;
import 'features/posts/presentation/bloc/operations/operations_bloc.dart';
import 'features/posts/presentation/bloc/posts/posts_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<PostsBloc>()..add(GetPostsEvent())),
        BlocProvider(create: (_) => di.sl<OperationsBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Posts',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          AddOrUpdateScreen.routeName: (context) => const AddOrUpdateScreen(isUpdate: false),
          PostDetailsScreen.routeName:(context) => const PostDetailsScreen(),
        },
      ),
    );
  }
}
