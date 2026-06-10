class TaskModel {
  final int id;
  final String name;
  final String description;
  final bool isHighPriority;
  bool isCompleted;

  TaskModel({
    required this.id,
    required this.name,
    required this.description,
    required this.isHighPriority,
    this.isCompleted = false,
  });
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isHighPriority: json['isHighPriority'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'isHighPriority': isHighPriority,
      'isCompleted': isCompleted,
    };
  }
}
