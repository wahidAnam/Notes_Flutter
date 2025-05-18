import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/note_model.dart';
import '../core/constants.dart';

class NotesApi {
    static Future<List<NoteModel>> getNotes(int userId) async {
    final response = await http.get(Uri.parse("$getNotesUrl?user_id=$userId"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['notes'] as List).map((note) => NoteModel.fromJson(note)).toList();
    }
    return [];
  }

  static Future<bool> addNote(String title, String description, int userId) async {
    final response = await http.post(
      Uri.parse(addNoteUrl),
      body: {
        "title": title,
        "description": description,
        "user_id": userId.toString(),
      },
    );

    final data = json.decode(response.body);
    return response.statusCode == 200 && data['success'] == true;
  }
}
