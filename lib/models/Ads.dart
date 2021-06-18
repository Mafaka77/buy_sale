class Data {
  final int id;
  final String ads_title;
  final String categories;
  final String ads_details;
  final String ads_price;
  final String image_id;
  final String user_id;
  final String user_name;
  final String user_address;

  Data(
      {required this.id,
      required this.ads_title,
      required this.categories,
      required this.ads_details,
      required this.ads_price,
      required this.image_id,
      required this.user_id,
      required this.user_name,
      required this.user_address});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      ads_title: json['ads_title'],
      categories: json['categories'],
      ads_details: json['ads_details'],
      ads_price: json['ads_price'],
      image_id: json['image_id'],
      user_id: json['user_id'],
      user_name: json['user_name'],
      user_address: json['user_address'],
    );
  }
}
