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
  });
}
