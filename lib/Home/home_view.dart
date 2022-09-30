import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kendi_todo_ui_hive_riverpod/Home/home.view_model.dart';

import '../model/todo.dart';
import '../widget/home_ListTile.dart';
import '../widget/home_filter_bar.dart';
import '../widget/home_title.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    fetcCacheData();
  }

  Future<void> fetcCacheData() async {
    await ref.read(hiveProvider.notifier).init();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hive.isBoxOpen("myBox")
        ? SafeArea(
            child: Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {
                      setState(() {});
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    const Apptitle(),
                    TextField(
                      controller: _textEditingController,
                      onSubmitted: (value) async {
                        Todo newTodo = Todo(value);
                        await ref.read(hiveProvider.notifier).putItem(newTodo);
                        _textEditingController.text = "";
                        setState(() {});
                      },
                      decoration: const InputDecoration(labelText: 'Ne Yapacaksın'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Filter_bar(),
                    // ignore: prefer_const_constructors
                    Home_ListTile()
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton.small(
                  child: Icon(Icons.delete),
                  onPressed: (() async {
                    await ref.read(hiveProvider.notifier).clearAll();
                    setState(() {});
                  })),
            ),
          )
        : CircularProgress();
  }
}

class CircularProgress extends StatelessWidget {
  const CircularProgress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
