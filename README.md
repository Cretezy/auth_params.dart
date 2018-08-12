# auth_params

Parser for auth-param syntax from [RFC7235](https://tools.ietf.org/html/rfc7235).

## Usage

```dart
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
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/Cretezy/auth_params.dart/issues
