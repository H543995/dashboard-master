import 'package:dashboard/pages/component/progress.dart';
import 'package:dashboard/pages/config.dart';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:dashboard/pages/test1/catger_insert_use.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/pages/account/login_data.dart';
import 'package:dashboard/pages/home/home_use.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class Login_use extends StatefulWidget {
  @override
  _Login_useState createState() => _Login_useState();
}

class _Login_useState extends State<Login_use> {
  bool isloading = false;
  TextEditingController txtmobile = new TextEditingController();
  TextEditingController txtpwd = new TextEditingController();
  void login(context, load) async {
    if (!await checkConnection()) {
      Toast.show("Not connected Internet", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
    if (txtmobile.text.isNotEmpty && txtpwd.text.isNotEmpty) {
      isloading = true;
      load.add_loading();
      bool res = await loginUsers(txtmobile.text, txtpwd.text, context);
      isloading = res;
      load.add_loading();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () => Navigator.of(context).pop()),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: Form(
                  child: ListView(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 35.0),
                        child: Text(
                          "سجل الدخول الى حسابك من هنا ",
                          style: TextStyle(fontSize: 25.0, color: Colors.red),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0)),
                        child: TextFormField(
                          controller: txtmobile,
                          decoration: InputDecoration(
                              hintText: "الموبايل", border: InputBorder.none),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "الرجاء ادخال الموبايل";
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0)),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                controller: txtpwd,
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: "كلمة المرور",
                                    border: InputBorder.none),
                                validator: (String value) {
                                  if (value.isEmpty || value.length < 6) {
                                    return "الرجاء ادخال كلمة المرور";
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Consumer<LoadingControl>(builder: (context, load, child) {
                        return isloading
                            ? circularProgress()
                            : MaterialButton(
                                onPressed: () {
                                  login(context, load);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    "دخول",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                  margin:
                                      EdgeInsets.only(bottom: 10.0, top: 30.0),
                                  padding: EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                          BorderRadius.circular(25.0)),
                                ));
                      }),
                    ],
                  ),
                )),
                Container(
                  alignment: Alignment.center,

                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => catger_insert_use(
                              )));
                    },
                    child: Text(
                      "اضافة محل  جديد",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  height: 40.0,
                  decoration: BoxDecoration(
                      color: Colors.red, borderRadius: BorderRadius.circular(40)),
                )
              ],
            ),
          ),
        ));
  }
}
