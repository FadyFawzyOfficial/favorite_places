import 'package:flutter/material.dart';

class NewPlaceView extends StatefulWidget {
  const NewPlaceView({super.key});

  @override
  State<NewPlaceView> createState() => _NewPlaceViewState();
}

class _NewPlaceViewState extends State<NewPlaceView> {
  final formKey = GlobalKey<FormState>();

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
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add place'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
