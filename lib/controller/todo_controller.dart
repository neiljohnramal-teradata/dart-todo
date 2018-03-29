import '../dart_todo.dart';

class TodoController extends HTTPController {
  List<String> todos = [
    "Make a sandwich.",
  ];

  @httpGet
  Future<Response> getAllTodos() async {
    return new Response.ok({"todos": todos});
  }
}
