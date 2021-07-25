import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard/pages/admin/chaing_yes_bill_ad/acsept_bill_ad.dart';
import 'package:dashboard/pages/admin/chaing_yes_bill_ad/yes_bill_Data.dart';
import 'package:dashboard/pages/config.dart';
import 'package:dashboard/pages/function.dart';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<yes_bill_Data> billList = null;
int sum = 0;

class read_acsept_bill_cus_2 extends StatefulWidget {
	final String det_id;
	final String det_regdate;
	read_acsept_bill_cus_2({this.det_id, this.det_regdate});
	@override
	_BillState createState() => _BillState();
}

class _BillState extends State<read_acsept_bill_cus_2> {
	ScrollController myScroll;
	GlobalKey<RefreshIndicatorState> refreshKey;
	int i = 0;
	bool loadingList = false;

	void getDatabill(int count, String strSearch) async {
		loadingList = true;
		setState(() {});
		List arr = await getData2(count, 20, "acsept_bill_cus/read_acsept_bill_cus.php",
				strSearch,
				"bil_id=${widget.det_id}&");
		for (int i = 0; i < arr.length; i++) {
			billList.add(new yes_bill_Data(
				det_id: arr[i]["det_id"],
				cus_id: arr[i]["cus_id"],
				foo_id: arr[i]["foo_id"],
				foo_name: arr[i]["foo_name"],
				det_price: arr[i]["det_price"],
				det_qty: arr[i]["det_qty"],
				det_regdate: arr[i]["det_regdate"],
				use_name: arr[i]["use_name"],
				mobile_cus: arr[i]["mobile_cus"],
				loct_cus: arr[i]["loct_cus"],
				foo_thumbnail: arr[i]["foo_thumbnail"],
				foo_image: arr[i]["foo_image"],
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
		new Text("تفاصيل ارسال الطلب ", style: TextStyle(color: Colors.black));
		billList = new List<yes_bill_Data>();
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

										Text("رقم الفاتورة" + " " + widget.det_id,
												style: TextStyle(fontFamily: "arial", fontSize: 16)),
										Text("تاريخ الفاتورة" + " " + widget.det_regdate,
												style: TextStyle(fontFamily: "arial", fontSize: 16)),
										Text("اجمالي الفاتورة" + " " + sum.toString(),
												style: TextStyle(fontFamily: "arial", fontSize: 16)),
									],
								),
							),
							Container(
								height: MediaQuery.of(context).size.height - 140,
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
												DetailBill: billList[index],

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

class SingleDetailBill extends StatelessWidget {

	int bil_index;
	yes_bill_Data DetailBill;
	SingleDetailBill({this.bil_index,  this.DetailBill});


	bool isloadingFav = false;

	@override
	Widget build(BuildContext context) {
		return GestureDetector(
			onTap: () {},
			child: Card(
				child: Column(
						children: [

				Container(
				  	padding: EdgeInsets.all(1),
				  	child:
				  			Row(
				  				children: [
				  					new Text(
				  							"الاجمالي :" +
				  									(int.parse(DetailBill.det_qty) *
				  											int.parse(DetailBill.det_price))
				  											.toString(),
				  							style: TextStyle(fontFamily: "arial", fontSize: 16)),
				  					new Text("      "),
				  					new Text("السعر : " + DetailBill.det_price,
				  							style: TextStyle(
				  									fontFamily: "arial",
				  									color: Colors.red,
				  									fontSize: 16)),
				  					new Text(" "),
				  					new Text("الكمية :" + DetailBill.det_qty,
				  							style: TextStyle(
				  									fontFamily: "arial",
				  									color: Colors.red,
				  									fontSize: 16)),
				  					new Text(" "),

										    Text("اسم المنتج :" + DetailBill.foo_name),
				  				],
				  			),




				  ),
							Column(
									children: [
							   Container(
							  	child: Text("رقم الزبون لكي يتم التوصيل :" +DetailBill
											.loct_cus,style:
							  	TextStyle(
							  			fontFamily: "arial",
							  			color: Colors.red,
							  			fontSize: 16)),
							  ),Container(
											child: Text("موقع الزبون  :" +DetailBill.mobile_cus,style:
											TextStyle(
													fontFamily: "arial",
													color: Colors.red,
													fontSize: 16)),
										),


		]
							),

				Card(

								child:Column(
									children: [
										 Container(
											margin: EdgeInsets.only(right: 5.0),
											height: 100.0,
											width: 100.0,

											child: CachedNetworkImage(
												imageUrl: imagesCus +
														(DetailBill.foo_thumbnail == null || DetailBill.foo_thumbnail == ""
																? "def.png"
																: DetailBill.foo_thumbnail),
												imageBuilder: (context, imageProvider) => Container(
													width: 80.0,
													height: 80.0,
													child: Text("صوره السند"),
													decoration: BoxDecoration(
														shape: BoxShape.circle,
														image: DecorationImage(
																image: imageProvider, fit: BoxFit.cover),
													),
												),
												placeholder: (context, url) => CircularProgressIndicator(),
												errorWidget: (context, url, error) => Icon(Icons.error),
											),
										),
									],
								)
							),
							Padding(
								padding:  EdgeInsets.only(top: 40),
								child: Container(

									child: Row(

										mainAxisAlignment: MainAxisAlignment.spaceBetween,
										children: [
											Container(
												alignment: Alignment.center,
												height: 60,
												width: 300,
												color: Colors.green,
												child: GestureDetector(
													onTap: () {
														Navigator.push(
																context,
																MaterialPageRoute(
																		builder: (context) => acsept_bill_ad(
																			use_name: DetailBill.use_name,
																			use_id: DetailBill.use_id,
																			cus_id: DetailBill.cus_id,
																			foo_id:DetailBill.foo_id,
																			det_id:DetailBill.det_id,
																			foo_name:DetailBill.foo_name,
																			det_qty:DetailBill.det_qty,
																			det_price:DetailBill.det_price,
																			det_regdate:DetailBill
																					.det_regdate,
																		)));
													},							  					child: Text(
														"ارسال الطلب الي الدليفري "),
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
