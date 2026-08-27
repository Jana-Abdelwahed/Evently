import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:evently/Localization/app_localizations.dart';
import 'package:evently/Pages/tabs/favorite/widgets/search_form_field.dart';
import 'package:evently/utils/evently_images.dart';
import 'package:evently/utils/snack_bar.dart';
import 'package:evently/widgets/elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../utils/dimensions.dart';
import '../utils/evently_colors.dart';
import '../utils/evently_routes.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var width = context.width;
    var height = context.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.01,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: height * 0.05,
                          maxWidth: width * 0.4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: themeProvider.isDark
                              ? Theme.of(context).cardColor
                              : EventlyColors.white,
                          border: BoxBorder.all(
                            color: themeProvider.isDark
                                ? Theme.of(context).dividerColor
                                : EventlyColors.whiteLightStroke,
                          ),
                        ),
                        child: IconButton(
                          highlightColor: EventlyColors.transparent,
                          iconSize: 20,
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              EventlyRoutes.loginScreen,
                            );
                          },
                          icon: Icon(Icons.arrow_back_ios_new_rounded),
                          color: themeProvider.isDark
                              ? EventlyColors.white
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.forgetPasswordTitle,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.03),
                  Image.asset(
                    themeProvider.isDark
                        ? EventlyImages.forgetPasswordNight
                        : EventlyImages.forgetPasswordLight,
                  ),
                  SizedBox(height: height * 0.03),
                  SearchFormField(
                    controller: emailController,
                    hintText: "Email",
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Please enter your email";
                      }
                      bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(text);
                      if (!emailValid) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height * 0.03),
                  isLoading
                      ? CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        )
                      : CustomElevatedButton(
                          title: AppLocalizations.of(context)!.resetPassword,
                          textStyle: Theme.of(context).textTheme.bodyMedium,
                          onButtonClick: onForgetPasswordClick,
                          buttonColor: Theme.of(context).primaryColor,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onForgetPasswordClick() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim(),
        );

        if (!mounted) return;

        CustomSnackBar.show(
          context: context,
          title: "Email Sent!",
          message: "Check your inbox for password reset instructions.",
          contentType: ContentType.success,
          color: Theme.of(context).primaryColor,
        );

        Navigator.pushReplacementNamed(context, EventlyRoutes.loginScreen);
      } on FirebaseAuthException catch (e) {
        if (!mounted) return;

        CustomSnackBar.show(
          context: context,
          title: "Error",
          message: e.message ?? "An error occurred while resetting password",
          contentType: ContentType.failure,
          color: EventlyColors.red,
        );
      } catch (e) {
        if (!mounted) return;

        CustomSnackBar.show(
          context: context,
          title: "Error",
          message: "Something went wrong. Please try again.",
          contentType: ContentType.failure,
          color: EventlyColors.red,
        );
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }
}
