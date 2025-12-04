import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../state/dashboard_provider.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

class DaySelector extends StatelessWidget {
  const DaySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    final now = DateTime.now();
    // Generate next 7 days
    final days = List.generate(7, (index) => now.add(Duration(days: index)));

    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final date = days[index];
          final isSelected = date.day == provider.selectedDate.day &&
              date.month == provider.selectedDate.month;

          return GestureDetector(
            onTap: () => provider.selectDate(date),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              width: 60,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryYellow : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isSelected ? Colors.transparent : Colors.grey.shade300,
                  width: 1,
                ),
                boxShadow: [
                  if (isSelected)
                    BoxShadow(
                      color: AppColors.primaryYellow.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  else
                    const BoxShadow(
                      color: Colors.transparent,
                      blurRadius: 0,
                      offset: Offset.zero,
                    ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date.day.toString(),
                    style: isSelected
                        ? AppTextStyles.heading3.copyWith(color: AppColors.darkText)
                        : AppTextStyles.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('E').format(date),
                    style: isSelected
                        ? AppTextStyles.bodySmall.copyWith(
                            color: AppColors.darkText, fontWeight: FontWeight.bold)
                        : AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
