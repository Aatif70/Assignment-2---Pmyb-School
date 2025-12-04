import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../../core/utils/mock_data.dart';

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverallScore(),
            const SizedBox(height: 32),
            Text('Subject Breakdown', style: AppTextStyles.heading3),
            const SizedBox(height: 16),
            ...MockData.performanceStats.map((stat) => _buildSubjectStat(stat)),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallScore() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Overall Score', style: AppTextStyles.bodyMedium),
                const SizedBox(height: 8),
                Text(
                  '${(MockData.student.performance * 100).toInt()}%',
                  style: AppTextStyles.heading1.copyWith(color: AppColors.primaryOrange),
                ),
                const SizedBox(height: 8),
                Text(
                  'Great job! You are doing better than 85% of your class.',
                  style: AppTextStyles.bodySmall.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(
              value: MockData.student.performance,
              strokeWidth: 12,
              backgroundColor: Colors.grey.shade100,
              color: AppColors.primaryOrange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectStat(Map<String, dynamic> stat) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(stat['subject'], style: AppTextStyles.heading3),
              Text(
                '${stat['score']}/${stat['total']}',
                style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: stat['score'] / stat['total'],
              minHeight: 8,
              backgroundColor: Colors.grey.shade100,
              color: stat['color'],
            ),
          ),
        ],
      ),
    );
  }
}
