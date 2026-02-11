class EncryptionParts {
  final List<int> nonce;
  final List<int> cipherText;
  final List<int> mac;

  EncryptionParts({
    required this.nonce,
    required this.cipherText,
    required this.mac,
  });
}
