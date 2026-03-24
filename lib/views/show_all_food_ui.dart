import 'package:flutter/material.dart';
import 'package:flutter_food_log_app/views/add_food_ui.dart';

class ShowAllFoodUi extends StatefulWidget {
  const ShowAllFoodUi({super.key});

  @override
  State<ShowAllFoodUi> createState() => _ShowAllFoodUiState();
}

class _ShowAllFoodUiState extends State<ShowAllFoodUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[900],
        title: Text(
          'Eat Eat LOG',
          style: TextStyle(
            fontSize: 25,
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFoodUi(),
            )
          );
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
