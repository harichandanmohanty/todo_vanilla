import 'package:flutter/material.dart';
import 'package:todo_vanilla/todo_item_model.dart';
import 'package:todo_vanilla/todo_item_widget.dart';

class TodoListScreen extends StatelessWidget {
  final List<TodoItem> todoList;
  final Function toggleTodoStatus;
  final Function deleteTodoItem;
  final Function editTodoItem;
  final DropdownMenuValues filterValue;
  const TodoListScreen({super.key, required this.todoList, required this.toggleTodoStatus, required this.deleteTodoItem, required this.editTodoItem, required this.filterValue});

  bool visibilityCheck(TodoItem item) {
    switch(filterValue) {
      case DropdownMenuValues.pending:
        return !item.isCompleted;
      case DropdownMenuValues.completed:
        return item.isCompleted;
      case DropdownMenuValues.all:
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var index = 0;
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: todoList
            .map((todoObj) => Visibility(
              visible: visibilityCheck(todoObj),
              child: TodoItemWidget(
                    todoObj: todoObj,
                    toggleTodoStatus: toggleTodoStatus,
                    deleteTodoItem: deleteTodoItem,
                    editTodoItem: editTodoItem,
                    index: index++,
                  ),
            ))
            .toList(),
      ),
    );
  }
}
