import 'package:flutter/material.dart';
import 'package:todo/common/app_images.dart';
import 'package:todo/common/widgets/custom_auth_text_field.dart';
import 'package:todo/common/app_colors.dart';
import 'package:todo/common/widgets/custom_elevated_button.dart';
import 'package:todo/screens/auth/sign_up_screen.dart';
import 'package:todo/screens/auth/validators.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});
  static const routeName = '/log-in-screen';

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
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
                  text: "Log In",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("validated");
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
                      Navigator.of(context).pushReplacementNamed(SignUpScreen.routeName);
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
    );
  }
}
