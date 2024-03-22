class Task {
  int ID;
  String name;
  bool completed;

  Task({required this.ID, required this.name, this.completed = false});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      ID: json["ID"] ?? 0,
      name: json["name"] ?? "",
      completed: json["completed"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {

  "ID": ID,
  "name": name,
  "completed": completed,
};

}