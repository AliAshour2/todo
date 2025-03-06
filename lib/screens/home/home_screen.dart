import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/common/app_theme.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/ui/taps/settings/settings_tap.dart';
import 'package:todo/ui/taps/tasks/list_tap.dart';
import 'package:todo/ui/widgets/buttom_sheet.dart';

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
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      bottomNavigationBar: buildBottomNavBar(),
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tapsList[currentTapIndex],
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

  BottomAppBar buildBottomNavBar() {
    return BottomAppBar(
      padding: EdgeInsets.zero,
      notchMargin: 10.0,
      shape: const CircularNotchedRectangle(),
      clipBehavior: Clip.hardEdge,
      child: BottomNavigationBar(
        currentIndex: currentTapIndex,
        onTap: (value) {
          setState(() {
            currentTapIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  FloatingActionButton buildFab() {
    return FloatingActionButton(
      backgroundColor: Provider.of<TasksProvider>(context)
              .selectedDate
              .isBefore(DateTime.now().subtract(Duration(days: 1)))
          ? Colors.grey
          : null,
      onPressed: Provider.of<TasksProvider>(context)
              .selectedDate
              .isBefore(DateTime.now().subtract(Duration(days: 1)))
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
      ),
    );
  }
}
