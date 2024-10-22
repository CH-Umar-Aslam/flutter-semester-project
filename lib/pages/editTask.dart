import 'package:flutter/material.dart';
import 'package:task_app/schema/tasks.dart';

class EditTask extends StatefulWidget {
  final Tasks task;
  final Function(Tasks) onSave;

  EditTask({required this.task, required this.onSave});

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late TextEditingController taskController;
  late TextEditingController descriptionController;
  String taskPriority = "Normal";

  @override
  void initState() {
    super.initState();
    taskController = TextEditingController(text: widget.task.task);
    descriptionController = TextEditingController(text: widget.task.description);
    taskPriority = widget.task.taskPriority;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Task",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue, // Consistent AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: 'Task',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
            SizedBox(height: 16), // Add spacing between elements
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: taskPriority,
              decoration: InputDecoration(
                labelText: 'Priority',
                border: OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(child: Text("Normal"), value: "Normal"),
                DropdownMenuItem(child: Text("High"), value: "High"),
                DropdownMenuItem(child: Text("Low"), value: "Low"),
              ],
              onChanged: (value) {
                setState(() {
                  taskPriority = value.toString();
                });
              },
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                final updatedTask = Tasks(
                  task: taskController.text,
                  description: descriptionController.text,
                  taskPriority: taskPriority,
                );
                widget.onSave(updatedTask);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Consistent button color
                minimumSize: Size(double.infinity, 50), // Full-width button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
              ),
              child: Text(
                "Save Changes",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    taskController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
