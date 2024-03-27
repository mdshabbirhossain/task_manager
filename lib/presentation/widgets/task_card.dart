import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_manager/data/models/task_item.dart';
import 'package:task_manager/presentation/widgets/snack_bar_message.dart';

import '../../data/services/networkcaller.dart';
import '../../data/utility/urls.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskItem,
    required this.refreshList,
  });

  final TaskItem taskItem;

  final VoidCallback refreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _updateTaskStatusInProgress = false;
  bool _deleteTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskItem.title ?? '',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              widget.taskItem.description ?? '',
            ),
            Text('Date:${widget.taskItem.createdDate}'),
            Row(
              children: [
                Chip(label: Text(widget.taskItem.status ?? '')),
                Spacer(),
                Visibility(
                  visible: _updateTaskStatusInProgress == false,
                  replacement: CircularProgressIndicator(),
                  child: IconButton(
                      onPressed: () {
                        _showUpdateStatusDialog(widget.taskItem.sId!);
                      },
                      icon: Icon(Icons.edit)),
                ),
                Visibility(
                  visible: _deleteTaskInProgress == false,
                  replacement: CircularProgressIndicator(),
                  child: IconButton(
                      onPressed: () {
                        _deleteTaskById(widget.taskItem.sId!);
                      },
                      icon: Icon(Icons.delete)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool _isCurrentStatus(String status) {
    return widget.taskItem.status! == status;
  }

  void _showUpdateStatusDialog(String id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Select Status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('New'),
                  trailing: _isCurrentStatus('New') ? Icon(Icons.check) : null,
                  onTap: () {
                    if (_isCurrentStatus('New')) {
                      return;
                    }
                    _updateTaskById(id, 'New');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Completed'),
                  trailing:
                      _isCurrentStatus('Completed') ? Icon(Icons.check) : null,
                  onTap: () {
                    if (_isCurrentStatus('Completed')) {
                      return;
                    }
                    _updateTaskById(id, 'Completed');
                    Navigator.pop(context);
                  }
                ),
                ListTile(
                  title: Text('Progress'),
                  trailing:
                      _isCurrentStatus('Progress') ? Icon(Icons.check) : null,
                  onTap: () {
                    if (_isCurrentStatus('Progress')) {
                      return;
                    }
                    _updateTaskById(id, 'Progress');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Cancelled'),
                  trailing:
                      _isCurrentStatus('Progress') ? Icon(Icons.check) : null,
                  onTap: () {
                    if (_isCurrentStatus('Cancelled')) {
                      return;
                    }
                    _updateTaskById(id, 'Cancelled');
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> _updateTaskById(String id, String status) async {
    _updateTaskStatusInProgress = true;
    setState(() {});
    final response =
        await NetworkCaller.getRequest(Urls.updateTaskStatus(id, status));
    _updateTaskStatusInProgress = false;
    if (response.isSuccess) {
      _updateTaskStatusInProgress = false;
      widget.refreshList();
      //_getDataFromApis();
    } else {
      _updateTaskStatusInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? ' Update task status has been failed');
      }
    }
  }

  Future<void> _deleteTaskById(String id) async {
    _deleteTaskInProgress = true;
    setState(() {});

    final response = await NetworkCaller.getRequest(Urls.deleteTask(id));
    _deleteTaskInProgress = false;
    if (response.isSuccess) {
      widget.refreshList();
      // _getDataFromApis();
    } else {
      _deleteTaskInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'delete task  has been failed');
      }
    }
  }
}
