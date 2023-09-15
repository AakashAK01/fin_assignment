import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/navigationbar_widget.dart';

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({Key? key});

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  final MethodChannel _methodChannel =
      MethodChannel('method.flutter.io/bluetooth');

  Future<void> enableBluetooth() async {
    try {
      final bool isEnabled =
          await _methodChannel.invokeMethod('enableBluetooth');
      if (isEnabled) {
        print("Enabled");
        // Bluetooth is now enabled
      } else {
        showBluetoothEnabledDialog(context);

        print("Was Enabled");
      }
    } on PlatformException catch (e) {
      // Handle any errors that occur during the method call
      print("Error: ${e.message}");
    }
  }

  void showBluetoothEnabledDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bluetooth is already enabled'),
          content: Text('You can proceed with your Bluetooth-related tasks.'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      enableBluetooth();
                    },
                    child: Container(
                      height: 50,
                      width: 180,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          "Enable Bluetooth",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        index: 1,
      ),
    );
  }
}
