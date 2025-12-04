import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

class ButtonCapsule extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const ButtonCapsule({
    super.key,
    required this.text,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryYellow : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected 
                  ? AppColors.primaryYellow.withOpacity(0.4) 
                  : Colors.black.withOpacity(0.05),
              blurRadius: isSelected ? 12 : 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: AppColors.darkText,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: AppTextStyles.buttonText.copyWith(
                color: AppColors.darkText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
