// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../widgets/notifications_container.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 32,
        ),
        Container(
          height: 100,
          width: double.infinity,
          color: Color.fromRGBO(43, 52, 59, 1),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: CircleAvatar(
                  backgroundColor: Color.fromRGBO(113, 109, 136, 0.2),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  )),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 760,
          color: Color.fromRGBO(77, 80, 97, 1),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 32,
                ),
                Text(
                  "Notifications",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(
                  height: 32,
                ),
                Divider(
                  height: 0.1,
                ),
                notificationList(),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  notificationList() {
    return Container(
      height: 600,
      width: 350,
      child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
                height: 20,
              ),
          itemCount: 6,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return NotificationContainer();
          }),
    );
  }
}
