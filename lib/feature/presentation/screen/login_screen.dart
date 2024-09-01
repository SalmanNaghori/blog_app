import 'package:blog_app/core/constant/app_string.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/navigation_manager.dart';
import 'package:blog_app/feature/presentation/screen/sign_up_page.dart';
import 'package:blog_app/feature/presentation/widget/auth_text_field.dart';
import 'package:blog_app/feature/presentation/widget/title_widget.dart';
import 'package:flutter/material.dart';

import '../widget/auth_gradient_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TitleWidget(
                title: AppString.signIn,
              ),
              const SizedBox(
                height: 30,
              ),
              AuthTextField(
                hintText: AppString.email,
                controller: emailTextController,
              ),
              const SizedBox(
                height: 15,
              ),
              AuthTextField(
                hintText: AppString.password,
                controller: passwordTextController,
                isObscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              AuthGradientButton(buttonTitle: AppString.signIn,onPress: (){},),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  navigateToPage(const SignUpScreen());
                },
                child: RichText(
                  text: TextSpan(
                    text: "${AppString.dontHaveAccount} ",
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: AppString.signUp,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppPallete.gradient2,
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    disposeDataMember();
    super.dispose();
  }

  void disposeDataMember() {
    emailTextController.dispose();
    passwordTextController.dispose();
  }
}
