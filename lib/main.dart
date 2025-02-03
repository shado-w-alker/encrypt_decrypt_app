import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(EncryptionApp());
}

class EncryptionApp extends StatelessWidget {
  const EncryptionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EncryptionScreen(),
    );
  }
}

class EncryptionScreen extends StatefulWidget {
  const EncryptionScreen({super.key});

  @override
  State<EncryptionScreen> createState() => _EncryptionScreenState();
}

class _EncryptionScreenState extends State<EncryptionScreen> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  String _result = "";

  void encryptText() {
    String text = _textController.text;
    String key = _keyController.text;
    if (text.isEmpty || key.isEmpty) return;
    setState(() {
      _result = encrypt(text, key);
    });

    _textController.text = '';
    _keyController.text = '';
  }

  void decryptText() {
    String text = _textController.text;
    String key = _keyController.text;
    if (text.isEmpty || key.isEmpty) return;
    setState(() {
      _result = decrypt(text, key);
    });

    _textController.text = '';
    _keyController.text = '';
  }

  String encrypt(String text, String key) {
    List<int> xorText = List.generate(text.length, (i) {
      return text.codeUnitAt(i) ^ key.codeUnitAt(i % key.length);
    });
    String shuffledText =
        shuffleText(String.fromCharCodes(xorText), key.length);
    return base64.encode(utf8.encode(shuffledText));
  }

  String decrypt(String encryptedText, String key) {
    String decodedText = utf8.decode(base64.decode(encryptedText));
    String unshuffledText = unshuffleText(decodedText, key.length);
    List<int> decryptedText = List.generate(unshuffledText.length, (i) {
      return unshuffledText.codeUnitAt(i) ^ key.codeUnitAt(i % key.length);
    });
    return String.fromCharCodes(decryptedText);
  }

  String shuffleText(String text, int keyLength) {
    List<String> arr = text.split('');
    for (int i = 0; i < arr.length; i++) {
      int swapIndex = (i + keyLength) % arr.length;
      String temp = arr[i];
      arr[i] = arr[swapIndex];
      arr[swapIndex] = temp;
    }
    return arr.join('');
  }

  String unshuffleText(String text, int keyLength) {
    List<String> arr = text.split('');
    for (int i = arr.length - 1; i >= 0; i--) {
      int swapIndex = (i + keyLength) % arr.length;
      String temp = arr[i];
      arr[i] = arr[swapIndex];
      arr[swapIndex] = temp;
    }
    return arr.join('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Encryption App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(labelText: "Enter text"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _keyController,
              decoration: InputDecoration(labelText: "Enter key"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: encryptText, child: Text("Encrypt")),
                ElevatedButton(onPressed: decryptText, child: Text("Decrypt")),
              ],
            ),
            SizedBox(height: 20),
            SelectableText(
              _result,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
