import 'package:flutter_test/flutter_test.dart';
import 'package:infusion_crypto_engine/enum/infusion_crypto_type.dart';

void main() {
  group('InfusionCryptoType', () {
    test('fromId returns correct type', () {
      expect(InfusionCryptoType.fromId(0x1c6b3f), InfusionCryptoType.chaCha20);
      expect(InfusionCryptoType.fromId(0x56050b), InfusionCryptoType.aesGcm128);
      expect(InfusionCryptoType.fromId(0x8b0f6b), InfusionCryptoType.aesGcm192);
      expect(InfusionCryptoType.fromId(0xfa80b5), InfusionCryptoType.aesGcm256);
    });

    test('fromId returns default type for unknown id', () {
      expect(InfusionCryptoType.fromId(999), InfusionCryptoType.chaCha20);
    });

    test('label returns correct name', () {
      expect(InfusionCryptoType.chaCha20.label(), 'ChaCha20');
      expect(InfusionCryptoType.aesGcm128.label(), 'AES 128');
      expect(InfusionCryptoType.aesGcm192.label(), 'AES 192');
      expect(InfusionCryptoType.aesGcm256.label(), 'AES 256');
    });
  });
}
