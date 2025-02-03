# 🔐 Flutter Encryption & Decryption App

A simple Flutter app that encrypts and decrypts text using a **custom algorithm**. The encryption is case-sensitive and key-dependent.

## 🚀 Features
✅ Encrypt and decrypt text using a **custom algorithm**  
✅ Uses a **secret key** for encryption and decryption  
✅ Supports **case-sensitive encryption**  
✅ **Flutter UI** for easy interaction  

---

## 📌 How It Works
1. **Encryption**  
   - The input text is **XOR-encoded** with a secret key.  
   - The characters are **shuffled** based on the key length.  
   - The result is **Base64 encoded** for safe storage.  

2. **Decryption**  
   - The text is **Base64 decoded**.  
   - The characters are **unshuffled** back to their original order.  
   - The **XOR operation** reverses the encryption to restore the text.  

---

## 📂 Installation & Usage
1. Clone or download the **`flutter_encryption_ui.dart`** file into your Flutter project.  
2. Open a terminal and run:  
   ```sh
   flutter pub get
   flutter run
   
3. Enter your text and secret key in the UI.  
4. Click **"Encrypt"** to get the encrypted output.  
5. Click **"Decrypt"** to revert it to the original text.  

---

## 🔑 Example Usage

| **Input Text**  | **Secret Key** | **Encrypted Output**            | **Decrypted Output** |
|----------------|---------------|---------------------------------|----------------------|
| Hello, World! | HNG12         | `U29tZUVuY3J5cHRlZFRleHQ=`      | Hello, World!       |
| Flutter Rocks! | SecureKey123  | `Y29vbEVuY3J5cHRlZFRleHQ=`      | Flutter Rocks!      |

---
