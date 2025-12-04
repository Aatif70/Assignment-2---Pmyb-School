import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../models/session.dart';
import '../../models/subject.dart';
import '../../core/utils/mock_data.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

class SessionCard extends StatelessWidget {
  final Session session;

  const SessionCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final subject = MockData.getSubject(session.subjectId);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Pattern (dots) - Simplified for now
          Positioned.fill(
            child: CustomPaint(
              painter: DotPatternPainter(),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: session.status == 'Live Now' 
                            ? Colors.black87 
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          if (session.status == 'Live Now')
                            Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.only(right: 6),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          Text(
                            session.status,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: session.status == 'Live Now' ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${session.endTime.difference(session.startTime).inMinutes} Mins',
                      style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                
                const Spacer(),
                
                // Subject Illustration (Lottie)
                Center(
                  child: Lottie.asset(
                    subject.iconAsset,
                    height: 150,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.science,
                      size: 80,
                      color: subject.color,
                    ),
                  ),
                ),
                
                const Spacer(),
                
                // Subject Name & Category
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      subject.name,
                      style: AppTextStyles.heading2,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        session.category,
                        style: AppTextStyles.bodySmall.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  session.topic,
                  style: AppTextStyles.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
          // Big Number
          Positioned(
            right: 20,
            top: 60,
            child: Text(
              session.id,
              style: AppTextStyles.heading1.copyWith(
                fontSize: 120,
                color: Colors.grey.shade100,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          // Instructor Avatar
          Positioned(
            right: 24,
            bottom: 80,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade100,
              ),
              child: ClipOval(
                child: Lottie.asset(
                  session.instructorAvatar,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DotPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 1.5;

    const double spacing = 20;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
