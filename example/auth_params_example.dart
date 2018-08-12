import 'package:auth_params/auth_params.dart';
import 'package:collection/collection.dart';

main() {
  final Map<String, String> data = {"job": "Developer", "name": "Charles"};

  final encoded = authParams.encode(data);

  print(encoded);
  // job="Developer",name="Charles"

  final decoded = authParams.decode(encoded);

  print(decoded);
  // {job: Developer, name: Charles}

  print(MapEquality().equals(data, decoded));
  // true
}
