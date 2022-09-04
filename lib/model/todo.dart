class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: "01", todoText: "Morning Exercise"),
      ToDo(id: "02", todoText: "Gym time", isDone: true),
      ToDo(id: "03", todoText: "Meeting with Sam"),
      ToDo(id: "04", todoText: "Take a walk", isDone: true),
      ToDo(id: "05", todoText: "Help kids homework"),
    ];
  }
}
