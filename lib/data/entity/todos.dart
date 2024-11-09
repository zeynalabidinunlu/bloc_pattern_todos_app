class Todos {
  int id;
  String title;
  String description;
  bool isDone;

  Todos({required this.id, required this.title,required this.description,required this.isDone});

  factory Todos.fromJson(Map<String, dynamic> json) {
    return Todos(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isDone: json['isDone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
    };
  }
}