import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard/pages/config.dart';
import 'package:dashboard/pages/h1/insert_ad.dart';
import 'package:dashboard/pages/provider/loading.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


import '../function.dart';


List<CategoryData_use> categoryList_use = null;
String imageCategory = path_images + "category/";

class CategoryData_use {

	String use_id;
	String cat_name;
	String cat_name_en;
	String cat_regdate;
	String cat_thumbnail;

	CategoryData_use(
			{
				this.use_id,
				this.cat_name,
				this.cat_name_en,
				this.cat_regdate,
				this.cat_thumbnail});

}

class SingleCategory_ad extends StatelessWidget {
	int cat_index;
final String  cat_image;
      final  String cat_name;
	CategoryData_use category;
	SingleCategory_ad({this.cat_index ,this.cat_image, this.cat_name , this.category});

	@override
	Widget build(BuildContext context) {
		var providerCategory = Provider.of<LoadingControl>(context);
		return Card(
			child: Column(
				children: <Widget>[

					Container(
						child: ListTile(
							leading: category.cat_thumbnail == null ||
									category.cat_thumbnail == ""
									? CachedNetworkImage(
								imageUrl: imageCategory + "def.png" ,
								placeholder: (context , url) =>
										CircularProgressIndicator() ,
								errorWidget: (context , url , error) => Icon(Icons.error) ,
							)
									: CachedNetworkImage(
								imageUrl: imageCategory + category.cat_thumbnail ,
								placeholder: (context , url) =>
										CircularProgressIndicator() ,
								errorWidget: (context , url , error) => Icon(Icons.error) ,
							) ,
							title: Text(
								category.cat_name ,
								style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18) ,
							) ,
							subtitle: Column(
									crossAxisAlignment: CrossAxisAlignment.start ,
									children: [
										Text(category.cat_regdate) ,
										RaisedButton(
											child: Text("قائمه اصحاب محلات ذات صله") ,
											onPressed: () {
												Navigator.push(
														context ,
														MaterialPageRoute(
																builder: (context) =>
																		insert_ad(
																			cat_name: category.cat_name ,
																		)));
											} ,
										) ,
									]) ,

						) ,
					) ,
				] ,
			) ,
		);
	}
}