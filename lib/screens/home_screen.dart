import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/notes_api.dart';
import '../models/note_model.dart';
import '../providers/notes_provider.dart';
import 'login_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesProvider);

    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text("My Notes")),
      body: notes.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final note = data[index];
            return Card(
              child: ListTile(
                title: Text(note.title),
                subtitle: Text(note.description),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading notes: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add-note'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
