class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static String registration = '$_baseUrl/registration';
  static String login = '$_baseUrl/login';
  static String createTask = '$_baseUrl/createTask';
  static String taskCountByStatus = '$_baseUrl/taskStatusCount';
  static String  newTaskList = '$_baseUrl/listTaskByStatus/New';
  static String  completedTaskList = '$_baseUrl/listTaskByStatus/Completed';
  static String  progressTaskList = '$_baseUrl/listTaskByStatus/Progress';
  static String  cancelledTaskList = '$_baseUrl/listTaskByStatus/Cancelled';
  static String updateProfile = '$_baseUrl/profileUpdate';
  static String  deleteTask(String id) =>'$_baseUrl/deleteTask/$id';
  static String updateTaskStatus(String id, String status) =>'$_baseUrl/updateTaskStatus/$id/$status';


}