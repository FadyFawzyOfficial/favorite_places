import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final void Function(File?) onSaved;

  const ImageInput({super.key, required this.onSaved});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return FormField<File>(
      onSaved: widget.onSaved,
      validator: (imageFile) => imageFile == null ? 'Image is required' : null,
      builder: (filedState) => InputDecorator(
        decoration: InputDecoration(
          errorText: filedState.errorText,
          errorBorder: InputBorder.none,
        ),
        child: Container(
          height: 250,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: selectedImage == null
              ? TextButton.icon(
                  icon: const Icon(Icons.camera_rounded),
                  label: const Text('Take Picture'),
                  onPressed: takePicture,
                )
              : InkWell(
                  onTap: takePicture,
                  child: Image.file(
                    selectedImage!,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage == null) return;

    setState(() {
      selectedImage = File(pickedImage.path);
    });
  }
}
