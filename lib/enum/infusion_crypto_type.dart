enum InfusionCryptoType {
  chaCha20('ChaCha20'),
  aesGcm128('AES-GCM-128'),
  aesGcm192('AES-GCM-192'),
  aesGcm256('AES-GCM-256');

  final String name;

  const InfusionCryptoType(this.name);

  static InfusionCryptoType fromString(String value) {
    return InfusionCryptoType.values.firstWhere(
      (type) => type.name == value,
      orElse: () => InfusionCryptoType.chaCha20,
    );
  }

  String label() {
    switch (this) {
      case InfusionCryptoType.chaCha20:
        return InfusionCryptoType.chaCha20.name;
      case InfusionCryptoType.aesGcm128:
        return InfusionCryptoType.aesGcm128.name;
      case InfusionCryptoType.aesGcm192:
        return InfusionCryptoType.aesGcm192.name;
      case InfusionCryptoType.aesGcm256:
        return InfusionCryptoType.aesGcm256.name;
    }
  }
}
