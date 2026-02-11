import 'dart:typed_data';

class CryptoAttributes {
  final Uint8List data;
  final Uint8List iv;
  final Uint8List derivedKey;
  final Uint8List aad;

  CryptoAttributes({
    required this.data,
    required this.iv,
    required this.derivedKey,
    required this.aad,
  });
}
