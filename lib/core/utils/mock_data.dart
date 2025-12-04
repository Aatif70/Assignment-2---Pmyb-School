import 'package:flutter/material.dart';
import '../../models/session.dart';
import '../../models/subject.dart';
import '../../models/student.dart';
import '../theme/colors.dart';

class MockData {
  static final Student student = Student(
    id: '1',
    name: 'Aatif',
    avatarAsset: 'assets/lottie/user_profile.json',
    attendance: 0.95,
    performance: 0.95,
  );

  static final List<Subject> subjects = [
    Subject(
      id: 'physics',
      name: 'Physics',
      iconAsset: 'assets/lottie/physics.json',
      color: AppColors.accentBlue,
    ),
    Subject(
      id: 'chemistry',
      name: 'Chemistry',
      iconAsset: 'assets/lottie/chemistry.json',
      color: AppColors.accentPurple,
    ),
    Subject(
      id: 'math',
      name: 'Math',
      iconAsset: 'assets/lottie/math.json',
      color: AppColors.accentGreen,
    ),
    Subject(
      id: 'science',
      name: 'Science',
      iconAsset: 'assets/lottie/science.json',
      color: AppColors.primaryOrange,
    ),
  ];

  static final List<Session> sessions = [
    Session(
      id: '1',
      subjectId: 'physics',
      topic: 'Triangles: Similarity vs Congruence',
      startTime: DateTime.now().subtract(Duration(minutes: 30)),
      endTime: DateTime.now().add(Duration(minutes: 15)),
      status: 'Live Now',
      category: 'In class Lecture',
      instructorName: 'Dr. Smith',
      instructorAvatar: 'assets/lottie/user_profile.json',
    ),
    Session(
      id: '2',
      subjectId: 'chemistry',
      topic: 'Chemical Bonding – Ionic vs Covalent',
      startTime: DateTime.now().add(Duration(hours: 2)),
      endTime: DateTime.now().add(Duration(hours: 3)),
      status: 'Upcoming',
      category: 'In class Q&A',
      instructorName: 'Prof. Johnson',
      instructorAvatar: 'assets/lottie/user_profile.json',
    ),
    Session(
      id: '3',
      subjectId: 'math',
      topic: 'Calculus: Derivatives',
      startTime: DateTime.now().add(Duration(hours: 4)),
      endTime: DateTime.now().add(Duration(hours: 5)),
      status: 'Upcoming',
      category: 'After Hour Session',
      instructorName: 'Mr. Brown',
      instructorAvatar: 'assets/lottie/user_profile.json',
    ),
    Session(
      id: '4',
      subjectId: 'science',
      topic: 'Newton\'s Laws Recap',
      startTime: DateTime.now().subtract(Duration(hours: 2)),
      endTime: DateTime.now().subtract(Duration(hours: 1)),
      status: 'Completed',
      category: 'In class Lecture',
      instructorName: 'Mrs. Davis',
      instructorAvatar: 'assets/lottie/user_profile.json',
    ),
  ];
  
  static Subject getSubject(String id) {
    return subjects.firstWhere((s) => s.id == id, orElse: () => subjects[0]);
  }
}
