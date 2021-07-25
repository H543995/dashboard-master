import 'package:dashboard/pages/config.dart';

String imageCus = path_images + "cus/";

class yes_bill_Data {
  String bil_id;
  String det_id;
  String no_desc;
  String cus_id;
	String use_id;
	String use_name;
	String del_id;
  String foo_id;
  String foo_name;
	String det_qty;
	String det_price;
	String det_regdate;
	String  del_name;
	String  del_mobile;
	String  loct_cus;
	String 	mobile_cus;
	String foo_thumbnail;
	String foo_image;

	yes_bill_Data(
      {
			this.bil_id,
      this.det_id,
      this.no_desc,
				this.cus_id,
				this.use_name,
				this.use_id,
				this.del_id,
      this.foo_id,
      this.foo_name,
				this.det_qty,
				this.det_price,
				this.det_regdate,
			this.del_name,
				this.del_mobile,
				this.loct_cus,
				this.mobile_cus,
			this.foo_image,
				this.foo_thumbnail


			});
}
