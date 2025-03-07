import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/common/app_images.dart';
import 'package:todo/common/widgets/custom_auth_text_field.dart';
import 'package:todo/common/app_colors.dart';
import 'package:todo/common/widgets/custom_elevated_button.dart';
import 'package:todo/providers/auth_provider.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/screens/auth/sign_up_screen.dart';
import 'package:todo/screens/auth/validators.dart';
import 'package:todo/screens/home/home_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});
  static const routeName = '/log-in-screen';

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
              spacing: 4.0,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Image.asset(AppImages.logo, height: 200),
                SizedBox(height: 50),
                CustomAuthTextField(
                  controller: _emailController,
                  prefixIcon: const Icon(
                    Icons.mail_outline_rounded,
                    color: AppColors.textBlack,
                  ),
                  hintText: "Enter your Email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (p0) => emailValidator(p0),
                ),
                CustomAuthTextField(
                  controller: _passwordController,
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: AppColors.textBlack,
                  ),
                  hintText: "Enter Your Password",
                  obscureText: true,
                  validator: (p0) => passwordValidator(p0),
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: CustomElevatedButton(
                    isLoading: Provider.of<TodoAuthProvider>(context).loading,
                    text: "Log In",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Store context and providers before async operation
                        final navigator = Navigator.of(context);
                        final authProvider = Provider.of<TodoAuthProvider>(
                            context,
                            listen: false);
                        final tasksProvider =
                            Provider.of<TasksProvider>(context, listen: false);

                        // Perform async operations
                        final success = await authProvider.login(
                            _emailController.text, _passwordController.text);

                        // Check if widget is still mounted before continuing
                        // if (!mounted) return;

                        if (success && mounted) {
                          await tasksProvider.getTasksByDate();
                          if (mounted) {
                            navigator
                                .pushReplacementNamed(HomeScreen.routeName);
                          }
                        }

                        await tasksProvider.getTasksByDate();

                        // Navigate only if still mounted
                        if (!mounted) return;
                        navigator.pushReplacementNamed(HomeScreen.routeName);
                      }
                    },
                    paddingHorizontal: 18,
                    paddingVertical: 18,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: AppColors.primaryTextLightColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(SignUpScreen.routeName);
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 12),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.textGrayColor,
                        thickness: 1,
                        indent: 120,
                        endIndent: 8,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Or",
                        style: TextStyle(
                          color: AppColors.textGrayColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.textGrayColor,
                        thickness: 1,
                        indent: 8,
                        endIndent: 120,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.facebook_rounded,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.apple_rounded,
                        )),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
