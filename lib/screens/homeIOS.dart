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
      navigationBar: const CupertinoNavigationBar(
        middle: Text("All Todos"),
      ),
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Expanded(
            child: Material(
              child: ListView(
                children: [
                  CupertinoSearchTextField(
                    controller: _searchTextController,
                  ),
                  for (ToDo todo
                      in isWriting ? _foundToDo.reversed : todosList.reversed)
                    ToDoItem(
                      todo: todo,
                      onToDoChanged: null,
                      onDeleteItem: null,
                    ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                                bottom: 20, right: 20, left: 20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 10.0,
                                    spreadRadius: 0.0),
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CupertinoTextField(
                              controller: _todoController,
                            ),
                          ),
                        ),
                        Container(
                            margin:
                                const EdgeInsets.only(bottom: 20, right: 20),
                            decoration: BoxDecoration(
                                color: Colors.cyanAccent.shade200,
                                border: Border.all(width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            child: CupertinoButton(
                              child: Icon(CupertinoIcons.add),
                              onPressed: () {},
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
