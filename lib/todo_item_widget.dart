import 'package:flutter/material.dart';
import 'package:todo_vanilla/todo_item_details.dart';
import 'package:todo_vanilla/todo_item_model.dart';

class TodoItemWidget extends StatelessWidget {
  const TodoItemWidget({
    super.key,
    required this.todoObj,
    required this.toggleTodoStatus,
    required this.deleteTodoItem,
    required this.editTodoItem,
    required this.index,
  });

  final TodoItem todoObj;
  final Function toggleTodoStatus;
  final Function deleteTodoItem;
  final Function editTodoItem;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(30, 50, 0, 200),
        borderRadius: BorderRadius.circular(10)
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => TodoItemDetailScreen(todoObj: todoObj, editTodo: editTodoItem, deleteTodo: deleteTodoItem, index: index,))
          );
        },
        leading: InkWell(
          onTap: () {
            toggleTodoStatus(todoObj);
          },
          child: todoObj.isCompleted ? const Icon(Icons.check_box_outlined) : const Icon(Icons.check_box_outline_blank),
        ),
        title: Text(
          todoObj.title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(decoration: todoObj.isCompleted ? TextDecoration.lineThrough : TextDecoration.none),
        ),
        subtitle: Text(
          todoObj.description,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(decoration: todoObj.isCompleted ? TextDecoration.lineThrough : TextDecoration.none),
        ),
        trailing: InkWell(
          onTap: () {
            deleteTodoItem(todoObj);
          },
          child: const Icon(Icons.delete_outline),
        ),
      ),
    );
  }
}