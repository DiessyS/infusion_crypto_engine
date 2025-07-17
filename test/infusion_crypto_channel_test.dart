import 'package:cryptography_flutter_plus/cryptography_flutter_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infusion_crypto_engine/enum/infusion_crypto_type.dart';
import 'package:infusion_crypto_engine/infusion_crypto_channel.dart';

void main() {
  group('InfusionCryptoChannel Tests', () {
    test('InfusionCryptoChannel - ChaCha20', () {
      final channel = InfusionCryptoChannel();
      expect(channel.cryptoEngine, isA<FlutterChacha20>());
      expect(channel.getCryptoEngineKeyLength(), 32);
    });

    test('InfusionCryptoChannel - AES-GCM-128', () {
      final channel = InfusionCryptoChannel();
      channel.setCryptoEngine(InfusionCryptoType.aesGcm128);
      expect(channel.cryptoEngine, isA<FlutterAesGcm>());
      expect(channel.getCryptoEngineKeyLength(), 16);
    });

    test('InfusionCryptoChannel - AES-GCM-192', () {
      final channel = InfusionCryptoChannel();
      channel.setCryptoEngine(InfusionCryptoType.aesGcm192);
      expect(channel.cryptoEngine, isA<FlutterAesGcm>());
      expect(channel.getCryptoEngineKeyLength(), 24);
    });

    test('InfusionCryptoChannel - AES-GCM-256', () {
      final channel = InfusionCryptoChannel();
      channel.setCryptoEngine(InfusionCryptoType.aesGcm256);
      expect(channel.cryptoEngine, isA<FlutterAesGcm>());
      expect(channel.getCryptoEngineKeyLength(), 32);
    });
  });

  test('InfusionCryptoChannel - getCryptoType', () {
    final channel = InfusionCryptoChannel();
    expect(channel.getCryptoType(), InfusionCryptoType.chaCha20);
  });

  test('InfusionCryptoChannel - getCryptoType after setting AES-GCM-128', () {
    final channel = InfusionCryptoChannel();
    channel.setCryptoEngine(InfusionCryptoType.aesGcm128);
    expect(channel.getCryptoType(), InfusionCryptoType.aesGcm128);
  });
}
