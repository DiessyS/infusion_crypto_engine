import 'dart:typed_data';

import 'package:cryptography_flutter_plus/cryptography_flutter_plus.dart';
import 'package:cryptography_plus/helpers.dart';
import 'package:infusion_crypto_engine/enum/infusion_crypto_type.dart';

class InfusionCryptoChannel {
  late FlutterCipherMixin _cryptoEngine;
  late InfusionCryptoType _cryptoType;

  FlutterCipherMixin get cryptoEngine => _cryptoEngine;

  InfusionCryptoChannel() {
    _cryptoType = InfusionCryptoType.chaCha20;
    setCryptoEngine(_cryptoType);
  }

  setCryptoEngine(InfusionCryptoType type) {
    _cryptoType = type;
    switch (_cryptoType) {
      case InfusionCryptoType.chaCha20:
        _cryptoEngine = FlutterChacha20.poly1305Aead();
        break;
      case InfusionCryptoType.aesGcm128:
        _cryptoEngine = FlutterAesGcm.with128bits();
        break;
      case InfusionCryptoType.aesGcm192:
        _cryptoEngine = FlutterAesGcm.with192bits();
        break;
      case InfusionCryptoType.aesGcm256:
        _cryptoEngine = FlutterAesGcm.with256bits();
        break;
    }
  }

  int getCryptoEngineKeyLength() {
    return _cryptoEngine.secretKeyLength;
  }

  Uint8List generateIV() {
    return randomBytes(_cryptoEngine.nonceLength);
  }
}
