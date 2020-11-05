import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_state_management/models/todo.dart';

// 1
final todoListProvider = StateNotifierProvider((ref) => new TodoList());

class TodoWidget extends ConsumerWidget {
  const TodoWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // 2
    final todoList = watch(todoListProvider.state);
    return Column(
      children: [
        Container(
          height: 100,
          child: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (BuildContext context, int index) {
              Todo todo = todoList[index];
              return ListTile(
                title: Text(todoList[index].title),
                leading: IconButton(
                  icon: Icon(Icons.edit),
                  // 3
                  onPressed: () {
                    todo.title = 'Updated Title';
                    context.read(todoListProvider).edit(todo);
                  },
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  // 3
                  onPressed: () =>
                      context.read(todoListProvider).remove(todo.id),
                ),
              );
            },
          ),
        ),
        RaisedButton(
          // 3
          onPressed: () => context.read(todoListProvider).add('New Item'),
          child: Text('Add'),
        ),
      ],
    );
  }
}
