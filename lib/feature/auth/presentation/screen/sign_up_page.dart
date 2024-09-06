import 'package:blog_app/core/constant/app_string.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/navigation_manager.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/feature/auth/presentation/screen/login_screen.dart';
import 'package:blog_app/feature/auth/presentation/widget/auth_text_field.dart';
import 'package:blog_app/feature/auth/presentation/widget/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/auth_gradient_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              // EasyLoading.show();
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const TitleWidget(
                    title: AppString.signUp,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthTextField(
                    hintText: AppString.name,
                    controller: nameTextController,
                  ),
                  const SizedBox(
                    height: 15,
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
                  AuthGradientButton(
                    buttonTitle: AppString.signUp,
                    onPress: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(AuthSignUp(
                              name: nameTextController.text.trim(),
                              email: emailTextController.text.trim(),
                              password: passwordTextController.text.trim(),
                            ));
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateToPageAndRemoveAllPages(const LoginScreen());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "${AppString.alreadyHaveAccount} ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: AppString.signInLogin,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AppPalette.gradient2,
                                  fontWeight: FontWeight.bold,
                                ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
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
    nameTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
  }
}
