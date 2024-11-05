import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/todo_list_page.dart';
import './providers/todo_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
      ],
      child: MaterialApp(
        home: TodoListPage(),
      ),
    );
  }
}
