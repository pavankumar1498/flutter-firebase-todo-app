class Task {
  final String id;
  final String title;
  final bool completed;

  Task({required this.id, required this.title, required this.completed});

  factory Task.fromJson(String id, Map<String, dynamic> json) {
    return Task(
      id: id,
      title: json["title"] ?? "",
      completed: json["completed"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {"title": title, "completed": completed};
  }
}
