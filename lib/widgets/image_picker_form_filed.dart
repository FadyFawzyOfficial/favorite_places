import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerFormFiled extends StatefulWidget {
  final void Function(File?) onSaved;

  const ImagePickerFormFiled({super.key, required this.onSaved});

  @override
  State<ImagePickerFormFiled> createState() => _ImagePickerFormFiledState();
}

class _ImagePickerFormFiledState extends State<ImagePickerFormFiled> {
  @override
  Widget build(BuildContext context) {
    return FormField<File>(
      onSaved: widget.onSaved,
      validator: (imageFile) => imageFile == null ? 'Image is required' : null,
      builder: (filedState) => InputDecorator(
        decoration: InputDecoration(
          errorText: filedState.errorText,
          border: InputBorder.none,
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
          child: filedState.value == null
              ? TextButton.icon(
                  icon: const Icon(Icons.camera_rounded),
                  label: const Text('Take Picture'),
                  onPressed: () => takePicture(filedState),
                )
              : InkWell(
                  onTap: () => takePicture(filedState),
                  child: Image.file(
                    filedState.value!,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> takePicture(FormFieldState filedState) async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage == null) return;

    filedState.didChange(File(pickedImage.path));
  }
}
