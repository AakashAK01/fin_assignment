import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../widgets/navigationbar_widget.dart';
import 'package:dio/dio.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int currentPageIndex = 2;
  late Future<Map<String, dynamic>> userData;
  final dio = Dio();
  @override
  void initState() {
    super.initState();
    userData = fetchUserData();
  }

  void _refreshUserData() {
    setState(() {
      userData = fetchUserData();
    });
  }

  @override
  void dispose() {
    dio.close();
    super.dispose();
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    print("INFO: fetchUserData");

    final response = await dio.get('https://randomuser.me/api/');
    if (response.statusCode == 200) {
      return response.data['results'][0];
    } else {
      throw Exception('Failed to load user data');
    }
  }

  Widget _buildProfileDetails(Map<String, dynamic> userData) {
    final name = userData['name']['first'] + ' ' + userData['name']['last'];
    final location = userData['location']['city'] +
        ', ' +
        userData['location']['state'] +
        ', ' +
        userData['location']['country'];
    final email = userData['email'];
    final dob = DateTime.parse(userData['dob']['date']).toLocal();
    final registeredDate =
        DateTime.parse(userData['registered']['date']).toLocal();
    final daysPassed = DateTime.now().difference(registeredDate).inDays;
    final imageUrl = userData['picture']['large'];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
            child: Text(
          "Profile",
          style: TextStyle(fontSize: 28),
        )),
        Padding(
          padding: const EdgeInsets.only(
            top: 60.0,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl),
                    maxRadius: 60,
                  ),
                ),
                Gap(8),
                Text(
                  "Name: ${name}",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Gap(8),
                Text(
                  "Location:  ${location}",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Gap(8),
                Text(
                  "Email: ${email}",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Gap(8),
                Text(
                  'DOB: ${DateFormat('dd/MM/yyyy').format(dob.toLocal())}',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Gap(8),
                Text(
                  'Days passed since registered: $daysPassed',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Gap(60),
                InkWell(
                  onTap: () {
                    _refreshUserData();
                  },
                  child: Container(
                    height: 50,
                    width: 180,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        "Click for more users",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildProfileDetails(snapshot.data!);
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: CustomNavigationBar(
        index: 2,
      ),
    );
  }
}
