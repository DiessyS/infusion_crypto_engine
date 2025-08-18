enum InfusionCryptoType {
  chaCha20('ChaCha20', 'ChaCha20-Poly1305', 0x1c6b3f),
  aesGcm128('AES 128', 'AES-128-GCM', 0x56050b),
  aesGcm192('AES 192', 'AES-192-GCM', 0x8b0f6b),
  aesGcm256('AES 256', 'AES-256-GCM', 0xfa80b5);

  final String name;
  final String fullName;
  final int id;

  const InfusionCryptoType(this.name, this.fullName, this.id);

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
