import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      navigationBar: CupertinoNavigationBar(
        middle: const Text("All Todos"),
        trailing: Material(
          child: IconButton(
            onPressed: () {
              debugPrint("Tiklandi ");
              showCupertinoModalPopup(
                context: context,
                builder: (_) => GestureDetector(
                  child: showDialogum(context),
                ),
              );
            },
            icon: const Icon(CupertinoIcons.add),
          ),
        ),
      ),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            child: ListView(
              children: [
                // Cupertino Search Text Field
                CupertinoSearchTextField(
                  controller: _searchTextController,
                  onChanged: (value) => _runFilter(value),
                  onTap: () {
                    isWriting = true;
                  },
                ),
                for (ToDo todo
                    in isWriting ? _foundToDo.reversed : todosList.reversed)
                  ToDoItem(
                    todo: todo,
                    onToDoChanged: _handleToDoChange,
                    onDeleteItem: _deleteToDoItem,
                  ),
              ],
            ),
          )),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  void _addTodoItem(String todo) {
    setState(() {
      todosList.add(
        ToDo(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            todoText: todo),
      );
    });
    _todoController.clear();
  }

  Widget showDialogum(BuildContext context) {
    return CupertinoActionSheet(
      title: const Text(
        "ADD NEW TODO",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      cancelButton: CupertinoButton(
        color: Colors.red,
        child: const Text("Cancel"),
        onPressed: () {
          Navigator.of(context).pop(context);
        },
      ),
      actions: [
        Column(
          children: [
            Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.0),
              ]),
              margin: const EdgeInsets.all(10),
              child: CupertinoTextField(
                padding: const EdgeInsets.all(10),
                placeholder: "Type something",
                placeholderStyle: const TextStyle(color: Colors.black45),
                style: const TextStyle(color: Colors.blue),
                controller: _todoController,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: const EdgeInsets.all(10),
              child: CupertinoButton(
                pressedOpacity: 0.5,
                borderRadius: BorderRadius.circular(10),
                child: const Text(
                  "Save it!",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onPressed: () {
                  _todoController.text.isEmpty
                      ? null
                      : _addTodoItem(_todoController.text);
                },
              ),
            )
          ],
        )
      ],
    );
  }
}
