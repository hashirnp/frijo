import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noviindus/core/constants/app_constants.dart';
import 'package:noviindus/injection.dart';
import 'package:noviindus/provider/auth_provider.dart';
import 'package:noviindus/routes/routnames.dart';
import 'package:noviindus/view/theme/constants.dart';
import 'package:noviindus/view/theme/text_styles.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _selectedCode = "+91"; // stateful dropdown value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, provider, _) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (provider.loginFailed && !provider.isAuth) {
                Fluttertoast.showToast(
                  msg: "Something went wrong, Please try again",
                );
                getIt<AuthProvider>().setLoginStatus(false);
              }
              if (provider.isAuth && mounted) {
                Navigator.pushReplacementNamed(context, '/home');
              }
            });

            if (provider.loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppConstants.primaryColor,
                ),
              );
            }

            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(10),
                    Text(
                      "Enter Your\nMobile Number",
                      style: t700_18.copyWith(
                        color: AppConstants.white,
                        fontSize: 24,
                      ),
                    ),
                    verticalSpace(10),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                      "Sed do eiusmod tempor.",
                      style: t400_14.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    verticalSpace(20),

                    /// Row with dropdown and phone number
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Dropdown
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.white.withAlpha(100),
                                    width: 1.2,
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _selectedCode,
                                    isExpanded: true,
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                    ),
                                    dropdownColor: Colors.grey[900],
                                    borderRadius: BorderRadius.circular(12),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    items: ["+91", "+92"].map((e) {
                                      return DropdownMenuItem<String>(
                                        value: e,
                                        child: Center(child: Text(e)),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        _selectedCode = val!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        horizontalSpace(15),

                        // TextField
                        Expanded(
                          flex: 5,
                          child: TextFormField(
                            controller: _mobileController,
                            keyboardType: TextInputType.phone,
                            style: t400_16.copyWith(color: AppConstants.white),
                            decoration: InputDecoration(
                              hintText: "Enter Mobile Number",
                              hintStyle: t400_16.copyWith(
                                color: Colors.white.withAlpha(150),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.white.withAlpha(100),
                                  width: 1.2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.white.withAlpha(100),
                                  width: 1.2,
                                ),
                              ),
                              // 👇 forces space for error text even if no error
                              errorStyle: const TextStyle(height: 1),
                            ),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter mobile number";
                              } else if (val.length != 10) {
                                return "Mobile number must be 10 digits";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(RouteNames.home);
          if (_formKey.currentState!.validate()) {
            context.read<AuthProvider>().login(
              userName: "$_selectedCode${_mobileController.text.trim()}",
              password: "", // no password here?
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: EdgeInsets.only(
            bottom: MediaQuery.sizeOf(context).height * 0.115,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            border: Border.all(color: Colors.white.withAlpha(100), width: 1.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Continue", style: t400_13.copyWith(color: Colors.white)),
              horizontalSpace(8),
              CircleAvatar(
                backgroundColor: AppConstants.red,
                radius: 16,
                child: Icon(CupertinoIcons.forward, color: AppConstants.white),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
