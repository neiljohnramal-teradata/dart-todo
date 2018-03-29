import '../dart_todo.dart';

class TodoController extends HTTPController {
  List<String> todos = [
    "Make a sandwich.",
  ];

  @httpGet
  Future<Response> getAllTodos() async {
    return new Response.ok({"todos": todos});
  }

  @httpGet
  Future<Response> getTodo(@HTTPPath('index') int index) async {
    if (index < 0 || index >= todos.length) {
      return new Response.notFound();
    }

    return new Response.ok({"todo": todos[index]});
  }
}
