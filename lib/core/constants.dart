class Constants {
  // Database constants
  static const String dbName = 'notes.db';
  static const int dbVersion = 1;
  
  // Table constants
  static const String tableNotes = 'notes';
  static const String columnId = 'id';
  static const String columnTitle = 'title';
  static const String columnContent = 'content';
  static const String columnCreatedAt = 'created_at';
  static const String columnUpdatedAt = 'updated_at';
  
  // Date format
  static const String dateFormat = 'MMM dd, yyyy HH:mm';
}