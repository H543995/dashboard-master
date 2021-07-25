import 'package:dashboard/pages/account/login.dart';
import 'package:dashboard/pages/home/home_use.dart';
import 'package:dashboard/pages/home/home_admin.dart';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:dashboard/pages/start.dart';
import 'package:dashboard/pages/test1/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:dashboard/pages/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  G_use_id_val = prefs.getString(G_use_id);
  G_ad_id_val = prefs.getString(G_ad_id);
  runApp(Splash());
}

//343434
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<LoadingControl>(
            create: (context) => LoadingControl(),
          )
        ],
        child: MaterialApp(
            theme: ThemeData(fontFamily: 'GE_ar'),
            debugShowCheckedModeBanner: false,
            home: new SplashScreen(
              seconds: 5,
              routeName: "/",
              navigateAfterSeconds:
                  G_use_id_val == null ?  start() :  Home_use(),

              title: new Text(
                'مرحبا بكم في تطبيق ادارة متجرك',
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white),
              ),
              /*image: new Image.network(
          'https://flutter.io/images/catalog-widget-placeholder.png'),*/
              backgroundColor: primaryColor,
              styleTextUnderTheLoader: new TextStyle(),
              photoSize: 100.0,
              onClick: () => print("restaurant"),
              loaderColor: Colors.white,
            )));
  }
}
