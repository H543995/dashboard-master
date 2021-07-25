import 'package:dashboard/pages/account/login.dart';
import 'package:dashboard/pages/admin/login_manger.dart';
import 'package:dashboard/pages/test1/catger_insert_use.dart';
import 'package:dashboard/pages/test1/login.dart';
import 'package:flutter/material.dart';

class start extends StatefulWidget {
  @override
  _startState createState() => _startState();
}

class _startState extends State<start> {
  @override
  Widget build(BuildContext context) {
    return Container(
color: Colors.teal,
      child: Center(
        child: Row(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: [

				Padding(
				  padding:  EdgeInsets.only(top: 14),
				  child: Padding(
				    padding: const EdgeInsets.all(8.0),
				    child: Container(
							width: 150,
						color: Colors.grey,
				    	child: GestureDetector(
				    		onTap: () {
				    			Navigator.push(context,
				    					MaterialPageRoute(builder: (context) => Login_use()));
				    		},
				    		child: Text("users",style: TextStyle(
									fontSize: 40
								),),
				    	),
				    ),
				  ),
				),
				Padding(
				  padding: EdgeInsets.all(8.0),
				  child: Container(
						color: Colors.grey,
						width: 150,
				  	child: GestureDetector(
				  		child: Text("admin",style: TextStyle(
				  			fontSize: 40
				  		),),
				  		onTap: () {
				  			Navigator.push(context,
				  					MaterialPageRoute(builder: (context) =>Login_manger()));
				  		},
				  	),
				  ),
				),
			],
		),
      ),
    );
  }
}
