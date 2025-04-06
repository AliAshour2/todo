import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/common/app_colors.dart';
import 'package:todo/providers/auth_provider.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/providers/theme_provider.dart';
import 'package:todo/screens/auth/sign_up_screen.dart';

class SettingsTap extends StatefulWidget {
  const SettingsTap({super.key});

  @override
  State<SettingsTap> createState() => _SettingsTapState();
}

class _SettingsTapState extends State<SettingsTap>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_fadeController);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDark;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // App Bar
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Settings",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).textTheme.titleLarge?.color,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Customize your app experience",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textGrayColor,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Settings List
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section title
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 16),
                    child: Text(
                      "Appearance",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),

                  // Theme Setting
                  SettingsCard(
                    icon: Icons.dark_mode_outlined,
                    title: "Dark Mode",
                    subtitle: "Switch between light and dark themes",
                    trailing: Switch(
                      value: isDark,
                      activeColor: AppColors.primaryColor,
                      onChanged: (value) {
                        themeProvider.changeThemeMode(
                          value ? ThemeMode.dark : ThemeMode.light,
                        );
                      },
                    ),
                    onTap: () {
                      themeProvider.changeThemeMode(
                        isDark ? ThemeMode.light : ThemeMode.dark,
                      );
                    },
                    delay: 0,
                  ),

                  const SizedBox(height: 24),

                  // Section title
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 16),
                    child: Text(
                      "Language & Region",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),

                  // Language Selection
                  SettingsCard(
                    icon: Icons.language_outlined,
                    title: "Language",
                    subtitle: "Select your preferred language",
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "English",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textGrayColor,
                                  ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: AppColors.textGrayColor,
                        ),
                      ],
                    ),
                    onTap: () {
                      _showLanguageDialog(context);
                    },
                    delay: 100,
                  ),

                  const SizedBox(height: 24),

                  // Section title
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 16),
                    child: Text(
                      "Account",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),

                  // About Option
                  SettingsCard(
                    icon: Icons.info_outline,
                    title: "About",
                    subtitle: "App information and credits",
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColors.textGrayColor,
                    ),
                    onTap: () {
                      _showAboutDialog(context);
                    },
                    delay: 200,
                  ),

                  const SizedBox(height: 16),

                  // Logout Button
                  SettingsCard(
                    icon: Icons.exit_to_app,
                    title: "Log Out",
                    subtitle: "Sign out from your account",
                    isDestructive: true,
                    onTap: () {
                      _showLogoutConfirmationDialog(context);
                    },
                    delay: 300,
                  ),

                  // App Version
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 8),
                    child: Center(
                      child: Text(
                        "Version 1.0.0",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textGrayColor,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Select Language",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption(context, "English", isSelected: true),
              _buildLanguageOption(context, "Spanish"),
              _buildLanguageOption(context, "French"),
              _buildLanguageOption(context, "German"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Confirm"),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(BuildContext context, String language,
      {bool isSelected = false}) {
    return ListTile(
      title: Text(language),
      trailing:
          isSelected ? Icon(Icons.check, color: AppColors.primaryColor) : null,
      onTap: () {
        Navigator.pop(context);
        // Implement language change logic here
      },
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "About Todo App",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                child: Icon(
                  Icons.check_circle_outline,
                  size: 40,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Todo App",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                "A simple and elegant todo app to help you stay organized and productive.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                "© 2023 Todo App",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        );
      },
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Log Out",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Text(
            "Are you sure you want to log out?",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.redColor,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
                Provider.of<TodoAuthProvider>(context, listen: false).logout();
                Provider.of<TasksProvider>(context, listen: false)
                    .tasks
                    .clear();
                Navigator.popAndPushNamed(context, SignUpScreen.routeName);
              },
              child: Text("Log Out"),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        );
      },
    );
  }
}

class SettingsCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback onTap;
  final bool isDestructive;
  final int delay;

  const SettingsCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    required this.onTap,
    this.isDestructive = false,
    required this.delay,
  }) : super(key: key);

  @override
  State<SettingsCard> createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
            begin: const Offset(0.2, 0), end: const Offset(0, 0))
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    // Delayed animation start
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        setState(() {
          _visible = true;
        });
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) {
      return const SizedBox.shrink();
    }

    final isDark = Provider.of<ThemeProvider>(context).isDark;

    return FadeTransition(
      opacity: _opacityAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Card(
          elevation: 0,
          color: widget.isDestructive
              ? AppColors.redColor.withOpacity(0.1)
              : isDark
                  ? const Color(0xFF202020)
                  : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: widget.isDestructive
                  ? AppColors.redColor.withOpacity(0.3)
                  : isDark
                      ? Colors.grey.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: widget.isDestructive
                          ? AppColors.redColor.withOpacity(0.1)
                          : AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      widget.icon,
                      color: widget.isDestructive
                          ? AppColors.redColor
                          : AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: widget.isDestructive
                                        ? AppColors.redColor
                                        : Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.color,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.subtitle,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.textGrayColor,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.trailing != null) widget.trailing!,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
