import 'package:flutter/material.dart';
import 'package:task_app/schema/tasks.dart';
import 'package:task_app/pages/editTask.dart';

class DisplayTasks extends StatefulWidget {
  final List<Tasks> taskList;

  DisplayTasks(this.taskList);

  @override
  _DisplayTasksState createState() => _DisplayTasksState();
}

class _DisplayTasksState extends State<DisplayTasks> {
  Color getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'normal':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void deleteTask(int index) {
    setState(() {
      widget.taskList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Task List",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.grey[200], // Light grey background for consistency
        child: widget.taskList.isEmpty
            ? Center(
                child: Text(
                  'No tasks available!',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: widget.taskList.length,
                itemBuilder: (context, index) {
                  Tasks task = widget.taskList[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container( // Wrap ListTile with Container
                      constraints: BoxConstraints(minHeight: 80), // Set a minimum height
                      child: ListTile(
                        leading: Icon(
                          Icons.task_alt,
                          color: getPriorityColor(task.taskPriority),
                          size: 40,
                        ),
                        title: Text(
                          task.task,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(task.description),
                            SizedBox(height: 4),
                            Text(
                              'Priority: ${task.taskPriority}',
                              style: TextStyle(
                                color: getPriorityColor(task.taskPriority),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min, // Ensure the row takes minimal space
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              color: Colors.blue.shade700,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditTask(
                                      task: task,
                                      onSave: (updatedTask) {
                                        setState(() {
                                          widget.taskList[index] = updatedTask;
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.red.shade700,
                              onPressed: () {
                                deleteTask(index);
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          // Handle tap on the ListTile (optional)
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
