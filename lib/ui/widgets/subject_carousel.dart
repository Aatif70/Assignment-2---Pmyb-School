import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../models/session.dart';
import '../../core/utils/mock_data.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

class SubjectCarousel extends StatelessWidget {
  final List<Session> sessions;

  const SubjectCarousel({super.key, required this.sessions});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemCount: sessions.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final session = sessions[index];
          final subject = MockData.getSubject(session.subjectId);

          return Container(
            width: 180,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        session.category.split(' ').first, // Shorten
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Text(
                      '45 Mins',
                      style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Lottie.asset(
                      subject.iconAsset,
                      height: 50,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.book,
                        size: 30,
                        color: subject.color,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      session.id,
                      style: AppTextStyles.heading1.copyWith(
                        color: Colors.grey.shade100,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  subject.name,
                  style: AppTextStyles.heading3.copyWith(fontSize: 16),
                ),
                Text(
                  session.category,
                  style: AppTextStyles.bodySmall.copyWith(fontSize: 10),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
