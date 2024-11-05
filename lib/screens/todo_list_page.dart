import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  String selectedDay = "Senin"; // Hari yang dipilih

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    final todosByDay = todoProvider.getTodosByDay(selectedDay);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To-Do List",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Dropdown untuk memilih hari
          Container(
            alignment: Alignment.centerLeft, // Rata kiri
            padding: EdgeInsets.symmetric(
                horizontal: 16.0), // Tambahkan padding horizontal
            child: DropdownButton<String>(
              value: selectedDay,
              items: <String>[
                'Senin',
                'Selasa',
                'Rabu',
                'Kamis',
                'Jumat',
                'Sabtu',
                'Minggu'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedDay = newValue!;
                });
              },
            ),
          ),
          // Menampilkan pesan jika daftar tugas kosong
          if (todosByDay.isEmpty) // Cek apakah daftar tugas kosong
            Expanded(
              child: Center(
                // Menempatkan gambar dan teks di tengah
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Vertikal di tengah
                  children: [
                    Image.asset(
                      'asset/image/hero.png', // Ganti dengan path gambar yang sesuai
                      width: 180, // Sesuaikan ukuran gambar
                      height: 180,
                    ),
                    SizedBox(height: 8), // Spasi antara gambar dan teks
                    Text(
                      "Hai, list kamu masih kosong nih!",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center, // Rata tengah
                    ),
                  ],
                ),
              ),
            ),
          // Menampilkan daftar tugas sesuai dengan hari yang dipilih
          if (todosByDay.isNotEmpty) // Menampilkan daftar hanya jika ada tugas
            Expanded(
              child: ListView.builder(
                itemCount: todosByDay.length,
                itemBuilder: (context, index) {
                  final todo = todosByDay[index];
                  return ListTile(
                    leading: Checkbox(
                      value: todo.isDone,
                      onChanged: (bool? value) {
                        todoProvider.toggleTodoStatus(todoProvider.todos
                            .indexOf(todo)); // Mengubah status
                      },
                    ),
                    title: Text(
                      todo.task,
                      style: TextStyle(
                        decoration: todo.isDone
                            ? TextDecoration.lineThrough // Coret jika selesai
                            : null,
                        color: todo.isDone ? Colors.grey : Colors.black,
                      ),
                    ),
                    trailing: IconButton(
                      icon:
                          Icon(Icons.delete, color: Colors.red), // Tombol hapus
                      onPressed: () {
                        todoProvider.removeTodoItem(
                            todoProvider.todos.indexOf(todo)); // Hapus tugas
                      },
                    ),
                  );
                },
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    String newTask = "";
    String newDay = "Senin"; // Default hari

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Tambahkan Tugas Baru"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  newTask = value;
                },
                decoration: InputDecoration(hintText: "Masukkan tugas"),
              ),
              Container(
                alignment: Alignment.centerLeft, // Rata kiri
                padding: EdgeInsets.symmetric(
                    horizontal: 16.0), // Tambahkan padding horizontal
                child: DropdownButton<String>(
                  value: newDay,
                  items: <String>[
                    'Senin',
                    'Selasa',
                    'Rabu',
                    'Kamis',
                    'Jumat',
                    'Sabtu',
                    'Minggu'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      newDay = newValue!;
                    });
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Batal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Tambah"),
              onPressed: () {
                if (newTask.isNotEmpty) {
                  Provider.of<TodoProvider>(context, listen: false).addTodoItem(
                      newTask, newDay); // Menambahkan dengan kategori hari
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
