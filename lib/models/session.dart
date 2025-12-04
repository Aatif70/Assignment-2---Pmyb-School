class Session {
  final String id;
  final String subjectId;
  final String topic;
  final DateTime startTime;
  final DateTime endTime;
  final String status; // "Live Now", "Completed", "Upcoming"
  final String category; // "In Class", "After Hour"
  final String instructorName;
  final String instructorAvatar;

  Session({
    required this.id,
    required this.subjectId,
    required this.topic,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.category,
    required this.instructorName,
    required this.instructorAvatar,
  });
}
