import 'package:flutter/material.dart';

class Multiply extends StatelessWidget {
  const Multiply({Key? key, required this.input, required this.state})
      : super(key: key);

  final int input;
  final int state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Multiplication'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${input} X ${state} =',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              '${input * state}',
              style: TextStyle(fontSize: 50),
            )
          ],
        ),
      ),
    );
  }
}
