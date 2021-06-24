class Data {
  final int id;
  final String name;
  final String icon;

  Data({required this.id, required this.name, required this.icon});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(id: json['id'], name: json['name'], icon: json['icon']);
  }
}
