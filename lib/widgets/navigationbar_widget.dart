import 'package:flutter/material.dart';

import '../screens/bluetooth_screen.dart';
import '../screens/dog_screen.dart';
import '../screens/profile_screen.dart';

class CustomNavigationBar extends StatelessWidget {
  final int index;

  const CustomNavigationBar({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (index != 0)
            _iconLabel(
              label: "Home",
              color: Colors.black.withOpacity(0.6),
              icon: Icons.home_outlined,
              onTap: () {
                if (index != 0) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DogScreen(),
                  ));
                }
              },
            )
          else
            _iconLabel(
              label: "Home",
              onTap: () {},
              color: Colors.purple.withOpacity(0.6),
              icon: Icons.home,
            ),
          if (index != 1)
            _iconLabel(
                label: "Bluetooth",
                icon: Icons.bluetooth_outlined,
                color: Colors.black.withOpacity(0.6),
                onTap: () {
                  if (index != 1) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BluetoothScreen(),
                    ));
                  }
                })
          else
            _iconLabel(
                label: "Bluetooth",
                icon: Icons.bluetooth,
                color: Colors.purple.withOpacity(0.6),
                onTap: () {}),
          if (index != 2)
            _iconLabel(
                label: "Profile",
                icon: Icons.person_2_outlined,
                color: Colors.black.withOpacity(0.6),
                onTap: () {
                  print(index);
                  if (index != 2) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ));
                  }
                })
          else
            _iconLabel(
                label: "Profile",
                color: Colors.purple.withOpacity(0.6),
                icon: Icons.person_2,
                onTap: () {})
        ],
      ),
    );
  }

  _iconLabel({
    required String label,
    IconData? icon,
    String? imgPath,
    Color? color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 25,
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.6),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
