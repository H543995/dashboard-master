import 'package:dashboard/pages/component/progress.dart';
import 'package:dashboard/pages/function.dart';
import 'package:dashboard/pages/home/home_use.dart';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/pages/config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


class yes_bill extends StatefulWidget {
	final String cus_id;
	final String foo_id;
	final String det_id;
	final String foo_name;
	final String det_qty;
	final String det_price;
	final String det_regdate;
	final String use_name;


	yes_bill({this. cus_id,this.foo_id,this.det_id,this.foo_name,this.det_qty,
		this.det_price,this.det_regdate,this.use_name});
	@override
	_yes_billState createState() => _yes_billState();
}

class _yes_billState extends State<yes_bill> {
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
		if (

		myvalid) {
			isloading = true;
			load.add_loading();
			SharedPreferences sh = await SharedPreferences.getInstance();
			String use_id = sh.getString("use_id");
			String use_name = sh.getString("use_name");

			print(' cate nam epage 2 : ${widget.cus_id}');
			print(' cate nam epage 4 : ${widget.det_id}');

			var arr = {
				"use_id":"$use_id",
				"use_name":"$use_name",
				"cus_id": widget.cus_id,
				"foo_id": widget.foo_id,
				"det_id":widget.det_id,
				"foo_name":widget.foo_name,
				"det_qty":widget.det_qty,
				"det_price":widget.det_price,
				"det_regdate":widget.det_regdate,
				"no_desc": txtuse_name.text
			};

			bool res = await SaveData1(
					arr, "bill_use_ad/insert_ues_bill.php", context, () => Home_use(
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
		print(' cate nam epage 3 : ${widget.cus_id}');
		print(' cate nam epage 2 : ${widget.foo_id}');
		print(' cate nam epage 4 : ${widget.det_id}');
		print(' cate nam epage 4 : ${widget.foo_name}');

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
