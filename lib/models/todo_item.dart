class Todo {
  String task;
  bool isDone; // Status selesai
  String day; // Kategori hari

  Todo({
    required this.task,
    this.isDone = false,
    required this.day,
  });
}
