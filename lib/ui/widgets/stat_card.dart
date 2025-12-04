import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double value; // 0.0 to 1.0
  final IconData icon;
  final Color iconColor;

  const StatCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.softCream.withOpacity(0.5), // Slightly darker than bg
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.heading3.copyWith(fontSize: 16)),
                Text(subtitle, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          Text(
            '${(value * 100).toInt()}%',
            style: AppTextStyles.heading2.copyWith(color: AppColors.darkText),
          ),
        ],
      ),
    );
  }
}
