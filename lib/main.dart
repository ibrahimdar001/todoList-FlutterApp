import 'package:flutter/material.dart';
import 'package:todo_app/Model/task_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'TODO App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late TextEditingController textContr;
  List<TodoList> task = [];
  int id = 0;

  @override
  void initState() {
    textContr = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textContr.dispose();
    super.dispose();
  }

  void addTask(){
    setState(() {
      final todotask = textContr.text;
      textContr.clear();
      task.add(TodoList(id:id,task:todotask));
      id++;
    });
  }

  void deleteTask(int id){
    setState(() {
      task.removeWhere((element) => element.id == id);
    });
  }

  Widget taskDisplay(TodoList todostring){
      return ListTile(
        title: Text(todostring.task),
        trailing: IconButton(
          onPressed: () => deleteTask(todostring.id), icon: const Icon(Icons.delete),
          color: Colors.red
        )
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child:Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
          children: <Widget>[
             Row(
               children: [
                 Expanded(
                   child: TextFormField(
                     controller: textContr,
                     decoration: const InputDecoration(
                       border:  OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
                       fillColor: Colors.blueAccent,
                       hintText: 'Add Task...'
                     ),
                   ),
                 ),
                 IconButton(
                   onPressed: addTask, 
                   icon: const Icon(Icons.add),
                  ),
               ],
             ),
              Expanded(
                child: ListView.builder(
                  itemCount: task.length,
                  itemBuilder: ((context,i) => taskDisplay(task[i])),
                )
              )
        ],
        ),
        ), 
      ),
    );
  }
}
