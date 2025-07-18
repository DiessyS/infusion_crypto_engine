enum InfusionCryptoType {
  chaCha20('ChaCha20', 0xe97bed2),
  aesGcm128('AES-GCM-128', 0x56050b),
  aesGcm192('AES-GCM-192', 0x8b0f6b),
  aesGcm256('AES-GCM-256', 0xfa80b5);

  final String name;
  final int id;

  const InfusionCryptoType(this.name, this.id);

  static InfusionCryptoType fromId(int? id) {
    return InfusionCryptoType.values.firstWhere(
      (type) => type.id == id,
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
