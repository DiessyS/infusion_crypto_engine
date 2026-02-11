library infusion_crypto_engine;

import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:infusion_crypto_engine/enum/infusion_crypto_type.dart';
import 'package:infusion_crypto_engine/infusion_crypto_channel.dart';
import 'package:infusion_crypto_engine/models/crypto_attributes.dart';
import 'package:infusion_crypto_engine/models/encryption_parts.dart';

class InfusionCryptoEngine extends InfusionCryptoChannel {
  InfusionCryptoEngine(InfusionCryptoType type) {
    setCryptoEngine(type);
  }

  Future<Uint8List> encrypt(CryptoAttributes attributes) async {
    final SecretBox encrypted = await cryptoEngine.encrypt(
      attributes.data,
      secretKey: SecretKey(attributes.derivedKey),
      nonce: attributes.iv,
      aad: attributes.aad,
    );
    return encrypted.concatenation();
  }

  Future<Uint8List> decrypt(CryptoAttributes attributes) async {
    final SecretBox box = SecretBox.fromConcatenation(
      attributes.data,
      nonceLength: cryptoEngine.nonceLength,
      macLength: cryptoEngine.macAlgorithm.macLength,
      copy: false,
    );

    return Uint8List.fromList(
      await cryptoEngine.decrypt(
        box,
        secretKey: SecretKey(attributes.derivedKey),
        aad: attributes.aad,
      ),
    );
  }

  EncryptionParts splitEncryptionParts(Uint8List data) {
    final SecretBox box = SecretBox.fromConcatenation(
      data,
      nonceLength: cryptoEngine.nonceLength,
      macLength: cryptoEngine.macAlgorithm.macLength,
      copy: false,
    );

    return EncryptionParts(
      nonce: box.nonce,
      cipherText: box.cipherText,
      mac: box.mac.bytes,
    );
  }
}
