class NoteModel {
  final int? id;
  final String title;
  final String content;
  final DateTime createdAt;

  NoteModel({required this.id, required this.title, required this.content, required this.createdAt});


  // Map<String, Object?> toMap() {
  //   var map = <String, Object?>{
  //     'title': title,
  //     'content': content,
  //     'create_at': createdAt.toIso8601String()
  //   };
  //   if (id != null) {
  //     map['id'] = id;
  //   }
  //   return map;
  // }


  // convert note object to a map to store it in the database.
  // The keys must correspond to the names of the columns in the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'created_at': createdAt.toIso8601String()
    };
  }

  // convert a map from the database back to a Note object
  static NoteModel fromMap(Map<String, dynamic> map) {
    return NoteModel(
        id: map['id'],
        title: map['title'],
        content: map['content'],
        createdAt: DateTime.parse(map['created_at']),
    );
  }
}
