import 'package:task_manager/data/models/task_by_status_data.dart';

class CountByStatusWrapper {
  String? status;
  List<TaskByStatusData>? ListOfTaskByStatusData;

  CountByStatusWrapper({this.status, this.ListOfTaskByStatusData});

  CountByStatusWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      ListOfTaskByStatusData = <TaskByStatusData>[];
      json['data'].forEach((v) {
        ListOfTaskByStatusData!.add( TaskByStatusData.fromJson(v));
      });
    }
  }


}
