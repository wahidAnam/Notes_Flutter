import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/note_model.dart';
import '../core/constants.dart';

class NotesApi {
    //Getting all notes
    static Future<List<NoteModel>> getNotes(int userId) async {
    final response = await http.get(Uri.parse("$getNotesUrl?user_id=$userId"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['notes'] as List).map((note) => NoteModel.fromJson(note)).toList();
    }
    return [];
  }

  //add notes by users
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

    //delete notes by user
    static Future<bool> deleteNote(int noteId) async {
      final response = await http.post(
        Uri.parse('$baseUrl/delete_note.php'),
        body: {
          'id': noteId.toString(),
        },
      );

      if (response.statusCode == 200) {
        return response.body.trim() == 'success';
      } else {
        return false;
      }
    }

    static Future<NoteModel?> fetchNoteById(int id) async {
      final response = await http.get(Uri.parse('$getNotesbyIdUrl?id=$id'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return NoteModel.fromJson(data);
      }
      return null;
    }

    static Future<bool> updateNote(int id, String title, String description) async {
      final response = await http.post(
        Uri.parse(updateNoteUrl),
        body: {
          'id': id.toString(),
          'title': title,
          'description': description,
        },
      );
      return response.statusCode == 200 && response.body.trim() == 'success';
    }

}
