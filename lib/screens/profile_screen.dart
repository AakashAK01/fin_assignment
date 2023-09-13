import 'package:flutter/material.dart';

import '../widgets/navigationbar_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int currentPageIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 430.0, top: 50),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.chevron_left,
                  size: 30,
                )),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        index: 2,
      ),
    );
  }
}
