import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hambolah_chat_app/core/constant/color.dart';
import 'package:hambolah_chat_app/core/helper/responsive.dart';
import 'package:hambolah_chat_app/logic/auth/forget_password_cubit/forget_password_cubit.dart';
import '../../../core/helper/snackbar.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_field.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordLoading) {
          isLoading = true;
        }
        if (state is ForgetPasswordSuccess) {
          isLoading = false;
          Navigator.pop(context);
          FocusScope.of(context).unfocus();
          customSnackBar(context, "Check your E-mail");
        }
        if (state is ForgetPasswordFailure) {
          isLoading = false;
          customSnackBar(context, "There was an Error please try agin later!");
          log(state.message);
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 19),
                width: 145,
                height: 5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(74),
                    color: MyColors.lightGrey),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Container(
                  padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: MediaQuery.viewInsetsOf(context).bottom,
                      top: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Forgot Password",
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: MyColors.white),
                      ),
                      SizedBox(height: 0.01729249 * ScreenSize.height), //15
                      const Text(
                        "Enter Your email for the verification processes, we will send a 4-digit code to your email.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: MyColors.lightGrey,
                          fontSize: 18,
                        ),
                      ),
                      CustomTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (data) {
                          email = data;
                        },
                        title: "E-mail",
                        titleTextStyle: const TextStyle(
                            color: MyColors.lightGrey,
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 0.0288208 * ScreenSize.height),
                      CustomButton(
                        title: isLoading == false ? "Send link" : null,
                        widget: isLoading == true
                            ? const CircularProgressIndicator()
                            : null,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            BlocProvider.of<ForgetPasswordCubit>(context)
                                .resetPassword(email: email!);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

void showForgetPasswordBottomSheet(BuildContext context) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(35), topLeft: Radius.circular(35))),
    backgroundColor: MyColors.darkGrey,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return const ForgetPassword();
    },
  );
}
