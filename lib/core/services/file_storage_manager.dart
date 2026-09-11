import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorageManager {
  static final FileStorageManager _instance = FileStorageManager._();

  FileStorageManager._();

  factory FileStorageManager() {
    return _instance;
  }

  late final Directory _appDocumentsDirectory;
  late final File _tasksFile;

  Future<void> init() async {
    _appDocumentsDirectory = await getApplicationDocumentsDirectory();
    _tasksFile = File('${_appDocumentsDirectory.path}/tasks.json');
  }

  Future<void> saveTasks(List<dynamic> tasksList) async {
    final encodedTasksList = jsonEncode(tasksList);
    await _tasksFile.writeAsString(encodedTasksList);
  }

  Future<List<dynamic>> loadTasks() async {
    if (!await _tasksFile.exists()) return [];
    final String tasksJson = await _tasksFile.readAsString();
    return jsonDecode(tasksJson) as List<dynamic>;
  }
}
