library auth_params;

import 'dart:convert';

class AuthParamsEncoder extends Converter<Map<String, String>, String> {
  @override
  String convert(Map<String, String> input) {
    final params = List<String>();
    input.forEach((key, value) {
      params.add('${key}="${value}"');
    });
    return params.join(",");
  }
}

enum _DecoderState { name, quote, value, comma }

class AuthParamsDecoder extends Converter<String, Map<String, String>> {
  @override
  Map<String, String> convert(String input) {
    var state = _DecoderState.name;
    var tempName = "";
    var tempValue = "";

    var output = Map<String, String>();

    input.split("").forEach((character) {
      switch (state) {
        case _DecoderState.name:
          final code = character.codeUnitAt(0);
          // restricted name of A-Z / a-z
          if ((code >= 0x41 && code <= 0x5a) || // A-Z
                  (code >= 0x61 && code <= 0x7a) // a-z
              ) {
            tempName += character;
          } else if (character == "=") {
            if (tempName.length == 0) throw "Bad auth-param format: empty name";
            state = _DecoderState.quote;
          } else {
            throw "Bad auth-param format: invalid name";
          }
          break;
        case _DecoderState.quote:
          if (character == '"') {
            tempValue = "";
            state = _DecoderState.value;
          } else {
            throw "Bad auth-param format: missing quote";
          }
          break;

        case _DecoderState.value:
          if (character == '"') {
            output[tempName] = tempValue;
            state = _DecoderState.comma;
          } else {
            tempValue += character;
          }
          break;

        case _DecoderState.comma:
          if (character == ",") {
            tempName = "";
            state = _DecoderState.name;
          } else {
            throw "Bad auth-param format: missing comma";
          }
          break;
      }
    });
    return output;
  }
}

class AuthParams extends Codec<Map<String, String>, String> {
  @override
  AuthParamsDecoder get decoder => AuthParamsDecoder();

  @override
  AuthParamsEncoder get encoder => AuthParamsEncoder();
}

final authParams = new AuthParams();
