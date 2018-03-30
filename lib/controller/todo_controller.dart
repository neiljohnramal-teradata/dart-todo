import '../dart_todo.dart';
import '../model/todo.dart';

class TodoController extends HTTPController {

  @httpGet
  Future<Response> getAllTodos() async {
    Query todosQuery = new Query<Todo>();
    List<Todo> todos = await todosQuery.fetch();

    return new Response.ok(todos);
  }

  @httpGet
  Future<Response> getTodo(@HTTPPath('index') int index) async {
    Query todoQuery = new Query<Todo>()
      ..where.id = whereEqualTo(index);

    Todo todo = await todoQuery.fetchOne();

    if (todo == null) {
      return new Response.notFound();
    }

    return new Response.ok(todo);
  }

  @httpPost
  Future<Response> createTodo(@HTTPBody() Todo todo) async {
    Query query = new Query<Todo>()
      ..values = todo;

    Todo newTodo = await query.insert();

    return new Response.created("/todos", body: newTodo);
  }
}
