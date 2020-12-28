import 'package:buy_it_store/common/size_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottom extends StatelessWidget {
  final String bTitle;
  final String bNavigator;
  final BuildContext ctx;

  const CustomBottom({Key key, this.ctx ,this.bTitle, this.bNavigator}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Sizes.dimen_100.w, vertical: Sizes.dimen_20.h),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.dimen_4.h),
        ),
        child: Text(bTitle),
        onPressed: () {
          Navigator.of(ctx).pushNamed(bNavigator);
        },
      ),
    );
  }
}
