
import 'dart:convert';
import 'package:http/http.dart' as http;


// // const String baseurl = "https://backend-code-4-nnid.onrender.com";

// const String baseurl = "https://sangam-c2fm.onrender.com";

// class ApiServices {
//   Future<List<Tasks>> getalltasks(String projectId) async {
//     final url = "$baseurl/api/project/$projectId/tasks";
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final List<dynamic> data = jsonDecode(response.body);
//       return data.map((json) => Tasks.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to fetch alltasks');
//     }
//   }

//   // Future<List<Project>> getallprojects() async {
//   //   const url = "$baseurl/api/getallprojects";
//   //   final response = await http.get(Uri.parse(url));

//   //   if (response.statusCode == 200) {
//   //     final List<dynamic> data = jsonDecode(response.body);
//   //     return data.map((json) => Project.fromJson(json)).toList();
//   //   } else {
//   //     throw Exception('Failed to fetch allprojects');
//   //   }
//   // }
//   Future<List<ProjectModel>> getprojectall() async {
//     const url = "$baseurl/api/getallprojects";
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final List<dynamic> data = jsonDecode(response.body);
//       return data.map((json) => ProjectModel.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to fetch allprojects');
//     }
//   }

//   Future<List<Departments>> getAllDepartments() async {
//     const url = "$baseurl/api/getalldep";
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final List<dynamic> data = jsonDecode(response.body);
//       return data.map((json) => Departments.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to fetch alldepartments');
//     }
//   }

//   Future<List<Resource>> getallresources() async {
//     const url = "$baseurl/api/getallresources";
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final List<dynamic> data = jsonDecode(response.body);
//       return data.map((json) => Resource.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to fetch allresources');
//     }
//   }

//   Future<Resource> getresoucebyId(String id) async {
//     final url = "$baseurl/api/resource/$id";

//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final Resource data = jsonDecode(response.body);
//       return data;
//     } else {
//       throw Exception('Failed to fetch resource by id');
//     }
//   }

//   Future<taskbyid> getTaskById(String id) async {
//     final url = "$baseurl/api/project/getTaskById/$id";

//     final response = await http.get(
//       Uri.parse(url),
//     );

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = jsonDecode(response.body);
//       return taskbyid.fromJson(data);
//     } else {
//       throw Exception('Failed to fetch task by ID');
//     }
//   }

//   Future<List<AllTaskbyProjectId>> getallTaskByProjectId(String id) async {
//     final url = "$baseurl/api/project/$id/tasks";

//     final response = await http.get(
//       Uri.parse(url),
//     );

//     if (response.statusCode == 200) {
//       final List<dynamic> data = jsonDecode(response.body);

//       return data.map((json) => AllTaskbyProjectId.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to fetch task by projectID');
//     }
//   }

//   Future<List<Tasks>> getallTasks() async {
//     const url = "$baseurl/api/getalltasks";

//     final response = await http.get(
//       Uri.parse(url),
//     );

//     if (response.statusCode == 200) {
//       final List<dynamic> data = jsonDecode(response.body);

//       return data.map((json) => Tasks.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to fetch alltask');
//     }
//   }

//   Future<Report> getreportbytaskid(String id) async {
//     final url = "$baseurl/api/getreportbytaskid/$id";

//     final response = await http.get(
//       Uri.parse(url),
//     );

//     if (response.statusCode == 200) {
//       final dynamic data = jsonDecode(response.body);
//       return data;
//     } else {
//       throw Exception('Failed to fetch report by task id');
//     }
//   }

//   // Future<List<Taskuser>> getalltaskbyUserId(String userId) async {
//   //   final url = "$baseurl/api/getalltasksbyuserid/$userId";

//   //   final response = await http.get(
//   //     Uri.parse(url),
//   //   );

//   //   if (response.statusCode == 200) {
//   //     final Map<String,dynamic> data = jsonDecode(response.body);
//   //     return data.map
//   //   } else {
//   //     throw Exception('Failed to fetch report by task id');
//   //   }
//   // }
// }
