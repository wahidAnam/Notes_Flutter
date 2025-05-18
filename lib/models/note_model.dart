class NoteModel {
  final int id;
  final String title;
  final String description;

  NoteModel({required this.id, required this.title, required this.description});

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    try {
      return NoteModel(
        id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
        title: json['title'].toString(),
        description: json['description'].toString(),
      );
    } catch (e) {
      print('Error parsing NoteModel: $e');
      print('Faulty JSON: $json');
      rethrow;
    }
  }

}