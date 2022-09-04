import 'package:cupertino_listview/cupertino_listview.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:to_do_app_new/model/todo.dart';
import 'package:to_do_app_new/widgets/todo_item.dart';

class HomeIOS extends StatefulWidget {
  const HomeIOS({Key? key}) : super(key: key);

  @override
  State<HomeIOS> createState() => _HomeIOSState();
}

class _HomeIOSState extends State<HomeIOS> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();
  final _searchTextController = TextEditingController();
  bool isWriting = false;
  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("All Todos"),
      ),
      child: Center(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text("merhaba"),
                Text("merhaba"),
                Text("merhaba"),
                Text("merhaba"),
              ],
            )),
      ),
    );
  }
}
