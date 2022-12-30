import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:van_lines/models/User.dart';
import 'package:van_lines/screens/Authentication/Authenticate.dart';
import 'package:van_lines/screens/Authentication/Sign_up.dart';
import 'package:van_lines/screens/Home/home.dart';
import 'package:van_lines/screens/Verify_Email.dart';
import 'Authentication/Sign_in.dart';

class wrapper extends StatelessWidget {
      // const ({Key? key}) : super(key: key);

      @override
      Widget build(BuildContext context) {

        final user = Provider.of<UserFB?>(context);
        print(user);
        if (user == null){
          return Authenticate();
        } else {
          return Verify();
        }
      }
    }
