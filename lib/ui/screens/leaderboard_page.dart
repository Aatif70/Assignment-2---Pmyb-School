import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/utils/mock_data.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sort leaderboard by rank
    final sortedLeaderboard = List<Map<String, dynamic>>.from(MockData.leaderboard)
      ..sort((a, b) => (a['rank'] as int).compareTo(b['rank'] as int));

    final topThree = sortedLeaderboard.take(3).toList();
    final rest = sortedLeaderboard.skip(3).toList();

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
          const SizedBox(height: 24),
          _buildTopThree(topThree),
          const SizedBox(height: 32),
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
    return Row(
      children: [
        Text(
          '#${student['rank']}',
          style: AppTextStyles.heading3.copyWith(color: Colors.grey),
        ),
        const SizedBox(width: 16),
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
