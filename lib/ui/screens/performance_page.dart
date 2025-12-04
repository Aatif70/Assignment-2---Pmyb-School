import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

class PerformancePage extends StatelessWidget {
  const PerformancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softCream,
      appBar: AppBar(
        title: Text('Performance', style: AppTextStyles.heading2),
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
            const Icon(Icons.show_chart, size: 80, color: AppColors.primaryOrange),
            const SizedBox(height: 16),
            Text('Student Progress Graph', style: AppTextStyles.heading3),
            const SizedBox(height: 8),
            Text('Coming Soon', style: AppTextStyles.bodyMedium),
          ],
        ),
      ),
    );
  }
}
