import 'package:dashboard/pages/admin/admin_data.dart';
import 'package:dashboard/pages/component/progress.dart';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/pages/config.dart';
import 'package:dashboard/pages/function.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class EditUsers extends StatefulWidget {
  int ad_index;
  adminData admin;

  EditUsers({this.ad_index, this.admin});
  @override
  _EditUsersState createState() => _EditUsersState();
}

class _EditUsersState extends State<EditUsers> {
  bool isloading = false;
  bool checkActive = false;
  var _formKey = GlobalKey<FormState>();
  TextEditingController txtuse_name = new TextEditingController();
  TextEditingController txtuse_pwd = new TextEditingController();
  TextEditingController txtuse_mobile = new TextEditingController();
  TextEditingController txtuse_email = new TextEditingController();

  updateUser(context, LoadingControl load) async {
    if (!await checkConnection()) {
      Toast.show("Not connected Internet", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
    bool myvalid = _formKey.currentState.validate();
    load.add_loading();
    if (txtuse_name.text.isNotEmpty &&
        txtuse_mobile.text.isNotEmpty &&
        txtuse_pwd.text.isNotEmpty &&
        myvalid) {
      isloading = true;
      load.add_loading();
      Map arr = {
        "ad_id": widget.admin.ad_id,
        "ad_name": txtuse_name.text,
        "ad_mobile": txtuse_mobile.text,
        "ad_pwd": txtuse_pwd.text,
        "ad_validity": checkActive ? "1" : "0",
        "ad_email": txtuse_email.text
      };
      bool res =
          await SaveData(arr, "admin/update_admin.php", context, null, "updat"
              "e");
      adminList[widget.ad_index].ad_name = txtuse_name.text;
      adminList[widget.ad_index].ad_mobile = txtuse_name.text;
      adminList[widget.ad_index].ad_pwd = txtuse_name.text;
      adminList[widget.ad_index].ad_email = txtuse_name.text;
      adminList[widget.ad_index].ad_validity = checkActive;

      isloading = res;
      load.add_loading();
    } else {
      Toast.show("Please fill data", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    txtuse_name.dispose();
    txtuse_pwd.dispose();
    txtuse_mobile.dispose();
    txtuse_email.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    txtuse_mobile.text = widget.admin.ad_mobile;
    txtuse_name.text = widget.admin.ad_name;
    txtuse_email.text = widget.admin.ad_email;
    txtuse_pwd.text = widget.admin.ad_pwd;
    if (widget.admin.ad_validity == "1") {
      checkActive = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text("اضافة مستخدم جديد"),
          centerTitle: true,
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.only(top: 30),
            child: Column(
              children: <Widget>[
                Consumer<LoadingControl>(builder: (context, load, child) {
                  return Expanded(
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.0)),
                            child: TextFormField(
                              controller: txtuse_name,
                              decoration: InputDecoration(
                                  hintText: "اسم المستخدم",
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value.isEmpty) {
                                  print("enyter name");
                                  return "الرجاء ادخال الاسم ";
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
                            child: TextFormField(
                              controller: txtuse_mobile,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: "الموبايل",
                                  border: InputBorder.none),
                              validator: (String value) {
                                if (value.isEmpty || value.length < 5) {
                                  return "الرجاء ادخال رقم الموبايل";
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
                            child: TextFormField(
                              controller: txtuse_pwd,
                              decoration: InputDecoration(
                                  hintText: "الباسورد",
                                  border: InputBorder.none),
                              validator: (String value) {
                                if (value.isEmpty || value.length < 5) {
                                  return "الرجاء ادخال الباسورد ";
                                }
                              },
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(bottom: 10.0),
                              padding: EdgeInsets.only(left: 20.0, right: 20.0),
                              child: Checkbox(
                                  value: checkActive,
                                  onChanged: (newValue) {
                                    setState(() {
                                      checkActive = newValue;
                                    });
                                  })),
                          Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.0)),
                            child: TextFormField(
                              controller: txtuse_email,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                  hintText: "البريد الالكتروني",
                                  border: InputBorder.none),
                            ),
                          ),
                          isloading
                              ? circularProgress()
                              : MaterialButton(
                                  onPressed: () {
                                    updateUser(context, load);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      "حفظ",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20.0),
                                    ),
                                    margin: EdgeInsets.only(
                                        bottom: 10.0, top: 30.0),
                                    padding: EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(25.0)),
                                  )),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ));
  }
}
