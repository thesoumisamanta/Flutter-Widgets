class CustomDataModel {
  String? name;
  String? role;
  bool? isActive;

  CustomDataModel({required this.name, required this.role, required this.isActive});

  CustomDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    role = json['role'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['role'] = this.role;
    data['isActive'] = this.isActive;
    return data;
  }
}