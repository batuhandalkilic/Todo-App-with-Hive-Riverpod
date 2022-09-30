// ignore_for_file: unused_local_variable

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:kendi_todo_ui_hive_riverpod/model/todo.dart';
import '../widget/home_filter_bar.dart';

final ListTaskProvider = Provider<List<Todo>?>((ref) {
  // ignore: non_constant_identifier_names
  List<Todo>? ListTask;
  if (ref.watch(hiveProvider)!.isEmpty) {
    return ListTask = ref.watch(hiveProvider.notifier).getValues();
  } else {
    FilterList filter = ref.watch(changeFilterProvider);
    switch (filter) {
      case FilterList.tumu:
        return ListTask = ref.watch(hiveProvider);
      case FilterList.tamamlanan:
        return ListTask = ref.watch(hiveProvider)?.where((element) => element.isCompleted == true).toList();
      case FilterList.tamamlanmayan:
        return ListTask = ref.watch(hiveProvider)?.where((element) => element.isCompleted == false).toList();
    }
  }
});

final hiveProvider = StateNotifierProvider<HiveNotifier, List<Todo>?>((ref) {
  return HiveNotifier("myBox");
});

class HiveNotifier extends StateNotifier<List<Todo>?> {
  late Box<Todo>? _box;
  final String _boxName;

  HiveNotifier(this._boxName) : super([]);

  //open box
  void _register() {
    if (!(Hive.isAdapterRegistered(0))) {
      Hive.registerAdapter(TodoAdapter());
      Hive.registerAdapter(FilterListAdapter());
    }
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));
    _register();
    if (!(Hive.isBoxOpen("myBox"))) {
      _box = await Hive.openBox(_boxName);
      print(_box?.isOpen.toString());
    }
  }

  // add task and update state
  void _updateState() {
    state = _box?.values.toList();
  }

  Future<void> putItem(Todo todo) async {
    await _box?.put(todo.id, todo);
    _updateState();
  }

  // when don't change state, get list from hive with todo in list
  // burada state değişimine gerek kalmadan hive kendi özelliğini
  // kullarak başlangıçta cache edilenleri gösteriyoruz
  // kullanıcı bir task girerse onu yukarıda textFormfield ile hemen
  // alıp state güncelliyoruz
  List<Todo>? getValues() {
    return _box?.values.toList();
  }

  // clear all in hive data

  Future<void> clearAll() async {
    await _box?.clear();
    _updateState();
    // _updateState();
  }

  Future<void> deleteTask(Todo todo) async {
    await _box?.delete(todo.id);
    _updateState();
  }

  Future<void> toggle(Todo todo, bool value) async {
    if (value) {
      todo.isCompleted = value;
      await _box?.put(todo.id, todo);
      _updateState();
    } else {
      todo.isCompleted = value;
      await _box?.put(todo.id, todo);
      _updateState();
    }
  }
}
