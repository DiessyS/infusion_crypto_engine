import 'dart:typed_data';

class InfusionCryptoAttributes {
  final Uint8List salt;
  final Uint8List iv;

  InfusionCryptoAttributes({
    required this.salt,
    required this.iv,
  });
}
