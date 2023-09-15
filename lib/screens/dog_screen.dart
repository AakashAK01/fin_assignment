import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

import '../widgets/navigationbar_widget.dart';

class DogScreen extends StatefulWidget {
  const DogScreen({super.key});

  @override
  State<DogScreen> createState() => _DogScreenState();
}

class _DogScreenState extends State<DogScreen> {
  int currentPageIndex = 0;
  late Future<String> dogImageUrl;
  final Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    dogImageUrl = fetchDogImageUrl();
  }

  void _refreshDogData() {
    setState(() {
      dogImageUrl = fetchDogImageUrl();
    });
  }

  @override
  void dispose() {
    dio.close();
    super.dispose();
  }

  Future<String> fetchDogImageUrl() async {
    try {
      final response = await dio.get('https://dog.ceo/api/breeds/image/random');
      if (response.statusCode == 200) {
        return response.data['message'];
      } else {
        throw Exception('Failed to load dog image');
      }
    } catch (e) {
      throw Exception('Failed to load dog image: $e');
    }
  }

  Widget _buildDogImage(String imageUrl) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Add navigation back button here

        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(imageUrl, width: 300, height: 300),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    _refreshDogData();
                  },
                  child: Container(
                    height: 50,
                    width: 180,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        "Click to see more dogs",
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
      body: FutureBuilder<String>(
        future: fetchDogImageUrl(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildDogImage(snapshot.data!);
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: CustomNavigationBar(
        index: 0,
      ),
    );
  }
}
