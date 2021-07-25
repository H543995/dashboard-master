import 'package:dashboard/pages/component/progress.dart';
import 'package:dashboard/pages/function.dart';
import 'package:dashboard/pages/home/home_admin.dart';
import 'package:dashboard/pages/home/home_use.dart';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/pages/config.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class acsept_bill_ad extends StatefulWidget {
  final String cus_id;
	final String use_id;

	final String use_name;
  final String foo_id;
  final String det_id;
  final String foo_name;
  final String det_qty;
  final String det_price;
  final String det_regdate;

  acsept_bill_ad(
      {this.cus_id,
				this.use_id,
				this.use_name,
      this.foo_id,
      this.det_id,
      this.foo_name,
      this.det_qty,
      this.det_price,
      this.det_regdate,
      });
  @override
  _acsept_bill_adState createState() => _acsept_bill_adState();
}

class _acsept_bill_adState extends State<acsept_bill_ad> {
  bool isloading = false;
  var _formKey = GlobalKey<FormState>();
  TextEditingController txtuse_name = new TextEditingController();

  saveData(context, LoadingControl load) async {
    if (!await checkConnection()) {
      Toast.show("Not connected Internet", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
    bool myvalid = _formKey.currentState.validate();
    load.add_loading();
    if (myvalid) {
      isloading = true;
      load.add_loading();


      print(' cate nam epage 2 : ${widget.cus_id}');
      print(' cate nam epage 4 : ${widget.det_id}');

      var arr = {
				"use_name": widget.use_name,
        "use_id": widget.use_id,
        "cus_id": widget.cus_id,
        "foo_id": widget.foo_id,
        "det_id": widget.det_id,
        "foo_name": widget.foo_name,
        "det_qty": widget.det_qty,
        "det_price": widget.det_price,
        "descr_ad": txtuse_name.text,
      };

      bool res = await SaveData1(arr, "acsept_bill_ad/insert_acsept_bill_ad"
          ".php",
          context, () => home_admin(), "insert");

      isloading = res;
      load.add_loading();
    } else {
      Toast.show("Please fill data", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    print(' cate nam epage 3 : ${widget.cus_id}');
    print(' cate nam epage 2 : ${widget.foo_id}');
    print(' cate nam epage 4 : ${widget.use_name}');
    print(' cate nam epage 4 : ${widget.use_id}');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    txtuse_name.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text("اضافة محل جديد"),
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
                                  hintText: "معلومات تاكيد الطلب",
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value.isEmpty) {
                                  print("enyter n");
                                }
                              },
                            ),
                          ),
                          isloading
                              ? circularProgress()
                              : MaterialButton(
                                  onPressed: () {
                                    saveData(context, load);
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
