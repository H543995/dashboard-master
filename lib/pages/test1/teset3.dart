import 'dart:ui';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:dashboard/tse_bill/no_bill.dart';
import 'package:dashboard/tse_bill/yes_bill.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config.dart';
import '../function.dart';

import 'detail_billData.dart';

List<DetailBillData> billList = null;
int sum = 0;

class DetailBill extends StatefulWidget {
	final   String use_id;
	final String bil_id;
	final String det_regdate;
	DetailBill({this.bil_id, this.det_regdate, this. use_id});
	@override
	_BillState createState() => _BillState();
}

class _BillState extends State<DetailBill> {
	ScrollController myScroll;
	GlobalKey<RefreshIndicatorState> refreshKey;
	int i = 0;
	bool loadingList = false;

	void getDatabill(int count, String strSearch) async {
		loadingList = true;
		setState(() {});
		List arr = await getData_bill(count, 20, "bill/readdetail_bill_3.php",
				strSearch,
				"bil_id=${widget.bil_id}&");
		for (int i = 0; i < arr.length; i++) {
			billList.add(new DetailBillData(
				det_id: arr[i]["det_id"],
				use_id: arr[i]["use_id"],
				cus_id: arr[i]["cus_id"],
				foo_id: arr[i]["foo_id"],
				foo_name: arr[i]["foo_name"],
				foo_image: arr[i]["foo_image"],
				det_note: arr[i]["det_note"],
				det_price: arr[i]["det_price"],
				det_qty: arr[i]["det_qty"],
				det_regdate: arr[i]["det_regdate"],
			));
			sum += int.parse(arr[i]["det_price"]) * int.parse(arr[i]["det_qty"]);
		}
		loadingList = false;
		setState(() {});
	}

	@override
	void dispose() {
		// TODO: implement dispose
		super.dispose();
		myScroll.dispose();
		billList.clear();
	}

	@override
	void initState() {
		// TODO: implement initState
		super.initState();
		sum = 0;
		_appBarTitle =
		new Text("تفاصيل الطلبية", style: TextStyle(color: Colors.black));
		billList = new List<DetailBillData>();
		myScroll = new ScrollController();
		refreshKey = GlobalKey<RefreshIndicatorState>();
		getDatabill(0, "");

		myScroll.addListener(() {
			if (myScroll.position.pixels == myScroll.position.maxScrollExtent) {
				i += 20;
				getDatabill(i, "");
				print("scroll");
			}
		});
	}

	Icon _searchIcon = new Icon(
		Icons.search,
		color: Colors.black,
	);
	Widget _appBarTitle;

	@override
	Widget build(BuildContext context) {
		var myProvider = Provider.of<LoadingControl>(context);
		return Container(
			child: Scaffold(
					appBar: AppBar(
						title: _appBarTitle,
						backgroundColor: Colors.white,
						leading: IconButton(
								icon: Icon(
									Icons.arrow_back_ios,
									color: Colors.black,
								),
								onPressed: () {
									Navigator.of(context).pop();
								}),
						centerTitle: true,
					),
					body: ListView(
						children: [
							Container(
								height: 130,
								padding: EdgeInsets.all(10),
								child: Column(
									mainAxisAlignment: MainAxisAlignment.start,
									crossAxisAlignment: CrossAxisAlignment.end,
									children: [
										Text("رقم الفاتورة" + " " + widget.bil_id,
												style: TextStyle(fontFamily: "arial", fontSize: 16)),
										Text("تاريخ الفاتورة" + " " + widget.det_regdate,
												style: TextStyle(fontFamily: "arial", fontSize: 16)),
										Text("اجمالي الفاتورة" + " " + sum.toString(),
												style: TextStyle(fontFamily: "arial", fontSize: 16)),
									],
								),
							),
							Container(
								height: MediaQuery.of(context).size.height - 120,
								child: RefreshIndicator(
									onRefresh: () async {
										i = 0;
										billList.clear();
										await getDatabill(0, "");
									},
									key: refreshKey,
									child: ListView.builder(
										controller: myScroll,
										itemCount: billList.length,
										itemBuilder: (context, index) {
											return SingleDetailBill(
												bil_index: index,
												bill: billList[index],
													bil_id_ad:widget.bil_id,
												bil_foo_name_ad:widget.bil_id,

											);
										},
									),
								),
							),
						],
					)),
		);
	}
}

class SingleDetailBill extends StatefulWidget {
String bil_id_ad;
String bil_foo_name_ad;

	int bil_index;
	DetailBillData bill;
	SingleDetailBill({this.bil_id_ad,this.bil_foo_name_ad,this.bil_index,  this.bill});

  @override
  _SingleDetailBillState createState() => _SingleDetailBillState();
}

class _SingleDetailBillState extends State<SingleDetailBill> {
	bool isloadingFav = false;

	@override
	Widget build(BuildContext context) {
		return GestureDetector(
			onTap: () {},
			child: Card(
				child: Column(
						children: [

				Container(
				  	padding: EdgeInsets.all(10),
				  	child: Row(
				  		mainAxisAlignment: MainAxisAlignment.spaceBetween,
				  		children: [
				  			Row(
				  				children: [
				  					new Text(
				  							"الاجمالي :" +
				  									(int.parse(widget.bill.det_qty) *
				  											int.parse(widget.bill.det_price))
				  											.toString(),
				  							style: TextStyle(fontFamily: "arial", fontSize: 16)),
				  					new Text("      "),
				  					new Text("السعر : " + widget.bill.det_price,
				  							style: TextStyle(
				  									fontFamily: "arial",
				  									color: Colors.red,
				  									fontSize: 16)),
				  					new Text(" "),
				  					new Text("الكمية :" + widget.bill.det_qty,
				  							style: TextStyle(
				  									fontFamily: "arial",
				  									color: Colors.red,
				  									fontSize: 16)),
				  					new Text(" "),
				  				],
				  			),
				  			new Text(
				  				widget.bill.foo_name,
				  			),
				  		],
				  	),

				  ),
							Padding(
							  padding:  EdgeInsets.only(top: 40),
							  child: Container(

							  	child: Row(

							  		mainAxisAlignment: MainAxisAlignment.spaceBetween,
							  		children: [
							  			Container(
							  				alignment: Alignment.center,
							  				height: 30,
							  				width: 182,
							  				color: Colors.pink,
							  				child: GestureDetector(
							  					onTap: () {
							  						Navigator.push(
							  								context,
							  								MaterialPageRoute(
							  										builder: (context) => no_bill(
							  											cus_id: widget.bill.cus_id,
							  											foo_id:widget.bill.foo_id,
							  											det_id:widget.bill.det_id,
																			foo_name:widget.bill.foo_name,

							  										)));
							  					},
							  					child: Text("لايوجد"),
							  				),
							  			),

							  			Container(
							  				alignment: Alignment.center,
							  				height: 30,
							  				width: 170,
							  				color: Colors.green,
							  				child: GestureDetector(
													onTap: () {
														Navigator.push(
																context,
																MaterialPageRoute(
																		builder: (context) => yes_bill(
																				use_name: widget.bill.use_name,
																			cus_id: widget.bill.cus_id,
																			foo_id:widget.bill.foo_id,
																			det_id:widget.bill.det_id,
																			foo_name:widget.bill.foo_name,
																				det_qty:widget.bill.det_qty,
																				det_price:widget.bill.det_price,
																				det_regdate:widget.bill.det_regdate

																		)));
													},							  					child: Text("موافق"),
							  				),
							  			),
							  		],
							  	),
							  ),
							)
			]
				),
			),
		);
	}
}
