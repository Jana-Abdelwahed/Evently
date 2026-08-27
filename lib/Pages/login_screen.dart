import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:evently/Localization/app_localizations.dart';
import 'package:evently/firebase_utils.dart';
import 'package:evently/models/my_user.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/utils/evently_images.dart';
import 'package:evently/utils/evently_routes.dart';
import 'package:evently/widgets/elevated_button.dart';
import 'package:evently/widgets/text_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../utils/dimensions.dart';
import '../utils/snack_bar.dart';
import '../widgets/text_form_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
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
                      AppLocalizations.of(context)!.loginTitle,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  CustomTextFormField(
                    prefixIcon: Icon(Icons.mail_outline_rounded),
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
                    keyboardType: TextInputType.number,
                    isSuffixIcon: true,
                    obscureText: true,
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomTextButton(
                      text: AppLocalizations.of(context)!.forgetPassword,
                      textStyle: themeProvider.isDark
                          ? Theme.of(context).textTheme.labelSmall!.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: Theme.of(context).primaryColor,
                            )
                          : Theme.of(context).textTheme.displaySmall!.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: Theme.of(context).primaryColor,
                            ),
                      onPressed: onForgetPasswordClicked,
                    ),
                  ),
                  CustomElevatedButton(
                    buttonColor: Theme.of(context).primaryColor,
                    title: AppLocalizations.of(context)!.login,
                    onButtonClick: onLogin,
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.dontHaveAccount,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      CustomTextButton(
                        text: AppLocalizations.of(context)!.signUp,
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
                        onPressed: onSignUpClicked,
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
                    title: AppLocalizations.of(context)!.loginWithGoogle,
                    onButtonClick: onLoginWithGoogle,
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

  void onLogin() async {
    if (formKey.currentState?.validate() == true) {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        print("Login Successfully");

        var user = await FirebaseUtils.readUsersFromFireStore(
          credential.user?.uid ?? '',
        );
        if (user == null) {
          return;
        }
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);

        var eventProvider = Provider.of<EventProvider>(context, listen: false);
        eventProvider.changeSelectedIndex(0, userProvider.currentUser!.id);

        CustomSnackBar.show(
          context: context,
          title: "Woohoo!",
          message: "Logged in Successfully",
          contentType: ContentType.success,
          color: Theme.of(context).primaryColor,
        );

        Navigator.pushReplacementNamed(context, EventlyRoutes.homeScreen);

        print("user id : ${credential.user?.uid ?? ""}");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        } else if (e.code == "invalid-credential") {
          CustomSnackBar.show(
            context: context,
            title: "Ooops!",
            message: "Invalid Credentials",
            contentType: ContentType.failure,
          );
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void onSignUpClicked() {
    Navigator.pushNamed(context, EventlyRoutes.signupScreen);
  }

  void onForgetPasswordClicked() {
    Navigator.pushReplacementNamed(context, EventlyRoutes.forgetPassword);
  }

  Future<void> onLoginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      final String uid = userCredential.user?.uid ?? '';

      var user = await FirebaseUtils.readUsersFromFireStore(uid);
      if (user == null) {
        user = MyUser(
          id: uid,
          name: userCredential.user?.displayName ?? '',
          email: userCredential.user?.email ?? '',
        );
        await FirebaseUtils.addUserToFireStore(user);
      }

      if (!mounted) return;

      Provider.of<UserProvider>(context, listen: false).updateUser(user);
      Provider.of<EventProvider>(
        context,
        listen: false,
      ).changeSelectedIndex(0, user.id);

      CustomSnackBar.show(
        context: context,
        title: "Woohoo!",
        message: "Logged in Successfully",
        contentType: ContentType.success,
        color: Theme.of(context).primaryColor,
      );

      Navigator.pushReplacementNamed(context, EventlyRoutes.homeScreen);
    } catch (e) {
      print("Google Sign-In Error: $e");
    }
  }
}
