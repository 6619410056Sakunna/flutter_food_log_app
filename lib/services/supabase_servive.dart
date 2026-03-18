//คลาสนี้มช้สำหรับเขียนโค้ดคำสั่งเพื่อทำงานต่างๆ กับ Supabase

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  //สร้างตัวแทนนที่ใฃ้ทำงานกับ Supabase
  final SupabaseClient = Supabase.instance.client;

  //ส่วนของmethodการทำงานต่างๆกับ Supabase
  //เช่น เพิ่ม  แก้ไข ลบ ค้นหาตรวจสอบ ดึง ดู
}
