class ComplexDataModel {
  String? name;
  int? age;
  bool? isActive;
  Details? details;

  ComplexDataModel({this.name, this.age, this.isActive, this.details});

  ComplexDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    isActive = json['isActive'];
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    data['isActive'] = this.isActive;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    return data;
  }
}

class Details {
  String? role;
  String? experience;

  Details({this.role, this.experience});

  Details.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    experience = json['experience'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role'] = this.role;
    data['experience'] = this.experience;
    return data;
  }
}