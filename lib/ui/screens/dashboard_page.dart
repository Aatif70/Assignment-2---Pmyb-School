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
import 'performance_page.dart';
import 'leaderboard_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Sync PageController with Provider
    final provider = Provider.of<DashboardProvider>(context);
    if (_pageController.hasClients && 
        (_pageController.page?.round() ?? 0) != provider.selectedSessionIndex) {
      _pageController.animateToPage(
        provider.selectedSessionIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
    }

    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SafeArea(
          child: Column(
            children: [
              const TopAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Consumer<DashboardProvider>(
                    builder: (context, provider, child) {
                      // Check for Tablet Portrait or Mobile
                      bool isTabletPortrait = Responsive.isTablet(context) && 
                          MediaQuery.of(context).orientation == Orientation.portrait;
                      
                      if (Responsive.isMobile(context) || isTabletPortrait) {
                        return _buildPortraitLayout(context, provider);
                      } else {
                        return _buildLandscapeLayout(context, provider);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(BuildContext context, DashboardProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileCard(student: MockData.student),
        const SizedBox(height: 24),
        const DaySelector(),
        const SizedBox(height: 24),
        _buildSessionPageView(provider),
        const SizedBox(height: 24),
        _buildTimeSlots(provider),
        const SizedBox(height: 24),
        SubjectCarousel(sessions: provider.sessions),
        const SizedBox(height: 24),
        _buildActionButtons(context, provider),
        const SizedBox(height: 24),
        _buildStats(),
      ],
    );
  }

  Widget _buildLandscapeLayout(BuildContext context, DashboardProvider provider) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 65,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DaySelector(),
              const SizedBox(height: 32),
              _buildSessionPageView(provider),
              const SizedBox(height: 24),
              _buildTimeSlots(provider),
            ],
          ),
        ),
        const SizedBox(width: 32),
        Expanded(
          flex: 35,
          child: Column(
            children: [
              ProfileCard(student: MockData.student),
              const SizedBox(height: 24),
              _buildActionButtons(context, provider),
              const SizedBox(height: 24),
              _buildStats(),
              const SizedBox(height: 24),
              SubjectCarousel(sessions: provider.sessions),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSessionPageView(DashboardProvider provider) {
    return SizedBox(
      height: 320,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) => provider.selectSession(index),
        itemCount: provider.sessions.length,
        itemBuilder: (context, index) {
          final session = provider.sessions[index];
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 1.0;
              if (_pageController.position.haveDimensions) {
                value = _pageController.page! - index;
                value = (1 - (value.abs() * 0.1)).clamp(0.9, 1.0);
              }
              return Transform.scale(
                scale: value,
                child: Opacity(
                  opacity: value,
                  child: child,
                ),
              );
            },
            child: SessionCard(session: session),
          );
        },
      ),
    );
  }

  Widget _buildTimeSlots(DashboardProvider provider) {
    return SingleChildScrollView(
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
    );
  }

  Widget _buildActionButtons(BuildContext context, DashboardProvider provider) {
    return Row(
      children: [
        Expanded(
          child: ButtonCapsule(
            text: 'Performance',
            icon: Icons.show_chart,
            isSelected: provider.selectedTab == 'Performance',
            onTap: () {
              provider.selectTab('Performance');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PerformancePage()),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ButtonCapsule(
            text: 'Leaderboard',
            icon: Icons.leaderboard,
            isSelected: provider.selectedTab == 'Leaderboard',
            onTap: () {
              provider.selectTab('Leaderboard');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LeaderboardPage()),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Column(
      children: [
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
