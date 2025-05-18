import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/notes_api.dart';
import '../models/note_model.dart';
import '../screens/login_screen.dart';

final notesProvider = FutureProvider<List<NoteModel>>((ref) async {
  final user = ref.watch(authStateProvider);
  if (user == null) return []; // or throw an error
  return await NotesApi.getNotes(user.id);
});
