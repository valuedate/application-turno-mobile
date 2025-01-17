import 'package:turno/components/buttons/btn_txt_icon.dart';
import 'package:turno/components/form_inputs/check_box.dart';
import 'package:turno/components/form_inputs/text_input.dart';
import 'package:turno/components/popups/show_errors.dart';
import 'package:turno/exceptions/auth_exceptions.dart';
import 'package:turno/models/auth.dart';
import 'package:turno/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LoginPass extends StatefulWidget {
  final Function changePage;
  const LoginPass({required this.changePage, super.key});

  @override
  State<LoginPass> createState() => _LoginPassState();
}

class _LoginPassState extends State<LoginPass> {
  bool checkboxValue = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.welcome,
                  style: ThemeStyle.textStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 9),
                Text(
                  AppLocalizations.of(context)!.enter_details,
                  style: ThemeStyle.textStyle(color: Colors.white),
                ),
                CustomTextInput(
                  label: AppLocalizations.of(context)!.email,
                  placeholder: AppLocalizations.of(context)!.hint_email,
                  type: InputType.email,
                  controller: _emailController,
                ),
                CustomTextInput(
                  label: AppLocalizations.of(context)!.pass,
                  placeholder: AppLocalizations.of(context)!.hint_pass,
                  type: InputType.pass,
                  controller: _passwordController,
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomCheckbox(
                      value: checkboxValue,
                      text: AppLocalizations.of(context)!.save_data,
                      color: Colors.white,
                      onChange: (value) {
                        setState(() {
                          checkboxValue = value;
                        });
                      },
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Transform.translate(
                        offset: const Offset(0, 2),
                        child: Text(
                          AppLocalizations.of(context)!.forgot_password,
                          style: ThemeStyle.textStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            underLine: true,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                (_isLoading)
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Column(children: [
                        BtnTextIcon(
                          onClick: () {
                            _submit(context);
                          },
                          color: ThemeStyle.darkGray,
                          width: 220,
                          text: AppLocalizations.of(context)!.login,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 2),
                                  height: 1,
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              SizedBox(
                                height: 14,
                                width: 40,
                                child: Center(
                                    child: Text(
                                  AppLocalizations.of(context)!.or,
                                  style: ThemeStyle.textStyle(
                                      color: Colors.white, fontSize: 14),
                                )),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 2),
                                  height: 1,
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                            ],
                          ),
                        ),
                        BtnTextIcon(
                          onClick: () {
                            widget.changePage(1);
                          },
                          color: Colors.white,
                          textColor: ThemeStyle.primary,
                          width: 220,
                          text: AppLocalizations.of(context)!.enter_with_code,
                        ),
                      ]),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _submit(ctx) async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    _authData['email'] = _emailController.text;
    _authData['password'] = _passwordController.text;
    setState(() => _isLoading = true);
    Auth auth = Provider.of(context, listen: false);
    try {
      await auth.loginWithPass(
          _authData['email']!, _authData['password']!, checkboxValue, ctx);
    } on AuthException catch (error) {
      ShowErrors(
          errorTitle: AppLocalizations.of(ctx)!.error_occurred,
          msg: error.toString(),
          context: ctx,
          closeMsg: AppLocalizations.of(ctx)!.close);
    } catch (error) {
      ShowErrors(
          errorTitle: AppLocalizations.of(ctx)!.error_occurred,
          msg: AppLocalizations.of(ctx)!.unexpected_error,
          context: ctx,
          closeMsg: AppLocalizations.of(ctx)!.close);
    }
    setState(() => _isLoading = false);
  }
}
