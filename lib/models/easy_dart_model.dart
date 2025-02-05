// {
//     "id": 1,
//     "name": "John Doe",
//     "email": "john.doe@example.com"
// }

class EasyDartModel {
  int? id;
  String? name;
  String? email;

  EasyDartModel({this.id, this.name, this.email});

  EasyDartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}