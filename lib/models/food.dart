class Food {
  String? id;
  DateTime? created_at;
  DateTime? foodDate;
  String? foodMeal;
  String? foodName;
  double? foodPrice;
  int? foodPerson;

  Food({
    this.id,
    this.created_at,
    this.foodDate,
    this.foodMeal,
    this.foodName,
    this.foodPrice,
    this.foodPerson,
  });

  //แปลงข้อมูลจากแอป ไป supabase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': created_at,
      'foodDate': foodDate,
      'foodMeal': foodMeal,
      'foodName': foodName,
      'foodPrice': foodPrice,
      'foodPerson': foodPerson,
    };
  }

  //แปลงข้อมูลจาก supabase ไป แอป
  factory Food.fromMap(Map<String, dynamic> map) => Food(
        id: map['id'] as String,
        created_at: DateTime.parse(map['created_at'] as String),
        foodDate: DateTime.parse(map['foodDate'] as String),
        foodMeal: map['foodMeal'] as String,
        foodName: map['foodName'] as String,
        foodPrice: double.parse(map['foodPrice'] as String),
        foodPerson: int.parse(map['foodPerson'] as String),
      );
}
