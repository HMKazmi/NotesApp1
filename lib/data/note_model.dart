
import 'package:notes_app1/core/constants.dart';

class Note {
  int? id;
  String title;
  String content;
  DateTime createdAt;
  DateTime updatedAt;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  Note copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Constants.columnId: id,
      Constants.columnTitle: title,
      Constants.columnContent: content,
      Constants.columnCreatedAt: createdAt.toIso8601String(),
      Constants.columnUpdatedAt: updatedAt.toIso8601String(),
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map[Constants.columnId],
      title: map[Constants.columnTitle],
      content: map[Constants.columnContent],
      createdAt: DateTime.parse(map[Constants.columnCreatedAt]),
      updatedAt: DateTime.parse(map[Constants.columnUpdatedAt]),
    );
  }
}