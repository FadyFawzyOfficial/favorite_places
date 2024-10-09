import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/place.dart';
import '../providers/places_provider.dart';
import '../widgets/image_input.dart';

class NewPlaceView extends ConsumerStatefulWidget {
  const NewPlaceView({super.key});

  @override
  ConsumerState<NewPlaceView> createState() => _NewPlaceViewState();
}

class _NewPlaceViewState extends ConsumerState<NewPlaceView> {
  final formKey = GlobalKey<FormState>();
  var title = '';

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add new place')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                    value == null || value.isEmpty || value.length < 2
                        ? 'Invalid input!'
                        : null,
                onSaved: (value) => title = value!,
              ),
              const SizedBox(height: 16),
              const ImageInput(),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: saveItem,
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add place'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveItem() async {
    final form = formKey.currentState;

    if (form != null && form.validate()) {
      form.save();

      final newPlace = Place(id: '${DateTime.now()}', title: title);

      ref.read(placesProvider.notifier).addPlace(place: newPlace);

      Navigator.pop(context);
    }
  }
}
