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

  static final List<Map<String, dynamic>> performanceStats = [
    {
      'subject': 'Physics',
      'score': 85,
      'total': 100,
      'color': AppColors.accentBlue,
      'strengths': ['Mechanics', 'Thermodynamics'],
      'improvements': ['Optics']
    },
    {
      'subject': 'Chemistry',
      'score': 92,
      'total': 100,
      'color': AppColors.accentPurple,
      'strengths': ['Organic Chemistry', 'Bonding'],
      'improvements': ['Stoichiometry']
    },
    {
      'subject': 'Math',
      'score': 78,
      'total': 100,
      'color': AppColors.accentGreen,
      'strengths': ['Algebra', 'Geometry'],
      'improvements': ['Calculus']
    },
    {
      'subject': 'Science',
      'score': 88,
      'total': 100,
      'color': AppColors.primaryOrange,
      'strengths': ['Biology', 'Ecology'],
      'improvements': ['Genetics']
    },
  ];

  static final List<Map<String, dynamic>> weeklyActivity = [
    {'day': 'Mon', 'hours': 2.5},
    {'day': 'Tue', 'hours': 3.0},
    {'day': 'Wed', 'hours': 1.5},
    {'day': 'Thu', 'hours': 4.0},
    {'day': 'Fri', 'hours': 2.0},
    {'day': 'Sat', 'hours': 5.0},
    {'day': 'Sun', 'hours': 3.5},
  ];

  static final List<Map<String, dynamic>> earnedBadges = [
    {'name': 'Early Bird', 'icon': Icons.wb_sunny, 'color': Colors.orange},
    {'name': 'Homework Hero', 'icon': Icons.assignment_turned_in, 'color': Colors.blue},
    {'name': 'Math Whiz', 'icon': Icons.calculate, 'color': Colors.green},
    {'name': 'Perfect Week', 'icon': Icons.calendar_today, 'color': Colors.purple},
  ];

  static final List<Map<String, dynamic>> leaderboard = [
    {'rank': 1, 'name': 'Aatif', 'points': 2500, 'avatar': 'assets/lottie/user_profile.json', 'change': 'up'}, // Current user
    {'rank': 2, 'name': 'Sarah M.', 'points': 2450, 'avatar': 'assets/lottie/user_profile.json', 'change': 'down'},
    {'rank': 3, 'name': 'John D.', 'points': 2380, 'avatar': 'assets/lottie/user_profile.json', 'change': 'down'},
    {'rank': 4, 'name': 'Emily R.', 'points': 2100, 'avatar': 'assets/lottie/user_profile.json', 'change': 'up'},
    {'rank': 5, 'name': 'Michael B.', 'points': 1950, 'avatar': 'assets/lottie/user_profile.json', 'change': 'down'},
    {'rank': 6, 'name': 'Jessica T.', 'points': 1890, 'avatar': 'assets/lottie/user_profile.json', 'change': 'same'},
    {'rank': 7, 'name': 'David K.', 'points': 1820, 'avatar': 'assets/lottie/user_profile.json', 'change': 'up'},
    {'rank': 8, 'name': 'Olivia L.', 'points': 1750, 'avatar': 'assets/lottie/user_profile.json', 'change': 'down'},
    {'rank': 9, 'name': 'Daniel P.', 'points': 1680, 'avatar': 'assets/lottie/user_profile.json', 'change': 'same'},
    {'rank': 10, 'name': 'Sophia H.', 'points': 1600, 'avatar': 'assets/lottie/user_profile.json', 'change': 'up'},
  ];
}
