import 'package:flutter/material.dart';

// ignore_for_file: prefer_const_constructors
void main() {
  runApp(Todo());
}

class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo App",
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  // List of todos
  final List<String> _todoList = <String>[];

  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List of todos')),
      //body: ListView(children: _getItems()),
      body: ListView.separated(

        itemCount: _todoList.length,
        itemBuilder: (_, i) {
          String todo = _todoList[i];
          return ListTile(
            title: Text(todo),
            trailing: SizedBox(
              width: 70,
              child: Row(
                children: [
                  Expanded(
                      child: IconButton(
                        onPressed: () => _displayDialogEdit(context, i),
                        icon: Icon(Icons.edit), color: Colors.blue,)),
                  Expanded(
                      child: IconButton(
                        onPressed: () => _displayDialogDelete(context,todo),
                        icon: Icon(Icons.delete), color: Colors.red,))
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, i) {
          return Divider();
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: 'Add Item',
          child: Icon(Icons.add)),
    );
  }

  void _addTodoItem(String title) {
    // Wrapping it inside a set state will notify
    // the app that the state has changed
    setState(() {
      _todoList.add(title);
    });
    _textFieldController.clear();
  }

  void _editTodoItem(String title, i) {
    setState(() {
      _todoList[i] = title;
    });
    _textFieldController.clear();
  }

  void _removeTodoItem(String title, string) {
    setState(() {
      _todoList.remove(string);
    });
    _textFieldController.clear();
  }

  Future<void> _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add a task to your list'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Enter task here'),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  _addTodoItem(_textFieldController.text);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green
                ),
                child: Text('ADD'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red
                ),
                child: Text('CANCEL'),
              )
            ],
          );
        });
  }

  Future<void> _displayDialogEdit(BuildContext context, i) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Edit your todo'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Edit here'),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    _editTodoItem(_textFieldController.text, i);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green
                  ),
                  child: Text('SAVE')),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red
                ),
                child: Text('CANCEL'),
              )
            ],
          );
        });
  }

  Future<void> _displayDialogDelete(BuildContext context, String string) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete todo?'),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    _removeTodoItem(_textFieldController.text, string);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red
                  ),
                  child: Text('YES')),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green
                ),
                child: Text('CANCEL'),
              )
            ],
          );
        });
  }
}
