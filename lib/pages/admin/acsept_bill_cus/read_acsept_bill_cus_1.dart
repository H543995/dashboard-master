import 'dart:ui';
import 'package:dashboard/pages/admin/acsept_bill_cus/read_acsept_bill_cus_2.dart';
import 'package:dashboard/pages/admin/chaing_yes_bill_ad/read_yes_bill_ad_2.dart';
import 'package:dashboard/pages/admin/chaing_yes_bill_ad/yes_bill_Data.dart';
import 'package:dashboard/pages/function.dart';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<yes_bill_Data> billList = null;

class read_acsept_bill_cus_1 extends StatefulWidget {
  @override
  _read_acsept_bill_cus_1State createState() => _read_acsept_bill_cus_1State();
}

class _read_acsept_bill_cus_1State extends State<read_acsept_bill_cus_1> {
  ScrollController myScroll;
  GlobalKey<RefreshIndicatorState> refreshKey;
  int i = 0;
  bool loadingList = false;

  void getDatabill(int count, String strSearch) async {
    loadingList = true;
    setState(() {});
    List arr = await getData2(
        count, 20, "acsept_bill_cus/read_acsept_bill_cus.php", strSearch, "");
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
    _appBarTitle = new Text("الطلبيات", style: TextStyle(color: Colors.black));
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

  void _searchPressed(LoadingControl myProv) {
    if (this._searchIcon.icon == Icons.search) {
      this._searchIcon = new Icon(Icons.close);
      this._appBarTitle = new TextField(
        style: TextStyle(color: Colors.white),
        decoration: new InputDecoration(
            prefixIcon: Icon(Icons.search), hintText: "ابحث ..."),
        onChanged: (text) {
          print(text);

          billList.clear();
          i = 0;
          getDatabill(0, text);
          myProv.add_loading();
        },
      );
    } else {
      this._searchIcon = new Icon(Icons.search);
      this._appBarTitle = new Text(
        "بحث باسم المأكولات",
        style: TextStyle(color: Colors.black),
      );
    }
    myProv.add_loading();
  }

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
          body: Container(
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

                  return SingleBill(
                    bil_index: index,
                    bill: billList[index],


                  );
                },
              ),
            ),
          )),
    );
  }
}
class SingleBill extends StatelessWidget {
  int bil_index;
  yes_bill_Data bill;
  SingleBill({this.bil_index, this.bill});

  bool isloadingFav = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => read_acsept_bill_cus_2(
                  det_id: bill.det_id,
                  det_regdate: bill.det_regdate,
                )));
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Text(
                bill.det_regdate,
                style: TextStyle(
                    fontFamily: "arial", fontSize: 16, color: Colors.grey),
              ),
              Row(
                children: [
                  new Text(
                    bill.det_id,
                    style: TextStyle(
                        fontFamily: "arial", color: Colors.red, fontSize: 16),
                  ),
                  new Text("  "),
                  new Text("رقم الفاتورة"),
                ],
              ),
              Row(
                children: [
                  new Text(
                    bill.cus_id,
                    style: TextStyle(
                        fontFamily: "arial", color: Colors.red, fontSize: 16),
                  ),
                  new Text("  "),
                  new Text("رقم الزبون"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

