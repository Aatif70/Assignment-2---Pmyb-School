import 'package:flutter/material.dart';
import '../models/session.dart';
import '../core/utils/mock_data.dart';

class DashboardProvider extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();
  int _selectedSessionIndex = 0;
  String _selectedTab = 'Performance'; // Performance or Leaderboard

  DateTime get selectedDate => _selectedDate;
  int get selectedSessionIndex => _selectedSessionIndex;
  String get selectedTab => _selectedTab;

  List<Session> get sessions => MockData.sessions;

  Session get activeSession {
    if (sessions.isEmpty) {
      // Return a dummy session if empty to avoid crashes, or handle gracefully
      return Session(
          id: '0',
          subjectId: 'none',
          topic: 'No Session',
          startTime: DateTime.now(),
          endTime: DateTime.now(),
          status: 'None',
          category: 'None',
          instructorName: '',
          instructorAvatar: '');
    }
    return sessions[_selectedSessionIndex % sessions.length];
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void selectSession(int index) {
    _selectedSessionIndex = index;
    notifyListeners();
  }

  void selectTab(String tab) {
    _selectedTab = tab;
    notifyListeners();
  }
}
