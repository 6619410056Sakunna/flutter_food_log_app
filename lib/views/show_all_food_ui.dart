import 'package:flutter/material.dart';
import 'package:flutter_food_log_app/models/food.dart';
import 'package:flutter_food_log_app/views/add_food_ui.dart';
import 'package:flutter_food_log_app/services/supabase_servive.dart';
import 'package:flutter_food_log_app/views/update_del_food_ui.dart';

class ShowAllFoodUi extends StatefulWidget {
  const ShowAllFoodUi({super.key});

  @override
  State<ShowAllFoodUi> createState() => _ShowAllFoodUiState();
}

class _ShowAllFoodUiState extends State<ShowAllFoodUi> {
  //สร้างตัวแปรที่จะน้ำไปแสดงใน listview in body
  List<Food> foods = [];
  //สร้างinstance/object/ตัวแทนของsupabase
  final service = SupabaseService();

  //สร้างmethodสำหรับดึงข้อมูลจากsupabase ผ่านทางsupabastservice
  void loadAllFood() async {
    //สร้างตัวแปลเก็บข้อมูลที่จะดึงค่าผ่านทาง supabase service
    final data = await service.getAllFood();
    setState(() {
      //เก็บข้อมูลที่ได้จาก supabase service ไว้ในตัวแปร foods เพื่อใช้กับ body
      foods = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAllFood();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[700],
        title: Text(
          'Eat Eat LOG',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 200,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: 5,
                      ),
                      child: ListTile(
                        onTap: () {
                          // เปิดไปหน้าupdate del food ui แบบย่อนกลับได้
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateDelFoodUi(
                                //ส่งข้อมูลที่เลือกไปหน้า update del food ui
                                food: foods[index],
                              ),
                            ),
                          ).then((value) {
                            //กลับมาหน้านี้แล้วอยากให้ทำอะไร
                            //เรียก loadAllFood() เพื่อกลับมาจากหน้า updatedelfood ui เพื่อเป็น reload หน้าจอและข้อมูล
                            loadAllFood();
                          });
                        },
                        leading: Image.asset(
                          'assets/images/food.png',
                          width: 50,
                        ),
                        trailing: Icon(
                          Icons.edit,
                          color: Colors.red,
                        ),
                        title: Text(
                          'กิน ${foods[index].foodName}',
                        ),
                        subtitle: Text(
                          'วันที่: ${foods[index].foodDate} มื้อ: ${foods[index].foodMeal}',
                        ),
                        tileColor: index % 2 == 0
                            ? Colors.pink[50]
                            : const Color.fromARGB(255, 194, 239, 143),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddFoodUi(),
              )).then((value) {
            //กลับมาหน้านี้แล้วอยยากให้ทำอะไร
            //เรียก loadAllFood() เพื่อกลับมาจากหน้า AddFoodUi เพื่อเป็น reload หน้าจอและข้อมูล
            loadAllFood();
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.pink[700],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
