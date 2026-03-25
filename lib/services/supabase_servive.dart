//คลาสนี้มช้สำหรับเขียนโค้ดคำสั่งเพื่อทำงานต่างๆ กับ Supabase

import 'package:flutter_food_log_app/models/food.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  //สร้างตัวแทนนที่ใฃ้ทำงานกับ Supabase
  final supabase = Supabase.instance.client;

  //ส่วนของmethodการทำงานต่างๆกับ Supabase

  //เช่น เพิ่ม  แก้ไข ลบ ค้นหาตรวจสอบ ดึง ดู
  Future<List<Food>> getAllFood() async {
    //ดึงข้อมูลทั้งหมดจาก_food_tb in supabast
    final data = await supabase
        .from('food_tb')
        .select('*')
        .order('FoodDate', ascending: false);

    return data.map<Food>((e) => Food.fromJson(e)).toList();
  }
}
