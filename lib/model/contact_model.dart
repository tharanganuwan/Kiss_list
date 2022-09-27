class ContactModel {
  int? id;
  String? name;
  String? gender;
  String? age;
  String? date;
  String? notices;
  String? about;
  String? rating;
  String? img;

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

  static ContactModel fromJson(Map<String, dynamic> json) => ContactModel(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      age: json['age'],
      date: json['date'],
      notices: json['notices'],
      about: json['about'],
      rating: json['rating'],
      img: json['img']);
}
