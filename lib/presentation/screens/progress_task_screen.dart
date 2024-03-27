import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_manager/presentation/utils/app_colors.dart';
import 'package:task_manager/presentation/widgets/background_widgets.dart';

import '../../data/models/task_list_wrapper.dart';
import '../../data/services/networkcaller.dart';
import '../../data/utility/urls.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';
import '../widgets/task_counter_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getAllProgressTaskListInProgress = false;
  TaskListWrapper _progressTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _getAllProgressTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar,
      body: BackgroundWidget(
          child: Visibility(
        visible: _getAllProgressTaskListInProgress == false,
        replacement: const Center(
        child: CircularProgressIndicator(),
    ),
    // TODO: Make it workable
    child: RefreshIndicator(
    onRefresh: () async {
    _getAllProgressTaskList();
    },
    child: Visibility(
    visible: _progressTaskListWrapper.taskList?.isNotEmpty ?? false,
    replacement: const Center(child: Text('Empty')),

    child: ListView.builder(
    itemCount: _progressTaskListWrapper.taskList?.length ?? 0,
    itemBuilder: (context, index) {
    return TaskCard(
    taskItem: _progressTaskListWrapper.taskList![index],
    refreshList: () {
    _getAllProgressTaskList();
    },
    );
    },
    ),
    ),
    ),
    ),
      ),

    );
  }

  Future<void> _getAllProgressTaskList() async {
    _getAllProgressTaskListInProgress  = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.progressTaskList);
    if (response.isSuccess) {
      _progressTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
      _getAllProgressTaskListInProgress  = false;
      setState(() {});
    } else {
      _getAllProgressTaskListInProgress  = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
            context,
            response.errorMessage ??
                'Get progress task list has been failed');
      }
    }
  }

}





