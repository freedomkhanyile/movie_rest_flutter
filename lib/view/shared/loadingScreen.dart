import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final String loadigMessage;

  const LoadingScreen({
    Key? key,
    required this.loadigMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            loadigMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: 24,
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
