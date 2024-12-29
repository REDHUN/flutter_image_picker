import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerProvider extends ChangeNotifier {
  Uint8List? webImage;
  File? mobileImage;
  final picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        if (kIsWeb) {
          // Handle Web
          var f = await pickedFile.readAsBytes();
          webImage = f;
          mobileImage = null;
        } else {
          // Handle Mobile
          mobileImage = File(pickedFile.path);
          webImage = null;
        }
        notifyListeners();
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void clearImage() {
    webImage = null;
    mobileImage = null;
    notifyListeners();
  }

  bool get hasImage => webImage != null || mobileImage != null;
}
