import 'dart:io';
import 'dart:ui';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app_new/constants/colors.dart';
import 'package:to_do_app_new/widgets/todo_item.dart';

import '../model/todo.dart';

class HomeAndroid extends StatefulWidget {
  HomeAndroid({Key? key}) : super(key: key);

  @override
  State<HomeAndroid> createState() => _HomeAndroidState();
}

class _HomeAndroidState extends State<HomeAndroid> {
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
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        child: const Text(
                          "All todos",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (ToDo todo in isWriting
                          ? _foundToDo.reversed
                          : todosList.reversed)
                        ToDoItem(
                          todo: todo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin:
                        const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                    child: TextField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                          hintText: " Add a new todo item",
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.cyanAccent.shade200,
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                    onPressed: () {
                      _todoController.text.isEmpty
                          ? null
                          : _addTodoItem(_todoController.text);
                    },
                    iconSize: 35,
                    icon: const Icon(Icons.navigate_next),
                  ),
                )
              ],
            ),
          )
        ],
      ),
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

  searchBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          isWriting
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isWriting = false;
                      _searchTextController.text = "";
                      _foundToDo.clear();
                    });
                  },
                  icon: Icon(Icons.arrow_back_sharp),
                )
              : SizedBox(),
          Expanded(
            child: TextField(
              controller: _searchTextController,
              autofocus: isWriting ? true : false,
              onChanged: (value) {
                _runFilter(value);
              },
              readOnly: isWriting ? false : true,
              onTap: () {
                setState(() {
                  isWriting = true;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Search me",
              ),
            ),
          ),
          isWriting
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _searchTextController.text = "";
                    });
                  },
                  icon: Icon(Icons.cancel_outlined),
                )
              : SizedBox()
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset('assets/images/ben.jpg')),
          )
        ],
      ),
    );
  }
}
