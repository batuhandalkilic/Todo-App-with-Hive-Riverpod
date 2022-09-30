import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kendi_todo_ui_hive_riverpod/Home/home.view_model.dart';
import '../model/todo.dart';

final complatedTask = Provider<int?>((ref) {
  int? complatedTask = ref.watch(ListTaskProvider)?.where((element) => element.isCompleted == true).toList().length;
  return complatedTask;
});

final changeFilterProvider = StateProvider<FilterList>((ref) {
  return FilterList.tumu;
});

class Filter_bar extends ConsumerWidget {
  const Filter_bar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int? complatedCounter = ref.watch(complatedTask);

    // int? aa = ref.watch(counterTaskProvider); // her restart da çalışır and state değişiminde
    return Row(
      children: <Widget>[
        Expanded(flex: 1, child: Text('$complatedCounter Görev Tamamlandı')),
        Expanded(
          child: TextButton(
            style: TextButton.styleFrom(
              primary: ref.watch(changeFilterProvider) == FilterList.tumu ? Colors.red : Colors.black,
            ),
            onPressed: () {
              ref.read(changeFilterProvider.notifier).state = FilterList.tumu;
            },
            child: const Text("Tüm Görevler", style: TextStyle(fontSize: 12)),
          ),
        ),
        Expanded(
          child: TextButton(
            style: TextButton.styleFrom(
              primary: ref.watch(changeFilterProvider) == FilterList.tamamlanan ? Colors.red : Colors.black,
            ),
            onPressed: () {
              ref.read(changeFilterProvider.notifier).state = FilterList.tamamlanan;
            },
            child: const Text("Tamamlanan Görev", style: TextStyle(fontSize: 12)),
          ),
        ),
        Expanded(
          child: TextButton(
            style: TextButton.styleFrom(
              primary: ref.watch(changeFilterProvider) == FilterList.tamamlanmayan ? Colors.red : Colors.black,
            ),
            onPressed: () {
              ref.read(changeFilterProvider.notifier).state = FilterList.tamamlanmayan;
            },
            child: const Text("Tamamlanmayan Görev", style: TextStyle(fontSize: 12)),
          ),
        ),
      ],
    );
  }
}
