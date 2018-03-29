import 'harness/app.dart';

Future main() async {
  TestApplication app = new TestApplication();

  setUpAll(() async {
    await app.start();
  });

  tearDownAll(() async {
    await app.stop();
  });

  group("Todos", () {
    test("Can get all todos", () async {
      TestRequest request = app.client.request("/todos");

      TestResponse response = await request.get();
      expect(response, hasResponse(200, {
        "todos": [
          "Make a sandwich."
        ]
      }));
    });

    test("Can get a single todo by its index", () async {
      TestRequest request = app.client.request("/todos/0");

      TestResponse response = await request.get();
      expect(response, hasResponse(200, {
        "todo": "Make a sandwich."
      }));
    });

    test("Returns 404 when todo does not exist", () async {
      TestRequest request = app.client.request("/todos/9999");

      TestResponse response = await request.get();
      expect(response, hasStatus(404));
    });
  });
}
