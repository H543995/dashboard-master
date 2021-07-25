import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard/pages/admin/category_admin/edit_category_ad.dart';
import 'package:dashboard/pages/admin/food_read_ad/food.dart';
import 'package:dashboard/pages/config.dart';
import 'package:dashboard/pages/food/food.dart';
import 'package:dashboard/pages/function.dart';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


List<CategoryData_ad> categoryList_ad = null;
String imageCategory = path_images + "category/";

class CategoryData_ad {
	String cat_id;
	String use_id;

	String cat_name;
	String cat_name_en;
	String cat_regdate;
	String cat_thumbnail;

	CategoryData_ad(
			{this.cat_id,
				this.use_id,
				this.cat_name,
				this.cat_name_en,
				this.cat_regdate,
				this.cat_thumbnail});
}

class SingleCategory extends StatelessWidget {
	int cat_index;
	CategoryData_ad category;
	SingleCategory({this.cat_index, this.category});
	@override
	Widget build(BuildContext context) {
		var providerCategory = Provider.of<LoadingControl>(context);
		return Card(
			child: Column(
				children: <Widget>[
					GestureDetector(
						onTap: () {
							categoryList_ad.removeAt(cat_index);
							deleteData("cat_id", category.cat_id,"admin/category_admin/delete_categ"
									"ory.php");
							providerCategory.add_loading();
						},
						child: Container(
							alignment: Alignment.topRight,
							child: Icon(
								Icons.cancel,
								color: Colors.red,
							),
						),
					),
					Container(
						child: ListTile(
							leading: category.cat_thumbnail == null ||
									category.cat_thumbnail == ""
									? CachedNetworkImage(
								imageUrl: imageCategory + "def.png",
								placeholder: (context, url) =>
										CircularProgressIndicator(),
								errorWidget: (context, url, error) => Icon(Icons.error),
							)
									: CachedNetworkImage(
								imageUrl: imageCategory + category.cat_thumbnail,
								placeholder: (context, url) =>
										CircularProgressIndicator(),
								errorWidget: (context, url, error) => Icon(Icons.error),
							),
							title: Text(
								category.cat_name,
								style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
							),
							subtitle: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Text(category.cat_regdate),
										RaisedButton(
											child: Text("مشاهده المنتجات"),
											onPressed: () {
												Navigator.push(
														context,
														MaterialPageRoute(
																builder: (context) =>  insert_use(

																		cat_name: category.cat_name)));
											},
										)
									]),
							trailing: Container(
								width: 30.0,
								child: Row(
									children: <Widget>[
										GestureDetector(
											onTap: () {
												Navigator.push(
														context,
														MaterialPageRoute(
																builder: (context) =>  EditCategory_ad(
																		cat_index: cat_index,
																		mycategory: category)));
											},
											child: Container(
												padding: EdgeInsets.all(5),
												child: FaIcon(
													FontAwesomeIcons.edit,
													color: Colors.white,
													size: 16,
												),
												decoration: BoxDecoration(
														color: Colors.red,
														borderRadius: BorderRadius.circular(5.0)),
											),
										),
									],
								),
							),
						),
					),
				],
			),
		);
	}
}
