import 'package:flutter/material.dart';
import 'package:todo_vanilla/todo_item_model.dart';

class TodoItemDetailScreen extends StatefulWidget {
  final int index;
  final TodoItem todoObj;
  final Function editTodo;
  final Function deleteTodo;
  const TodoItemDetailScreen({super.key,required this.todoObj, required this.editTodo, required this.deleteTodo, required this.index,});

  @override
  State<TodoItemDetailScreen> createState() => _TodoItemDetailScreenState();
}

class _TodoItemDetailScreenState extends State<TodoItemDetailScreen> {
  // internal state (local state)
  bool isEditEnable = false;

  // text controllers for text input values
  final textTitleController = TextEditingController();
  final textDescController = TextEditingController();

  @override
  void initState() {
    textTitleController.text = widget.todoObj.title;
    textDescController.text = widget.todoObj.description;
    super.initState();
  }

  //internal methods
  void toggleEditMode() {
    setState(() {
      isEditEnable = !isEditEnable;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textTitleController.dispose();
    textDescController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const screenTitle = "Todo Details";
    const textStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Center(child: Text(screenTitle)),
        actions: [
          IconButton(onPressed: () {
            widget.deleteTodo(widget.todoObj);
            Navigator.of(context).pop();
          }, icon: const Icon(Icons.delete_outline)),
          IconButton(onPressed: () {
            toggleEditMode();
          }, icon: Icon(isEditEnable ? Icons.close: Icons.edit_note)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Title", style: textStyle),
            TextField(
              enabled: isEditEnable,
              controller: textTitleController,
              decoration: InputDecoration(
                border: isEditEnable ? const UnderlineInputBorder(): InputBorder.none,
              ),
            ),
            const SizedBox(height: 20),
            const Text("Description", style: textStyle),
            TextField(
              enabled: isEditEnable,
              controller: textDescController,
              decoration: InputDecoration(
                border: isEditEnable ? const UnderlineInputBorder(): InputBorder.none,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: isEditEnable ? FloatingActionButton(
        onPressed: () {
          if (textTitleController.text.isNotEmpty && (textTitleController.text != widget.todoObj.title ||  textDescController.text != widget.todoObj.description)) {
            final todoItem = TodoItem(title: textTitleController.text, description: textDescController.text);
            widget.editTodo(todoItem, widget.index);
            Navigator.of(context).pop();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Center(child: Text("Title cannot be empty or There is no change !", style: textStyle,)))
            );
          }
        },
        tooltip: 'Edit todo',
        child: const Text("Done", style: textStyle,),
      ): Container(),
    );
  }
}
