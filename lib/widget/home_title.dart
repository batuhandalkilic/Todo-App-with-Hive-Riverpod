import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Const/const.dart';

class Apptitle extends ConsumerWidget {
  const Apptitle({Key? key}) : super(key: key);
  final String title = 'Todo App';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
        child: Text(
      title,
      style: Const.titleTextStyle,
    ));
  }
}
