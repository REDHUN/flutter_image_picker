import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/image_provider.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ImagePickerProvider>(
      builder: (context, imageProvider, child) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300, width: 2),
                      color: Colors.grey.shade100,
                    ),
                    child: imageProvider.hasImage
                        ? ClipOval(
                            child: kIsWeb
                                ? Image.memory(
                                    imageProvider.webImage!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    imageProvider.mobileImage!,
                                    fit: BoxFit.cover,
                                  ),
                          )
                        : const Icon(
                            Icons.person,
                            size: 80,
                            color: Colors.grey,
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: imageProvider.hasImage
                            ? Colors.red.shade400
                            : Colors.pink.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          imageProvider.hasImage ? Icons.delete : Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: imageProvider.hasImage
                            ? imageProvider.clearImage
                            : () =>
                                imageProvider.pickImage(ImageSource.gallery),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
