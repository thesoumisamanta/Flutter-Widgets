import 'dart:io';

void main() {
  // print("welcome to flutter");

  // stdout.write("enter your name\n");

  // var name = stdin.readLineSync();

  // print("welcome, $name");

  // Human();

  // int? a;

  // print(a);

  // String name = "67";

  // name = "56";

  // var a = 90;

  // a = 56;

  // var b;

  // b = "yfuyf";

  // b = 89;

  // dynamic num;

  // num = 78;

  // num = "eiufhiuew";

  // var obj = MyClass();
  // obj.printName("Soumi");
  // obj.printName("Neel");

  // var res1 = obj.add(10, 12);
  // print(res1);
  // var res2 = obj.add(13, 15);
  // print(res2);

  // var lists = [1, 2, 3, 4];

  // lists.add(5);
  // lists.remove(3);

  // var newList = [];

  // newList.add("soumi");

  // newList.add(lists);

  // print(newList);/

  // var employee = {"id": 1, "name": "Soumi", "isActive": true};

  // employee["location"] = "kolkata"; //add value
  // employee["name"] = "Neel"; //overwrite value

  // print(employee);

  // var intern = Map();

  // intern["id"] = 1;
  // intern["name"] = "Sourya";
  // intern["location"] = "Delhi";

  // print(intern);

  // print(intern.isEmpty);
  // print(intern.isNotEmpty);
  // print(intern.values);
  // print(intern.keys);
  // print(intern.length);
  // print(intern.entries);
  // print(intern.containsKey("name"));
  // print(intern.containsKey("company"));
  // print(intern.containsValue("Neel"));

  final name = "Soumi";
  // final names;
  // const ages;

  //  age = 56;

  //  rollNo; ---> must be initialiazed within declaration

  // age = 78;  -> can not reassign to ant variable

  // name = "Neel";  --> can not reassign to final variable

  final names = ["soumi", "pooja", "neel", "Sourya"];

  names.add("gambu");

  print(names);

  // employees = ["soumi", "pooja", "neel", "Sourya"];

  // employees.add("gambu");
}

class MyClass {
  void printName(String name) {
    print("Welcome, $name");
  }

  int add(int a, int b) {
    // int a, b;
    // a = 5;
    // b = 7;
    int sum = a + b;
    return sum;
  }
}
