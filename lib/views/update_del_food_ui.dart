import 'package:flutter/material.dart';
import 'package:flutter_food_log_app/models/food.dart';
import 'package:flutter_food_log_app/services/supabase_servive.dart';
import 'package:intl/intl.dart';

class UpdateDelFoodUi extends StatefulWidget {
  // สรา้งตัวแปรเพื่อรับค่าข้อมูลที่ส่งมากจากหน้า ShowFoodUi
  Food? food;

  // เอาตัวแแปลที่สร้างมารับค่า
  UpdateDelFoodUi({
    super.key,
    this.food,
  });

  @override
  State<UpdateDelFoodUi> createState() => _UpdateDelFoodUiState();
}

class _UpdateDelFoodUiState extends State<UpdateDelFoodUi> {
//ตัวควบคุม TextField
  TextEditingController foodNameCtrl = TextEditingController();
  TextEditingController foodPriceCtrl = TextEditingController();
  TextEditingController foodPersonCtrl = TextEditingController();
  TextEditingController foodDateCtrl = TextEditingController();
  //ตัวแปลเก้บมื้ออาหารที่เลือก
  String foodMeal = 'เช้า';

  //ตัวแปลเก็บวันที่กินString
  DateTime? foodDate;

//เมธอดเปิดปฏิทินให้ผู้ใช้เลือก แล้วกำหนดค่าวันที่เลือกให้กับตัวแปร foodDate ที่สร้างไว้กับแสดงที่ TextField
  Future<void> pickDate() async {
    //เปิดปฏิทิน
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        //กําหนดค่าให้กับตัวแปร
        foodDate = picked;
        //แสดงที่ TextField
        foodDateCtrl.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // เอาข้อมูลที่ส่งมาไปกำหนดตัวข้อมูลควบคุม TextField ที่สร้างไว้
    foodNameCtrl.text = widget.food!.foodName;
    foodMeal = widget.food!.foodMeal;
    foodPriceCtrl.text = widget.food!.foodPrice.toString();
    foodPersonCtrl.text = widget.food!.foodPerson.toString();
    foodDateCtrl.text = widget.food!.foodDate;
    // กำค่าวันที่กิน widget.food!.foodDate ให้กับตัวแปร foodDate 
    foodDate = DateTime.parse(widget.food!.foodDate);

  }

// เรียกใช้งานเมธอดบันทึกแก้ไขข้อมูล
  Future<void> editFood() async {
    // valdiate ui
    if (foodNameCtrl.text.isEmpty ||
        foodPriceCtrl.text.isEmpty ||
        foodPersonCtrl.text.isEmpty ||
        foodDateCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('กรุณากรอกข้อมูลให้ครบ'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    //แพ็คข้อมูลที่จะส่งไปแก้ไขในSupabase
    Food food = Food(
      foodName: foodNameCtrl.text,
      foodMeal: foodMeal,
      foodPrice: double.parse(foodPriceCtrl.text),
      foodPerson: int.parse(foodPersonCtrl.text),
      foodDate: foodDate!.toIso8601String(),
    );

    //เรียกใช้เมธอดแก้ไขข้อมูลใน supabase ผ่านทาง supabase service
    final service = SupabaseService();
    await service.updateFood(widget.food!.id!, food);
    // แจ้งผลการทำงาน
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('บันทึกข้อมูลเรียบร้อยแล้ว'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    // ย้อนกลับหน้า ShowAllFoodUi
    Navigator.pop(context);
  }

  Future<void> delFood() async {
    // แสดงdialogให้ผู้ใช้ยืนยันการลบข้อมูล
    await showDialog(
      // dialog จะอยู่บนหน้าจอนี้
      context: context,
      // หน้าตาของ dialog
      builder:(context) => AlertDialog(
        // หัวข้อของ dialog
        title: Text('ยืนยันการลบข้อมูล'),
        // เนื้อหาของ dialog
        content: Text('คุณต้องการลบข้อมูลนี้หรือไม่?'),
        // ปุ่มยืนยันการลบข้อมูล
        actions: [
          // ปุ่มยกเลิกเพื่อปิด dialog
          ElevatedButton(
            onPressed: () {
              // ปิด dialog
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            child: Text(
              'ยกเลิก',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          // ปุ่มยืนยันว่าจะลบข้อมูล
          ElevatedButton(
            onPressed: () async {
              //สร้าง instance/object/ตัวแทนของ supabase service เพื่อเรียกใช้เมธอดลบข้อมูล
              final service = SupabaseService();
              await service.deleteFood(widget.food!.id!);

              // แจ้งผลการทำงาน
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('ลบข้อมูลเรียบร้อยแล้ว'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );

              // ปิด dialog
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: Text(
              'ยืนยันการลบข้อมูล',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),      
        ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ส่วนของ AppBar
      appBar: AppBar(
        backgroundColor: Colors.pink[700],
        title: Text(
          'Eat Eat LOG(แก้ไข/ลบรายการ)',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            // ย้อนกลับบไปหน้าที่เปิดมา
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      // ส่วนของBody
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              // ส่วนแสดง Logo
              Image.asset(
                'assets/images/logo.png',
                width: 180,
                height: 180,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              // ป้อนกินอะไร
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'กินอะไร',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              TextField(
                controller: foodNameCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'เช่น KFC, Pizza',
                ),
              ),
              SizedBox(height: 20),
              // เลือกกินมื้อไหน
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'กินมื้อไหน',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        foodMeal = 'เช้า';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          foodMeal == 'เช้า' ? Colors.pink[900] : Colors.grey,
                    ),
                    child: Text(
                      'เช้า',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        foodMeal = 'กลางวัน';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: foodMeal == 'กลางวัน'
                          ? Colors.pink[900]
                          : Colors.grey,
                    ),
                    child: Text(
                      'กลางวัน',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        foodMeal = 'เย็น';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          foodMeal == 'เย็น' ? Colors.pink[900] : Colors.grey,
                    ),
                    child: Text(
                      'เย็น',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: Text(
                      'ว่าง',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // ป้อนกินไปเท่าไหร่
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'กินไปเท่าไหร่',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              TextField(
                controller: foodPriceCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'เช่น 299.50',
                ),
              ),
              SizedBox(height: 20),
              // ป้อนกินกันกี่คน

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'กินกันกี่คน',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),

              TextField(
                controller: foodPersonCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'เช่น 3',
                ),
              ),

              SizedBox(height: 20),
              // เลือกกินไปวันไหน
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'กินไปวันไหน',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              TextField(
                controller: foodDateCtrl,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'เช่น 2020-01-31',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () {
                  //แสดงปฏิทินให้ผู้ใช้เลือกแล้วเอามาแสดงที่ TextField นี้
                  pickDate();
                },
              ),
              SizedBox(height: 20),
              // ปุ่มบันทึก
              ElevatedButton(
                onPressed: () {
                  editFood();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 141, 231, 131),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    50,
                  ),
                ),
                child: Text(
                  "บันทึกแก้ไข",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              // ปุ่มลบ
              ElevatedButton(
                onPressed: () {
                  delFood().then((value){
                    // เมื่อลบเสร็จแล้วกลับไปหน้า showAllFoodUi
                    Navigator.pop(context);
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    50,
                  ),
                ),
                child: Text(
                  "ลบข้อมูล",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
