import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/models/user_data_model.dart';
import 'package:todo/common/app_images.dart';
import 'package:todo/common/widgets/custom_auth_text_field.dart';
import 'package:todo/common/app_colors.dart';
import 'package:todo/common/widgets/custom_elevated_button.dart';
import 'package:todo/providers/auth_provider.dart';
import 'package:todo/screens/auth/log_in_screen.dart';
import 'package:todo/screens/auth/validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const routeName = '/sign-up-screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              spacing: 4.0,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Image.asset(AppImages.logo, height: 200),
                SizedBox(height: 50),
                CustomAuthTextField(
                  prefixIcon: const Icon(
                    Icons.person_outline_rounded,
                    color: AppColors.textBlack,
                  ),
                  hintText: "Enter your Name",
                  keyboardType: TextInputType.name,
                  controller: _nameController,
                  validator: (p0) => nameValidator(p0),
                ),
                CustomAuthTextField(
                  prefixIcon: const Icon(
                    Icons.mail_outline_rounded,
                    color: AppColors.textBlack,
                  ),
                  hintText: "Enter your Email",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (p0) => emailValidator(p0),
                ),
                CustomAuthTextField(
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: AppColors.textBlack,
                  ),
                  hintText: "Enter Your Password",
                  controller: _passwordController,
                  obscureText: true,
                  validator: (p0) => passwordValidator(p0),
                ),
                SizedBox(height: 12),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: CustomElevatedButton(
                    text: "Sign Up",
                    isLoading: Provider.of<TodoAuthProvider>(context).loading,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Provider.of<TodoAuthProvider>(context, listen: false)
                            .signUp(UserDataModel(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                        ));
                      }
                      if (Provider.of<TodoAuthProvider>(context, listen: false)
                              .user !=
                          null) {
                        Navigator.of(context)
                            .pushReplacementNamed(LogInScreen.routeName);
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
                      "aleady have an account? ",
                      style: TextStyle(
                        color: AppColors.primaryTextLightColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LogInScreen.routeName);
                      },
                      child: const Text(
                        "Log In",
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
