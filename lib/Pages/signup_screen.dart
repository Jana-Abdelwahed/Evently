import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:evently/Localization/app_localizations.dart';
import 'package:evently/firebase_utils.dart';
import 'package:evently/models/my_user.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/utils/evently_images.dart';
import 'package:evently/utils/evently_routes.dart';
import 'package:evently/utils/snack_bar.dart';
import 'package:evently/widgets/elevated_button.dart';
import 'package:evently/widgets/text_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../providers/event_provider.dart';
import '../providers/user_provider.dart';
import '../utils/dimensions.dart';
import '../widgets/text_form_field.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(EventlyImages.evently),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.02),
                    child: Text(
                      AppLocalizations.of(context)!.createYourAccount,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  CustomTextFormField(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    hintText: AppLocalizations.of(context)!.enterName,
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    prefixIcon: Icon(Icons.email_outlined),
                    hintText: AppLocalizations.of(context)!.enterEmail,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Please enter your email";
                      }
                      final bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(emailController.text);
                      if (!emailValid) {
                        return "Please enter a Valid Email";
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                    hintText: AppLocalizations.of(context)!.enterPassword,
                    isSuffixIcon: true,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    controller: passwordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Please enter your password";
                      }
                      if (text.length < 6) {
                        return "Password Should be greater than 6 numbers";
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                    hintText: AppLocalizations.of(context)!.enterPassword,
                    isSuffixIcon: true,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    controller: rePasswordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "Please enter your password";
                      }
                      if (text != passwordController.text) {
                        return "Password doesn't match";
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: height * 0.04,
                      bottom: height * 0.02,
                    ),
                    child: CustomElevatedButton(
                      buttonColor: Theme.of(context).primaryColor,
                      title: AppLocalizations.of(context)!.signUp,
                      onButtonClick: onSignUp,
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.alreadyHaveAccount,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      CustomTextButton(
                        onPressed: onLoginClicked,
                        text: AppLocalizations.of(context)!.login,
                        textStyle: themeProvider.isDark
                            ? Theme.of(context).textTheme.labelSmall!.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: Theme.of(context).primaryColor,
                              )
                            : Theme.of(
                                context,
                              ).textTheme.displaySmall!.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: Theme.of(context).primaryColor,
                              ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.02),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            height: height * 0.01,
                            color: Theme.of(context).dividerColor,
                            endIndent: width * 0.04,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.or,
                          style: themeProvider.isDark
                              ? Theme.of(context).textTheme.displayMedium
                              : Theme.of(context).textTheme.labelMedium,
                        ),
                        Expanded(
                          child: Divider(
                            height: height * 0.01,
                            thickness: 1,
                            color: Theme.of(context).dividerColor,
                            indent: width * 0.04,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomElevatedButton(
                    isLogo: true,
                    title: AppLocalizations.of(context)!.signUpWithGoogle,
                    onButtonClick: onSignUpWithGoogle,
                    textStyle: themeProvider.isDark
                        ? Theme.of(context).textTheme.displayMedium
                        : Theme.of(context).textTheme.labelMedium,
                    buttonColor: Theme.of(context).cardColor,
                    isBorder: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSignUp() async {
    if (formKey.currentState?.validate() == true) {
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        print("Signed Up Successfully");
        MyUser myUser = MyUser(
          id: credential.user?.uid ?? '',
          name: nameController.text,
          email: emailController.text,
        );

        await FirebaseUtils.addUserToFireStore(myUser);

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(myUser);

        var eventProvider = Provider.of<EventProvider>(context, listen: false);
        eventProvider.changeSelectedIndex(0, userProvider.currentUser!.id);

        CustomSnackBar.show(
          context: context,
          title: "Yay!",
          message: "Signed Up Successfully",
          contentType: ContentType.success,
          color: Theme.of(context).primaryColor,
        );

        Navigator.pushReplacementNamed(context, EventlyRoutes.homeScreen);

        print("user id : ${credential.user?.uid ?? ""}");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          CustomSnackBar.show(
            context: context,
            title: "Oops!",
            message: "The account already exists for that email.",
            contentType: ContentType.failure,
          );
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void onLoginClicked() {
    Navigator.pushReplacementNamed(context, EventlyRoutes.loginScreen);
  }

  Future<void> onSignUpWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();

      await googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
    } catch (e) {
      print("Google Sign-In Error: $e");
    }
  }
}
