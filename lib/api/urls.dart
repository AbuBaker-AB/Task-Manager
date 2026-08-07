class TMUrls{

  static String baseURL = 'https://task-manager-api.ostad.live/api/v1';

  static String SignupURL = '$baseURL/Registration';

  static String LoginURL = '$baseURL/Login';

  static String createTask = '$baseURL/createTask';

  static String taskCount = '$baseURL/taskStatusCount';

  static String AllTask(String status) => '$baseURL/listTaskByStatus/$status';

  static String deleteTask(String taskId) => '$baseURL/deleteTask/$taskId';

  static String updateTask(String taskId,String status) => '$baseURL/updateTaskStatus/$taskId/$status';

}