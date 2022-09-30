// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  late String id;
  @HiveField(1)
  String task;
  @HiveField(2)
  bool isCompleted;
  Todo(this.task, {this.isCompleted = false}) {
    id = const Uuid().v4();
  }
  // Hive fields go here
}

String tumu = "Tümü";
String tamamlanan = "Tamamlanan";
String tamamlanmayan = "Tamamlanmayan";

@HiveType(typeId: 1)
enum FilterList {
  @HiveField(0)
  tumu,
  @HiveField(1)
  tamamlanan,
  @HiveField(2)
  tamamlanmayan,
}
