import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/notes_api.dart';
import '../models/note_model.dart';
import '../models/user_model.dart';
import '../providers/notes_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesProvider);

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("My Notes"),),
      backgroundColor: AppColors.backgroundColor,
      body: notes.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final note = data[index];
            return Card(
              color: Colors.white,
              margin: EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 2),
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            note.title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        PopupMenuButton<String>(
                          onSelected: (value) async {
                            if (value == 'edit') {
                              context.push('/edit-note/${note.id}');
                            } else if (value == 'delete') {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Confirm Delete"),
                                  content: Text(
                                      "Are you sure you want to delete this note?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: Text("Delete"),
                                    ),
                                  ],
                                ),
                              );
                              if (confirm == true) {
                                await NotesApi.deleteNote(note.id);
                                ref.invalidate(notesProvider);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Note deleted")),
                                );
                              }
                            }
                          },
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem(value: 'edit', child: Text('Edit')),
                            PopupMenuItem(
                                value: 'delete', child: Text('Delete')),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      note.description,
                      style: TextStyle(color: Colors.grey[10]),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading notes: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        shape: CircleBorder(),
        onPressed: () => context.push('/add-note'),
        child: Icon(Icons.add, color: Colors.white, size: 35),
      ),
    );
  }
}
