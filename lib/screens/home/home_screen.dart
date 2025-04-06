import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/common/app_colors.dart';
import 'package:todo/common/app_theme.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/providers/theme_provider.dart';
import 'package:todo/ui/taps/settings/settings_tap.dart';
import 'package:todo/ui/taps/tasks/list_tap.dart';
import 'package:todo/ui/widgets/buttom_sheet.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTapIndex = 0;
  List<Widget> tapsList = [
    const ListTap(),
    const SettingsTap(),
  ];
  @override
  Widget build(BuildContext context) {
    final bool isDark = Provider.of<ThemeProvider>(context).isDark;

    return Scaffold(
      appBar: buildAppBar(),
      bottomNavigationBar: buildCurvedBottomNavBar(isDark),
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tapsList[currentTapIndex]
          .animate()
          .fadeIn(duration: const Duration(milliseconds: 350)),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/avatar.jpeg'),
          )),
      title:
          Text('Navya', style: AppTheme.lightTheme.primaryTextTheme.titleLarge),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_outlined),
          onPressed: () {
            // Add notification action here
          },
        ),
      ],
    );
  }

  CurvedNavigationBar buildCurvedBottomNavBar(bool isDark) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      color: isDark ? const Color(0xFF1C1C1C) : Colors.white,
      buttonBackgroundColor: AppColors.primaryColor,
      height: 60,
      animationDuration: const Duration(milliseconds: 300),
      items: const [
        Icon(Icons.home_outlined, size: 30),
        Icon(Icons.settings_outlined, size: 30),
      ],
      index: currentTapIndex,
      onTap: (index) {
        setState(() {
          currentTapIndex = index;
        });
      },
    );
  }

  Widget buildFab() {
    final tasksProvider = Provider.of<TasksProvider>(context);
    final bool isDisabled = tasksProvider.selectedDate
        .isBefore(DateTime.now().subtract(Duration(days: 1)));

    return FloatingActionButton(
      backgroundColor: isDisabled ? Colors.grey : AppColors.primaryColor,
      onPressed: isDisabled
          ? null
          : () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) {
                    return ButtomSheet();
                  });
            },
      child: const Icon(
        Icons.add,
        size: 30.0,
        color: Colors.white,
      ),
    ).animate().scale(
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }
}
