class ContactModel {
  late String id;
  late String? name;
  late String? gender;
  late String? age;
  late String? date;
  late String? notices;
  late String? about;
  late String? rating;
  late String? img;

  ContactModel(
      {required this.id,
      required this.name,
      required this.gender,
      required this.age,
      required this.date,
      this.notices,
      this.about,
      this.rating,
      this.img});

  ContactModel.fromMap(Map map) {
    id:
    map['id'];
    name:
    map['name'];
    gender:
    map['gender'];
    age:
    map['age'];
    date:
    map['date'];
    notices:
    map['notices'];
    about:
    map['about'];
    rating:
    map['rating'];
    img:
    map['img'];
  }

  Map toJson() => {
        'id': id,
        'name': name,
        'gender': gender,
        'age': age,
        'date': date,
        'notices': notices,
        'about': about,
        'rating': rating,
        'img': img,
      };
}
