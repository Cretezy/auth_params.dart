import 'package:auth_params/auth_params.dart';
import 'package:collection/collection.dart';
import 'package:test/test.dart';

void main() {
  test('encodes', () {
    final correct = 'foo="bar",foofoo="barbar"';
    final encoded = authParams.encode({
      "foo": "bar",
      "foofoo": "barbar",
    });

    expect(encoded, correct);
  });

  test('decodes', () {
    final correct = {
      "foo": "bar",
      "foofoo": "barbar",
    };
    final Map<String, String> encoded =
        authParams.decode('foo="bar",foofoo="barbar"');

    final isEqual = MapEquality().equals(encoded, correct);

    expect(isEqual, isTrue);
  });
}
