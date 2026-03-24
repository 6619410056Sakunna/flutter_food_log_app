import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddFoodUi extends StatefulWidget {
  const AddFoodUi({super.key});

  @override
  State<AddFoodUi> createState() => _AddFoodUiState();
}

class _AddFoodUiState extends State<AddFoodUi> {
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
    );
  }
}
