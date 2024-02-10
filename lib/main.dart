import 'package:flutter/material.dart';
import 'package:todo_vanilla/todo_item_model.dart';
import 'package:todo_vanilla/todo_listing_screen.dart';

import 'create_todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const title = 'Todo Vanilla';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TodoItem> todoList = [];
  DropdownMenuValues filterValue = DropdownMenuValues.all;

  void changeFilterValue(DropdownMenuValues value) {
    setState(() {
      filterValue = value;
    });
  }

  void toggleTodoStatus(TodoItem todoObj) {
    setState(() {
      todoObj.toggleTodoStatus();
    });
  }

  void createNewTodo(TodoItem todoItem) {
    setState(() {
      todoList.add(todoItem);
    });
  }

  void deleteTodoItem(TodoItem todoItem) {
    setState(() {
      todoList.remove(todoItem);
    });
  }

  void editTodoItem(TodoItem todoItem, int index) {
    setState(() {
      todoList.replaceRange(index, index + 1, [todoItem]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text(widget.title)),
        actions: [
          DropdownButton(
            underline: Container(
              height: 2,
              color: Colors.purpleAccent,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            value: filterValue,
            icon: const Icon(Icons.filter_alt_outlined),
            items: DropdownMenuValues.values.map((DropdownMenuValues item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item.name),
              );
            }).toList(),
            onChanged: (DropdownMenuValues? value) {
              changeFilterValue(value!);
            },
          ),
        ],
      ),
      body: TodoListScreen(
        todoList: todoList,
        toggleTodoStatus: toggleTodoStatus,
        deleteTodoItem: deleteTodoItem,
        editTodoItem: editTodoItem,
        filterValue: filterValue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => CreateTodoScreen(
                      createNewTodo: createNewTodo,
                    )),
          );
        },
        tooltip: 'Create new todo',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
