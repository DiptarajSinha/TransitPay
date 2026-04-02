import 'dart:convert';
import 'dart:math';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EncryptionService {
  static final EncryptionService _instance = EncryptionService._internal();
  factory EncryptionService() => _instance;
  EncryptionService._internal();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  static const String _encryptionKeyTag = 'app_encryption_key';
  
  Key? _key;

  Future<void> init() async {
    if (_key != null) return;
    
    String? storedKey = await _secureStorage.read(key: _encryptionKeyTag);
    if (storedKey == null) {
      final random = Random.secure();
      final values = List<int>.generate(32, (i) => random.nextInt(256));
      storedKey = base64Url.encode(values);
      await _secureStorage.write(key: _encryptionKeyTag, value: storedKey);
    }
    
    // Just ensure it's 32 bytes by decoding 
    // base64Url padding might cause minor issues if not padded correctly in old versions, but it's safe now.
    _key = Key.fromBase64(padBase64(storedKey));
  }

  String get isarKey => _key?.base64 ?? '';

  String padBase64(String str) {
    str = str.padRight(str.length + (4 - str.length % 4) % 4, '=');
    return str;
  }

  String encryptField(String plainText) {
    if (_key == null) throw Exception("EncryptionService not initialized");
    final iv = IV.fromSecureRandom(16);
    final encrypter = Encrypter(AES(_key!));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return '${iv.base64}:${encrypted.base64}';
  }

  String decryptField(String encryptedText) {
    if (_key == null) throw Exception("EncryptionService not initialized");
    final parts = encryptedText.split(':');
    if (parts.length != 2) return encryptedText; // Fallback if not encrypted (backwards compatibility)
    try {
      final iv = IV.fromBase64(parts[0]);
      final encrypter = Encrypter(AES(_key!));
      return encrypter.decrypt(Encrypted.fromBase64(parts[1]), iv: iv);
    } catch (e) {
      return encryptedText; // Return original if decompression/decryption failure
    }
  }
}
