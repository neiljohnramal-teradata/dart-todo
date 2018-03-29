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
  });
}