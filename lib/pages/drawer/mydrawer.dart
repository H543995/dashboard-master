import 'package:dashboard/pages/account/login.dart';
import 'package:dashboard/pages/admin/Admins.dart';
import 'package:dashboard/pages/admin/acsept_bill_cus/read_acsept_bill_cus_1.dart';
import 'package:dashboard/pages/admin/admin_Bill/bill.dart';
import 'package:dashboard/pages/admin/chaing_yes_bill_ad/read_yes_bill_ad.dart';
import 'package:dashboard/pages/admin/login_manger.dart';
import 'package:dashboard/pages/config.dart';
import 'package:dashboard/pages/users/users.dart';
import 'package:flutter/material.dart';


class MyDrawer_admin extends StatefulWidget {
  @override
  _MyDrawer_adminState createState() => _MyDrawer_adminState();
}

class _MyDrawer_adminState extends State<MyDrawer_admin> {
  void logout(context) {
    prefs.remove(G_ad_id);
    prefs.remove(G_ad_name);
    prefs.remove(G_ad_mobile);
    prefs.remove(G_ad_image);

    prefs.clear();

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => new Login_manger()));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Container(
      child: Drawer(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  "حمزاوي",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                accountEmail: Text(
                  "hamza@gmail.com",
                  style: TextStyle(color: Colors.grey),
                ),
                currentAccountPicture: GestureDetector(
                  child: new CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
                decoration: BoxDecoration(color: Colors.grey[100]),
              ),
              Container(
                padding: EdgeInsets.only(right: 10.0, left: 10.0),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  Admins()));

                      },
                      child: ListTile(
                        title: Text(
                          "اضافه الادمن",
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                        leading: Icon(
                          Icons.home,
                          color: Colors.red,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 18.0,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[500],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10.0, left: 10.0),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new Users()));

                      },
                      child: ListTile(
                        title: Text(
                          "اضافه اصحاب المحلات",
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                        leading: Icon(
                          Icons.restaurant,
                          color: Colors.red,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 18.0,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[500],
                    ),
                  ],
                ),
              ),
              Theme(
                data: theme,
                child: ExpansionTile(
                  title: Text(
                    "حسابي",
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                  children: <Widget>[
//======================child account
                    Container(
                      padding: EdgeInsets.only(right: 10.0, left: 10.0),
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              /* Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => new MyProfile()));
                           */
                            },
                            child: ListTile(
                              title: Text(
                                "تغيير الاعدادات الشخصية",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0),
                              ),
                              leading: Icon(
                                Icons.settings,
                                color: Colors.red,
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 18.0,
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey[500],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10.0, left: 10.0),
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              /*  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          new ChangePassword()));
                           */
                            },
                            child: ListTile(
                              title: Text(
                                "تغيير كلمة المرور",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0),
                              ),
                              leading: Icon(
                                Icons.lock_open,
                                color: Colors.red,
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //======================end child account
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10.0, left: 10.0),
                child: Divider(
                  color: Colors.grey[500],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10.0, left: 10.0),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        /*  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new Favorite()));
                      */
                      },
                      child: ListTile(
                        title: Text(
                          "قائمة المأكولات",
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                        leading: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 18.0,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[500],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10.0, left: 10.0),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new Bill_ad()));

                      },
                      child: ListTile(
                        title: Text(
                          "طلبات الزبائن",
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                        leading: Icon(
                          Icons.history,
                          color: Colors.red,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 18.0,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[500],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10.0, left: 10.0),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new ues_bill_ad()));

                      },
                      child: ListTile(
                        title: Text(
                          "طلبات الموكده من اصحاب المحلات",
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                        leading: Icon(
                          Icons.history,
                          color: Colors.red,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 18.0,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[500],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10.0, left: 10.0),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new read_acsept_bill_cus_1()));

                      },
                      child: ListTile(
                        title: Text(
                          "طلبات الموكده من الزبائن",
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                        leading: Icon(
                          Icons.history,
                          color: Colors.red,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 18.0,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[500],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10.0, left: 10.0),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new Bill_ad()));

                      },
                      child: ListTile(
                        title: Text(
                          "طلبات الزبائن",
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                        leading: Icon(
                          Icons.history,
                          color: Colors.red,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 18.0,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[500],
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.only(right: 10.0, left: 10.0),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new Tracking()));*/
                      },
                      child: ListTile(
                        title: Text(
                          "تتبع الطلبيات",
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                        leading: Icon(
                          Icons.drive_eta,
                          color: Colors.red,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 18.0,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[500],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10.0, left: 10.0),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        logout(context);
                      },
                      child: ListTile(
                        title: Text(
                          "خروج",
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                        leading: Icon(
                          Icons.drive_eta,
                          color: Colors.red,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 18.0,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[500],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
