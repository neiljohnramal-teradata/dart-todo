import '../dart_todo.dart';

class Todo extends ManagedObject<_Todo> implements _Todo {
  Map toJson() => {
    "id": id,
    "description": description,
  };
}

class _Todo {
  @managedPrimaryKey
  int id;

  String description;
}
