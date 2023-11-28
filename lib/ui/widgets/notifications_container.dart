// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class NotificationContainer extends StatelessWidget {
  const NotificationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Icon(
          Icons.message,
          size: 40,
        ),
        Column(
          children: [
            Text("Notification Titel",style: TextStyle(fontSize: 18,color: Colors.white),),
            Text("Notification Body\nNotification Body\nNotification Body\nNotification Body\n",style: TextStyle(fontSize: 12,color: Colors.white),),
          ],
        )
      ],
    ));
  }
}
