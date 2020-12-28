import 'package:buy_it_store/screens/user/user_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:buy_it_store/common/constants.dart';
import 'package:buy_it_store/common/size_constants.dart';
import 'package:buy_it_store/provider/admin_mode.dart';
import 'package:buy_it_store/provider/model_Hud.dart';
import 'package:buy_it_store/screens/admin/admin_home_screen.dart';
import 'package:buy_it_store/provider/auth.dart';
import 'package:buy_it_store/widgets/custom_logo.dart';
import 'package:buy_it_store/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'login-screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Map<String, String> userData = {'email': '', 'password': ''};

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String adminPassword = "Admin1234";

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(360, 720));
    return Scaffold(
      backgroundColor: Constants.kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHub>(context).isLoading,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              SizedBox(height: Sizes.dimen_120.h),
              CustomLogo(),
              SizedBox(height: Sizes.dimen_80.h),
              CustomTextField(
                hint: HintConstants.email,
                icon: Icons.ac_unit,
                onClick: (value) {
                  userData['email'] = value;
                },
              ),
              SizedBox(height: Sizes.dimen_20.h),
              CustomTextField(
                hint: HintConstants.password,
                icon: Icons.ac_unit,
                onClick: (value) {
                  userData['password'] = value;
                },
              ),
              SizedBox(height: Sizes.dimen_20.h),
              Builder(
                builder: (ctx) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_50.w),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Sizes.dimen_20.h)),
                    color: Colors.black,
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _validate(ctx);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: Sizes.dimen_20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_50.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(
                      onPressed: () {
                        Provider.of<AdminMode>(context, listen: false)
                            .changeAdminState(true);
                      },
                      child: Text(
                        "I am admin",
                        style: TextStyle(
                          color: Provider.of<AdminMode>(context).isAdmin
                              ? Colors.black
                              : Colors.red,
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Provider.of<AdminMode>(context, listen: false)
                            .changeAdminState(false);
                      },
                      child: Text(
                        "I am a user",
                        style: TextStyle(
                          color: Provider.of<AdminMode>(context).isAdmin
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    final modelhud = Provider.of<ModelHub>(context, listen: false);
    modelhud.changeState(true);
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      print(userData['email']);
      print(userData['password']);
      print(adminPassword);
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (userData['password'] == adminPassword) {
          try {
            await Provider.of<Auth>(context, listen: false)
                .signIn(userData['email'].trim(), userData['password'].trim());
            Navigator.of(context)
                .pushReplacementNamed(AdminHomeScreen.routeName);
            print("000000");
          } catch (e) {
            print("1111111");
            modelhud.changeState(false);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Something went wrong"),
            ));
          }
        } else {
          modelhud.changeState(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Something went wrong !'),
          ));
        }
      } else {
        try {
          await Provider.of<Auth>(context, listen: false)
              .signIn(userData['email'].trim(), userData['password'].trim());
          Navigator.of(context).pushReplacementNamed(UserHomeScreen.routeName);
        } catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(e.message),
          ));
        }
      }
    }
    modelhud.changeState(false);
  }
}
