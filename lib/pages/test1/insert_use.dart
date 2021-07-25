import 'package:dashboard/pages/category/category_data.dart';
import 'package:dashboard/pages/component/progress.dart';
import 'package:dashboard/pages/home/home_use.dart';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/pages/config.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../function.dart';

class insert_use extends StatefulWidget {
 final String cat_name;
  int use_id;


	insert_use({this. cat_name,this.use_id});
	@override
	_insert_useState createState() => _insert_useState();
}

class _insert_useState extends State<insert_use> {
	bool isloading = false;
	var _formKey = GlobalKey<FormState>();
	TextEditingController txtuse_name = new TextEditingController();
	TextEditingController txtuse_pwd = new TextEditingController();
	TextEditingController txtuse_mobile = new TextEditingController();


	saveData(context, LoadingControl load) async {
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
			print(' cate nam epage 2 : ${widget.cat_name}');
			var arr = {
				"cat_name": widget.cat_name,
				"use_name": txtuse_name.text,
				"use_mobile": txtuse_mobile.text,
				"use_pwd": txtuse_pwd.text
			};
			print(' cate nam epage 4 : ${widget.cat_name}');

			bool res = await SaveData(
					arr, "users/insert_user.php", context, () => Home_use(
				                          cat_name:widget.cat_name
			), "insert");

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
		print(' cate nam epage 3 : ${widget.cat_name}');
  }

	@override
	void dispose() {
		// TODO: implement dispose
		super.dispose();
		txtuse_name.dispose();
		txtuse_pwd.dispose();
		txtuse_mobile.dispose();
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
																	hintText: "اسم المحل",
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
