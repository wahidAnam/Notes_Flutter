import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/notes_api.dart';
import '../models/note_model.dart';
import '../providers/notes_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesProvider);

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("My Notes")),
      body: notes.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final note = data[index];
            return Card(
              color: Colors.grey[50],
              margin: EdgeInsets.only(left: 16,right: 16,top: 6),
              child: ListTile(
                title: Text(note.title),
                subtitle: Text(note.description),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) async {
                    if (value == 'edit') {
                      // Navigate to edit screen with note ID
                      context.push('/edit-note/${note.id}');
                    } else if (value == 'delete') {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Confirm Delete"),
                          content: const Text(
                              "Are you sure you want to delete this note?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text("Delete"),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        await NotesApi.deleteNote(note.id);
                        ref.invalidate(notesProvider); // Refresh list
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Note deleted")),
                        );
                      }
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(value: 'edit', child: Text('Edit')),
                    const PopupMenuItem(value: 'delete', child: Text('Delete')),
                  ],
                ),
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
