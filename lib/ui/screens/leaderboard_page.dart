import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/utils/mock_data.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {

  @override
  Widget build(BuildContext context) {
    // Sort leaderboard by rank
    final sortedLeaderboard = List<Map<String, dynamic>>.from(MockData.leaderboard)
      ..sort((a, b) => (a['rank'] as int).compareTo(b['rank'] as int));

    final topThree = sortedLeaderboard.take(3).toList();
    final rest = sortedLeaderboard.skip(3).toList();
    
    // Find rival (person just above current user)
    final currentUserIndex = sortedLeaderboard.indexWhere((s) => s['name'] == 'Aatif');
    final rival = currentUserIndex > 0 ? sortedLeaderboard[currentUserIndex - 1] : null;

    return Scaffold(
      backgroundColor: AppColors.softCream,
      appBar: AppBar(
        title: Text('Leaderboard', style: AppTextStyles.heading2),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.darkText),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          _buildTopThree(topThree),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: ListView.separated(
                padding: const EdgeInsets.all(24),
                itemCount: rest.length,
                separatorBuilder: (context, index) => const Divider(height: 32),
                itemBuilder: (context, index) {
                  final student = rest[index];
                  return _buildRankItem(student);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildRivalCard(Map<String, dynamic> rival) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryOrange, AppColors.primaryOrange.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryOrange.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 24,
            child: Lottie.asset(rival['avatar'], width: 40),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Beat your rival!',
                  style: AppTextStyles.bodySmall.copyWith(color: Colors.white70),
                ),
                Text(
                  '${rival['points'] - 2350} pts to pass ${rival['name']}', // Hardcoded user points for demo
                  style: AppTextStyles.heading3.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildTopThree(List<Map<String, dynamic>> topThree) {
    if (topThree.length < 3) return const SizedBox();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildPodiumItem(topThree[1], 2, 140, AppColors.accentBlue),
        const SizedBox(width: 16),
        _buildPodiumItem(topThree[0], 1, 180, AppColors.primaryYellow),
        const SizedBox(width: 16),
        _buildPodiumItem(topThree[2], 3, 120, AppColors.primaryOrange),
      ],
    );
  }

  Widget _buildPodiumItem(Map<String, dynamic> student, int rank, double height, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.white,
          child: Lottie.asset(student['avatar'], width: 40, height: 40),
        ),
        const SizedBox(height: 8),
        Text(student['name'], style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Container(
          width: 80,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '#$rank',
                style: AppTextStyles.heading1.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 4),
              Text(
                '${student['points']}',
                style: AppTextStyles.bodySmall.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRankItem(Map<String, dynamic> student) {
    IconData changeIcon;
    Color changeColor;
    
    switch (student['change']) {
      case 'up':
        changeIcon = Icons.arrow_drop_up;
        changeColor = Colors.green;
        break;
      case 'down':
        changeIcon = Icons.arrow_drop_down;
        changeColor = Colors.red;
        break;
      default:
        changeIcon = Icons.remove;
        changeColor = Colors.grey;
    }

    return Row(
      children: [
        SizedBox(
          width: 40,
          child: Column(
            children: [
              Text(
                '#${student['rank']}',
                style: AppTextStyles.heading3.copyWith(color: Colors.grey),
              ),
              Icon(changeIcon, color: changeColor, size: 20),
            ],
          ),
        ),
        const SizedBox(width: 12),
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey.shade100,
          child: Lottie.asset(student['avatar'], width: 40, height: 40),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(student['name'], style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.softCream,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${student['points']} pts',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.primaryOrange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
