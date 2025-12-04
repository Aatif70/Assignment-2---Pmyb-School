import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../state/dashboard_provider.dart';
import '../../core/utils/responsive.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';
import '../widgets/day_selector.dart';
import '../widgets/session_card.dart';
import '../widgets/time_chip.dart';
import '../widgets/profile_card.dart';
import '../widgets/button_capsule.dart';
import '../widgets/stat_card.dart';
import '../widgets/subject_carousel.dart';
import '../../core/utils/mock_data.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: SafeArea(
        child: Column(
          children: [
            const TopAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Consumer<DashboardProvider>(
                  builder: (context, provider, child) {
                    if (Responsive.isMobile(context)) {
                      return _buildMobileLayout(context, provider);
                    } else {
                      return _buildTabletLayout(context, provider);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, DashboardProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DaySelector(),
        const SizedBox(height: 24),
        _buildMainSection(context, provider),
        const SizedBox(height: 24),
        _buildRightPanel(context, provider),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context, DashboardProvider provider) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column (65%)
        Expanded(
          flex: 65,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DaySelector(),
              const SizedBox(height: 32),
              _buildMainSection(context, provider),
            ],
          ),
        ),
        const SizedBox(width: 32),
        // Right Column (35%)
        Expanded(
          flex: 35,
          child: _buildRightPanel(context, provider),
        ),
      ],
    );
  }

  Widget _buildMainSection(BuildContext context, DashboardProvider provider) {
    return Column(
      children: [
        SizedBox(
          height: 320, // Fixed height for the card area
          child: PageView.builder(
            onPageChanged: (index) => provider.selectSession(index),
            itemCount: provider.sessions.length,
            itemBuilder: (context, index) {
              final session = provider.sessions[index];
              // Simple scale animation could be added here with a custom PageView builder
              return SessionCard(session: session);
            },
          ),
        ),
        const SizedBox(height: 24),
        // Time Slots
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: provider.sessions.asMap().entries.map((entry) {
              final index = entry.key;
              final session = entry.value;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: TimeChip(
                  time: session.startTime,
                  isSelected: index == provider.selectedSessionIndex,
                  onTap: () => provider.selectSession(index),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRightPanel(BuildContext context, DashboardProvider provider) {
    return Column(
      children: [
        ProfileCard(student: MockData.student),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: ButtonCapsule(
                text: 'Performance',
                icon: Icons.show_chart,
                isSelected: provider.selectedTab == 'Performance',
                onTap: () => provider.selectTab('Performance'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ButtonCapsule(
                text: 'Leaderboard',
                icon: Icons.leaderboard,
                isSelected: provider.selectedTab == 'Leaderboard',
                onTap: () => provider.selectTab('Leaderboard'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        StatCard(
          title: 'Attendance',
          subtitle: 'Overall Attendance',
          value: MockData.student.attendance,
          icon: Icons.calendar_today,
          iconColor: Colors.grey.shade700,
        ),
        const SizedBox(height: 12),
        StatCard(
          title: 'Performance',
          subtitle: 'This week',
          value: MockData.student.performance,
          icon: Icons.trending_up,
          iconColor: Colors.grey.shade700,
        ),
        const SizedBox(height: 24),
        SubjectCarousel(sessions: provider.sessions),
      ],
    );
  }
}

class TopAppBar extends StatelessWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.softCream,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo or Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.school, color: AppColors.primaryOrange),
          ),
          const SizedBox(width: 12),
          Text('Pupil Learn', style: AppTextStyles.heading2),
          const Spacer(),
          // Search Bar (Visual only for now)
          if (!Responsive.isMobile(context))
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text('Search...', style: AppTextStyles.bodyMedium),
                  ],
                ),
              ),
            ),
          // Notification Bell
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.notifications_none, color: AppColors.darkText),
          ),
        ],
      ),
    );
  }
}
