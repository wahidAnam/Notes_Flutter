import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/note_model.dart';
import '../data/notes_api.dart';

final notesProvider = FutureProvider<List<NoteModel>>((ref) async {
  return await NotesApi.getNotes(1); // Use actual user id from auth
});