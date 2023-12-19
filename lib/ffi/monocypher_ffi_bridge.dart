import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';

typedef Xed25519SignC = Void Function(
  Pointer<Uint8> signature,
  Pointer<Uint8> secretKey,
  Pointer<Uint8> random,
  Pointer<Uint8> message,
  Size messageSize,
);
typedef Xed25519SignDart = void Function(
  Pointer<Uint8> signature,
  Pointer<Uint8> secretKey,
  Pointer<Uint8> random,
  Pointer<Uint8> message,
  int messageSize,
);

class MonocypherFFIBridge {
  late Xed25519SignDart _xed25519sign;
  static final MonocypherFFIBridge shared =
      MonocypherFFIBridge._privateConstructor();

  MonocypherFFIBridge._privateConstructor();

  void initialize() {
    try {
      final dylib = Platform.isAndroid
          ? DynamicLibrary.open('libmonocypher.so')
          : DynamicLibrary.process();

      debugPrint('dylib: ${dylib.toString()}');

      _xed25519sign = dylib.lookupFunction<Xed25519SignC, Xed25519SignDart>(
        'xed25519_sign',
      );

      debugPrint('_xed25519sign: $_xed25519sign');
    } catch (e) {
      debugPrint('FFIBridgeManager initialize error: ${e.toString()}');
    }
  }

  Uint8List xed25519Sign(
    List<int> signature,
    List<int> secret,
    List<int> random,
    List<int> message,
  ) {
    debugPrint('xed25519Sign start');
    List<int> returnValue = [];

    try {
      final secretPointer = calloc<Uint8>(secret.length);
      secretPointer.asTypedList(secret.length).setAll(0, secret);

      final messagePointer = calloc<Uint8>(message.length);
      messagePointer.asTypedList(message.length).setAll(0, message);

      final randomPointer = calloc<Uint8>(random.length);
      randomPointer.asTypedList(random.length).setAll(0, random);

      final signaturePointer = calloc<Uint8>(signature.length);
      signaturePointer.asTypedList(signature.length).setAll(0, signature);

      _xed25519sign(signaturePointer, secretPointer, randomPointer,
          messagePointer, message.length);

      debugPrint('xed25519Sign done');

      return signaturePointer.asTypedList(signature.length);
    } catch (e) {
      debugPrint('xed25519Sign error: ${e.toString()}');
      returnValue = e.toString().codeUnits;
      return Uint8List.fromList(returnValue);
    }
  }
}
