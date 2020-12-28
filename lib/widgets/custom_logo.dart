import 'package:buy_it_store/common/size_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image(
            height: Sizes.dimen_80.h,
            width: Sizes.dimen_80.w,
            fit: BoxFit.contain,
            image: AssetImage('images/icons/buyicon.png'),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            'Buy it',
            style: TextStyle(fontFamily: 'Pacifico', fontSize: 25),
          ),
        ],
      ),
    );
  }
}
