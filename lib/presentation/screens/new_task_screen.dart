import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_manager/data/models/task_list_wrapper.dart';
import 'package:task_manager/data/services/networkcaller.dart';
import 'package:task_manager/presentation/screens/add_new_task.dart';
import 'package:task_manager/presentation/utils/app_colors.dart';
import 'package:task_manager/presentation/widgets/background_widgets.dart';
import 'package:task_manager/presentation/widgets/snack_bar_message.dart';

import '../../data/models/count_by_status_wrapper.dart';
import '../../data/utility/urls.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/task_card.dart';
import '../widgets/task_counter_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getAllTaskCountByStatusInProgress = false;
  bool _getNewTaskListInProgress = false;
  bool _deleteTaskInProgress = false;
  bool _updateTaskStatusInProgress = false;
  CountByStatusWrapper _countByStatusWrapper = CountByStatusWrapper();
  TaskListWrapper _newTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _getDataFromApis();
  }

  void _getDataFromApis() {
    _getAllTaskCountByStatus();
    _getAllNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar,
      body: BackgroundWidget(
          child: Column(
        children: [
          Visibility(
              visible: _getAllTaskCountByStatusInProgress == false,
              replacement: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LinearProgressIndicator(),
              ),
              child: TaskCounterSection),
          Expanded(
              child: Visibility(
            visible: _getNewTaskListInProgress == false && _deleteTaskInProgress == false &&
                _updateTaskStatusInProgress == false,
            replacement: Center(child: CircularProgressIndicator()),
            child: RefreshIndicator(
              onRefresh: () async {
                _getDataFromApis();
              },
              child: Visibility(
                visible: _newTaskListWrapper.taskList?.isNotEmpty ?? false,
                replacement: const Center(child: Text('Empty')),
                child: ListView.builder(
                  //reverse: true,
                    itemCount: _newTaskListWrapper.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        refreshList: (){
                          _getDataFromApis();
                        },
                        taskItem: _newTaskListWrapper.taskList![index],

                      );
                    }),
              ),
            ),
          ))
        ],
      )),
      floatingActionButton: FloatingActionButton(
        // TODO make it autorefresh
        onPressed: () async{
          final result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNewTaskScreen()));
          if(result!=null && result==true){
            _getDataFromApis();
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),

        backgroundColor: AppColor.themeColor,
      ),
    );
  }

  Widget get TaskCounterSection {
    return SizedBox(
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _countByStatusWrapper.ListOfTaskByStatusData?.length ?? 0,
          itemBuilder: (context, index) {
            return TaskCounterCard(
              title: _countByStatusWrapper.ListOfTaskByStatusData![index].sId ??
                  '',
              amount:
                  _countByStatusWrapper.ListOfTaskByStatusData![index].sum ?? 0,
            );
          },
          separatorBuilder: (_, __) {
            return SizedBox(
              width: 8,
            );
          },
        ),
      ),
    );
  }


  Future<void> _getAllTaskCountByStatus() async {
    _getAllTaskCountByStatusInProgress = true;
    setState(() {});

    final response = await NetworkCaller.getRequest(Urls.taskCountByStatus);

    if (response.isSuccess) {
      _countByStatusWrapper =
          CountByStatusWrapper.fromJson(response.responseBody);
      _getAllTaskCountByStatusInProgress = false;
      setState(() {});
    } else {
      _getAllTaskCountByStatusInProgress = false;
      setState(() {});

      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'Get Task count by status failed', true);
      }
    }
  }

  Future<void> _getAllNewTaskList() async {
    _getNewTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.newTaskList);
    if (response.isSuccess) {
      _newTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
      _getNewTaskListInProgress = false;
      setState(() {});
    } else {
      _getNewTaskListInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'Get new task list has been failed');
      }
    }
  }

  Future<void> _deleteTaskById(String id) async {
    _deleteTaskInProgress = true;
    setState(() {});

    final response = await NetworkCaller.getRequest(Urls.deleteTask(id));
    _deleteTaskInProgress = false;
    if (response.isSuccess) {
      _getDataFromApis();
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
