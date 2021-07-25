import 'dart:ui';
import 'package:dashboard/pages/component/progress.dart';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:dashboard/pages/category/add.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/pages/config.dart';
import 'package:dashboard/pages/function.dart';
import 'package:provider/provider.dart';
import 'category_data_admin.dart';

class Category_admin extends StatefulWidget {
	@override
	_Category_adminState createState() => _Category_adminState();
}

class _Category_adminState extends State<Category_admin> {
	ScrollController myScroll;
	GlobalKey<RefreshIndicatorState> refreshKey;
	int i = 0;
	bool loadingList = false;
	void getDataCategory(int count, String strSearch) async {
		loadingList = true;
		setState(() {});
		List arr = await getData(count, "admin/category_admin/readcategory_admin.php", strSearch, "");
		for (int i = 0; i < arr.length; i++) {
			categoryList_ad.add(new CategoryData_ad(
				cat_id: arr[i]["cat_id"],
				cat_name: arr[i]["cat_name"],
				cat_name_en: arr[i]["cat_name_en"],
				cat_regdate: arr[i]["cat_regdate"],
				cat_thumbnail: arr[i]["cat_thumbnail"],
			));
		}
		loadingList = false;
		setState(() {});
	}

	@override
	void dispose() {
		// TODO: implement dispose
		super.dispose();
		myScroll.dispose();
		categoryList_ad.clear();
	}

	@override
	void initState() {
		// TODO: implement initState
		super.initState();
		categoryList_ad = new List<CategoryData_ad>();
		myScroll = new ScrollController();
		refreshKey = GlobalKey<RefreshIndicatorState>();
		getDataCategory(0, "");

		myScroll.addListener(() {
			if (myScroll.position.pixels == myScroll.position.maxScrollExtent) {
				i += 10;
				getDataCategory(i, "");
				print("scroll");
			}
		});
	}

	Icon _searchIcon = new Icon(Icons.search);
	Widget _appBarTitle = new Text("ادارة التصنيفات");

	void _searchPressed(LoadingControl myProv) {
		if (this._searchIcon.icon == Icons.search) {
			this._searchIcon = new Icon(Icons.close);
			this._appBarTitle = new TextField(
				style: TextStyle(color: Colors.white),
				decoration: new InputDecoration(
						prefixIcon: Icon(Icons.search), hintText: "ابحث ..."),
				onChanged: (text) {
					print(text);

					categoryList_ad.clear();
					i = 0;
					getDataCategory(0, text);
					myProv.add_loading();
				},
			);
		} else {
			this._searchIcon = new Icon(Icons.search);
			this._appBarTitle = new Text("بحث باسم التصنيف");
		}
		myProv.add_loading();
	}

	@override
	Widget build(BuildContext context) {
		var myProvider = Provider.of<LoadingControl>(context);
		return Scaffold(
			appBar: AppBar(
				backgroundColor: primaryColor,
				title: _appBarTitle,
				centerTitle: true,
				actions: [
					Container(
						padding: EdgeInsets.all(10),
						child: GestureDetector(
							onTap: () {
								_searchPressed(myProvider);
							},
							child: _searchIcon,
						),
					)
				],
			),
			backgroundColor: Colors.grey[50],
			body: RefreshIndicator(
				onRefresh: () async {
					i = 0;
					categoryList_ad.clear();
					await getDataCategory(0, "");
				},
				key: refreshKey,
				child: Directionality(
					textDirection: TextDirection.rtl,
					child: Stack(
						children: [
							Container(
								margin: EdgeInsets.only(top: 0),
								child: ListView.builder(
									controller: myScroll,
									itemCount: categoryList_ad.length,
									itemBuilder: (context, index) {
										final item = categoryList_ad[index];
										return Dismissible(
											key: Key(item.cat_name),
											direction: DismissDirection.startToEnd,
											child: SingleCategory(
												cat_index: index,
												category: categoryList_ad[index],
											),
											onDismissed: (direction) {
												categoryList_ad.remove(item);
												deleteData("cat_name", item.cat_name,
														"admin/category_admin/delete_category.php");
												myProvider.add_loading();
											},
										);
									},
								),
							),
							Positioned(
									child: loadingList ? circularProgress() : Text(""),
									bottom: 0,
									left: MediaQuery.of(context).size.width / 2)
						],
					),
				),
			),
			bottomNavigationBar: Container(
				height: 50.0,
				child: Column(
					children: <Widget>[
						Container(
							alignment: Alignment.center,
							child: GestureDetector(
								onTap: () {
									Navigator.push(context,
											MaterialPageRoute(builder: (context) => AddCategory()));
								},
								child: Text(
									"اضافة تصنيف جديد",
									style: TextStyle(color: Colors.white, fontSize: 20),
								),
							),
							height: 40.0,
							decoration: BoxDecoration(
									color: Colors.red, borderRadius: BorderRadius.circular(40)),
						),
					],
				),
			),
		);
	}
}
