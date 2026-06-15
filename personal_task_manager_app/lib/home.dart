import 'package:flutter/material.dart';
import 'package:personal_task_manager_app/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Required for jsonEncode and jsonDecode

class Home extends StatefulWidget {
  final String Username;
  const Home({super.key, required this.Username});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> tasks = [];
  TextEditingController taskController = TextEditingController();

  void addTask() {
    if (taskController.text.isEmpty) return;

    setState(() {
      tasks.add({
        "title": taskController.text,
        "done": false,
      });
    });
    
    taskController.clear(); 
    saveTasks();
  }

  Future<void> saveTasks() async {
    final pref = await SharedPreferences.getInstance();
   
    List<String> taskStringList = tasks.map((task) => jsonEncode(task)).toList();
    await pref.setStringList("tasks", taskStringList);
  }
  
  Future<void> loadTasks() async {
    final pref = await SharedPreferences.getInstance();
    List<String>? savedTasks = pref.getStringList("tasks");

    if (savedTasks != null) {
      setState(() {
        tasks = savedTasks.map((task) => jsonDecode(task) as Map<String, dynamic>).toList();
      });
    }
  }

  void deleteTask(int index) {
  setState(() {
    tasks.removeAt(index);
  });
  saveTasks(); 
}
  
  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Center(
              child: Text(
                "To Do",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.blue,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      color: Colors.blueAccent,
                      offset: Offset(5, 5),
                    ),
                    Shadow(
                      color: Colors.white,
                      offset: Offset(2, 2),
                    )
                  ],
                ),
              ),
            ),
        
            const SizedBox(height: 30),
            const Divider(
              color: Colors.blue,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
        
            Text(
              "Hello, ${widget.Username}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Text("Manage your daily tasks"),
        
            const Divider(
              color: Colors.blue,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
        
            const SizedBox(height: 30),
        
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Add Task"),
                      content: TextField(
                        controller: taskController,
                        decoration: InputDecoration(
                          hintText: "Enter your task",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            addTask();
                            Navigator.pop(context);
                          },
                          child: const Text("Add"),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueAccent,
                fixedSize: const Size(400, 50),
              ),
              child: const Text("Add Task"),
            ),
        
            const SizedBox(height: 30),
            const Text("Today's Tasks"),
        
            const Divider(
              color: Colors.blue,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
        
            Stack(
              children: [
                Container(
                  width: 400,
                  height: 400,
                   decoration: BoxDecoration(
                    // color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12)
                  ),
                  // color: Colors.blue[300],
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          
                          decoration: BoxDecoration(
                            color: Colors.blue[200],
                            borderRadius: BorderRadius.circular(16)
                          ),
                          child: ListTile(
                            leading: Checkbox(
                              value: tasks[index]["done"],
                              onChanged: (val) {
                                setState(() {
                                  tasks[index]["done"] = val;
                                });
                                saveTasks(); 
                              },
                            ),
                            title: Text(
                              tasks[index]["title"],
                              style: TextStyle(
                                decoration: tasks[index]["done"]? TextDecoration.lineThrough: TextDecoration.none,
                                color: tasks[index]["done"] ? Colors.grey : Colors.black,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () {
                                deleteTask(index);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                 
                ),

                
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              
              onPressed: () {
                   Navigator.pop(context, MaterialPageRoute(builder: (context)=>Login()));
                }, child: Text("Logout"),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(400, 30),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent
                )),
  
          ],
        ),
      ),
    );
  }
}