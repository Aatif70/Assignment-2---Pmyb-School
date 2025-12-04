import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.leaderboard, size: 80, color: AppColors.accentBlue),
            const SizedBox(height: 16),
            Text('Class Rankings', style: AppTextStyles.heading3),
            const SizedBox(height: 8),
            Text('Coming Soon', style: AppTextStyles.bodyMedium),
          ],
        ),
      ),
    );
  }
}
