import 'dart:math';

import 'package:cryptography_flutter_plus/cryptography_flutter_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infusion_crypto_engine/enum/infusion_crypto_type.dart';
import 'package:infusion_crypto_engine/infusion_crypto_channel.dart';
import 'package:infusion_crypto_engine/infusion_crypto_engine.dart';
import 'package:infusion_crypto_engine/models/crypto_attributes.dart';
import 'package:infusion_crypto_engine/models/encryption_parts.dart';

void main() {
  group('InfusionCryptoEngine Tests', () {
    Uint8List generateRandomData(int length) {
      Random random = Random();
      return Uint8List.fromList(
          List.generate(length, (_) => random.nextInt(256)));
    }

    Future<bool> helperTestEncryptionAndDecryption(
      InfusionCryptoType type,
      Uint8List data,
    ) async {
      final channel = InfusionCryptoEngine(type);
      final Uint8List data = generateRandomData(32);
      final CryptoAttributes attributes = CryptoAttributes(
        data: data,
        iv: channel.generateIV(),
        derivedKey: generateRandomData(channel.cryptoEngine.secretKeyLength),
        aad: generateRandomData(8),
      );

      final Uint8List encryptedData = await channel.encrypt(attributes);

      final CryptoAttributes attributesEncrypt = CryptoAttributes(
        data: encryptedData,
        iv: attributes.iv,
        derivedKey: attributes.derivedKey,
        aad: attributes.aad,
      );

      final Uint8List decryptedData = await channel.decrypt(attributesEncrypt);

      return listEquals(decryptedData, data);
    }

    test('InfusionCryptoEngine - ChaCha20', () {
      final channel = InfusionCryptoChannel();
      expect(channel.cryptoEngine, isA<FlutterChacha20>());
      expect(channel.getCryptoEngineKeyLength(), 32);
    });

    test('InfusionCryptoEngine - AES-GCM-128', () {
      final channel = InfusionCryptoChannel();
      channel.setCryptoEngine(InfusionCryptoType.aesGcm128);
      expect(channel.cryptoEngine, isA<FlutterAesGcm>());
      expect(channel.getCryptoEngineKeyLength(), 16);
    });

    test('InfusionCryptoEngine - AES-GCM-192', () {
      final channel = InfusionCryptoChannel();
      channel.setCryptoEngine(InfusionCryptoType.aesGcm192);
      expect(channel.cryptoEngine, isA<FlutterAesGcm>());
      expect(channel.getCryptoEngineKeyLength(), 24);
    });

    test('InfusionCryptoEngine - AES-GCM-256', () {
      final channel = InfusionCryptoChannel();
      channel.setCryptoEngine(InfusionCryptoType.aesGcm256);
      expect(channel.cryptoEngine, isA<FlutterAesGcm>());
      expect(channel.getCryptoEngineKeyLength(), 32);
    });

    test('InfusionCryptoEngine - Encryption and Decryption (ChaCha20)',
        () async {
      expect(
        await helperTestEncryptionAndDecryption(
          InfusionCryptoType.chaCha20,
          Uint8List.fromList(List.generate(20, (index) => index)),
        ),
        true,
      );
    });

    test('InfusionCryptoEngine - Encryption and Decryption (AES-GCM-128)',
        () async {
      expect(
        await helperTestEncryptionAndDecryption(
          InfusionCryptoType.aesGcm128,
          Uint8List.fromList(List.generate(24, (index) => index)),
        ),
        true,
      );
    });

    test('InfusionCryptoEngine - Encryption and Decryption (AES-GCM-192)',
        () async {
      expect(
        await helperTestEncryptionAndDecryption(
          InfusionCryptoType.aesGcm192,
          Uint8List.fromList(List.generate(23, (index) => index)),
        ),
        true,
      );
    });

    test('InfusionCryptoEngine - Encryption and Decryption (AES-GCM-256)',
        () async {
      expect(
        await helperTestEncryptionAndDecryption(
          InfusionCryptoType.aesGcm256,
          Uint8List.fromList(List.generate(17, (index) => index)),
        ),
        true,
      );
    });

    test('InfusionCryptoEngine - splitEncryptionParts', () async {
      final channel = InfusionCryptoEngine(InfusionCryptoType.aesGcm256);
      final Uint8List data = generateRandomData(32);
      final CryptoAttributes attributes = CryptoAttributes(
        data: data,
        iv: channel.generateIV(),
        derivedKey: generateRandomData(channel.cryptoEngine.secretKeyLength),
        aad: generateRandomData(8),
      );

      final Uint8List encryptedData = await channel.encrypt(attributes);
      final EncryptionParts parts = channel.splitEncryptionParts(encryptedData);

      expect(parts.nonce, attributes.iv);
      expect(parts.cipherText, isNotEmpty);
      expect(parts.mac, isNotEmpty);
    });
  });
}
