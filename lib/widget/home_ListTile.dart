import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../Home/home.view_model.dart';
import '../model/todo.dart';

class Home_ListTile extends ConsumerWidget {
  const Home_ListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo>? list = ref.watch(ListTaskProvider);

    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: list?.length,
      itemBuilder: (BuildContext context, int index) {
        Todo? currentTodo = list?[index];
        return Dismissible(
          onDismissed: (direction) async {
            await ref.read(hiveProvider.notifier).deleteTask(currentTodo ?? Todo("error"));
            // print(list);
          },
          key: Key(currentTodo?.id ?? Uuid().v1()),
          child: ListTile(
            leading: Checkbox(
              value: currentTodo?.isCompleted,
              onChanged: (value) async {
                await ref.read(hiveProvider.notifier).toggle(currentTodo!, value!);
              },
            ),
            title: Text(currentTodo?.task ?? ""),
          ),
        );
      },
    );
  }
}
