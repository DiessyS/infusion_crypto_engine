library infusion_crypto_engine;

import 'package:cryptography/cryptography.dart';
import 'package:flutter/foundation.dart';
import 'package:infusion_crypto_engine/infusion_crypto_channel.dart';
import 'package:infusion_crypto_engine/enum/infusion_crypto_type.dart';

class InfusionCryptoEngine extends InfusionCryptoChannel {
  InfusionCryptoEngine(InfusionCryptoType type) {
    setCryptoEngine(type);
  }

  Future<Uint8List> encrypt(
    Uint8List data,
    Uint8List iv,
    Uint8List derivedKey,
  ) async {
    final SecretBox encrypted = await cryptoEngine.encrypt(
      data,
      secretKey: SecretKey(derivedKey),
      nonce: iv,
    );
    return encrypted.concatenation();
  }

  Future<Uint8List> decrypt(Uint8List data, Uint8List derivedKey) async {
    final SecretBox box = SecretBox.fromConcatenation(
      data,
      nonceLength: cryptoEngine.nonceLength,
      macLength: cryptoEngine.macAlgorithm.macLength,
      copy: false,
    );

    return Uint8List.fromList(
      await cryptoEngine.decrypt(
        box,
        secretKey: SecretKey(derivedKey),
      ),
    );
  }

  int getAlgorithmEngineCode() {
    return cryptoEngine.channelCipherName.hashCode;
  }
}
