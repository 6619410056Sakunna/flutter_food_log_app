import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddFoodUi extends StatefulWidget {
  const AddFoodUi({super.key});

  @override
  State<AddFoodUi> createState() => _AddFoodUiState();
}

class _AddFoodUiState extends State<AddFoodUi> {
//ตัวควบคุม TextField
  TextEditingController foodNameCtrl = TextEditingController();
  TextEditingController foodPriceCtrl = TextEditingController();
  TextEditingController foodPersonCtrl = TextEditingController();
  TextEditingController foodDateCtrl = TextEditingController();
  //ตัวแปลเก้บมื้ออาหารที่เลือก
  String foodMeal = 'เช้า';

  //ตัวแปลเก็บวันที่กินString
  DateTime? foodDate;

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        foodDate = picked;

        foodDateCtrl.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[900],
        title: Text(
          'Eat Eat LOG(เพิ่มรายการอาหาร)',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(8.0),
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
                  //แสดงปฏิทิน
                },
              ),
              SizedBox(height: 20),
              // ปุ่มบันทึก
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    50,
                  ),
                ),
                child: Text("บันทึก",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
              SizedBox(height: 10),
              // ปุ่มยกเลิก
              ElevatedButton(
                onPressed: () {},
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
                  "ยกเลิก",
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
