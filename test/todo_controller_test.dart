import 'harness/app.dart';
import 'package:dart_todo/model/todo.dart';


Future main() async {
  TestApplication app = new TestApplication();

  setUpAll(() async {
    await app.start();

    List<Todo> todos = [
      new Todo()
        ..description = "Make a sandwich.",
      new Todo()
        ..description = "Eat the sandwhich.",
    ];

    await Future.forEach(todos, (todo) {
      Query query = new Query<Todo>()
        ..values = todo;
      return query.insert();
    });
  });

  tearDownAll(() async {
    await app.stop();
  });

  group("Todos", () {
    test("Can get all todos", () async {
      expectResponse(
        await app.client.request("/todos").get(),
        200,
        body: allOf([
          hasLength(greaterThan(0)),
          everyElement(containsPair("description", endsWith(".")))
        ]));
    });

    test("Can get a single todo by its index", () async {
      expectResponse(
        await app.client.request("/todos/1").get(),
        200,
        body: containsPair("description", endsWith(".")));
    });

    test("Returns 404 when todo does not exist", () async {
      expectResponse(await app.client.request("/todos/99999").get(), 404);
    });

    test("Adds a new todo", () async {
      TestRequest request = app.client.request("/todos")
        ..json = { "description": "A new todo." };
      expectResponse(
        await request.post(), 
        201, 
        body: allOf([
          containsPair("description", "A new todo."),
          containsPair("id", 3),
        ]));
    });

    test("Updates a todo", () async {
      String newTodo = "Make a pizza.";
      TestRequest request = app.client.request("/todos/1")
        ..json = { "description": newTodo };

      expectResponse(
        await request.put(),
        200,
        body: allOf([
          containsPair("description", newTodo),
          containsPair("id", 1),
        ]));
    });

    test("Returns a 404 when a todo does not exist to be updated", () async {
      String newTodo = "Does not exist.";
      TestRequest request = app.client.request("/todos/9999")
        ..json = { "description": newTodo };
      expectResponse(await request.put(), 404);
    });

    test("Deletes a todo", () async {
      expectResponse(
        await app.client.request("/todos/3").delete(),
        200,
        body: containsPair("message", "Todo deleted."),
      );
    });

    test("Returns a 404 when a todo does not exist to be deleted", () async {
      expectResponse(await app.client.request("/todos/9999").delete(), 404);
    });
  });
}
