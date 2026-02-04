import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CloudinaryService {
  static const String cloudName = "dxagoh5ri";
  static const String uploadPreset = "koutix_supermarket_logo";
  static const String apiKey = "165692813238855"; // Provided by user

  // Base URL for unsigned upload
  static const String _uploadUrl =
      "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

  /// Uploads an image file to Cloudinary and returns the secure URL.
  /// Returns null if upload fails.
  Future<String?> uploadLogo(XFile imageFile) async {
    try {
      final url = Uri.parse(_uploadUrl);

      var request = http.MultipartRequest("POST", url);

      request.fields['upload_preset'] = uploadPreset;

      if (kIsWeb) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'file',
            await imageFile.readAsBytes(),
            filename: imageFile.name,
          ),
        );
      } else {
        request.files.add(
          await http.MultipartFile.fromPath('file', imageFile.path),
        );
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        final resBody = await response.stream.bytesToString();
        final data = jsonDecode(resBody);
        return data['secure_url'];
      } else {
        final resBody = await response.stream.bytesToString();
        print("Cloudinary Upload Failed: ${response.statusCode} - $resBody");
        return null;
      }
    } catch (e) {
      print("Error uploading to Cloudinary: $e");
      return null;
    }
  }
}
