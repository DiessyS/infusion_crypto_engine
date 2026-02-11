import 'dart:typed_data';

class CryptoAttributes {
  final Uint8List data;
  final Uint8List derivedKey;
  final Uint8List aad;
  Uint8List? iv;

  CryptoAttributes({
    required this.data,
    required this.derivedKey,
    required this.aad,
    this.iv,
  });
}
