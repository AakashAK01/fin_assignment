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
  String dogImageUrl = '';
  final Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    fetchRandomDogImage();
  }

  Future<void> fetchRandomDogImage() async {
    try {
      final response = await dio.get('https://dog.ceo/api/breeds/image/random');
      if (response.statusCode == 200) {
        final data = response.data;
        setState(() {
          dogImageUrl = data['message'];
        });
      } else {
        throw Exception('Failed to load dog image');
      }
    } catch (e) {
      throw Exception('Failed to load dog image: $e');
    }
  }

  @override
  void dispose() {
    dio.close();
    super.dispose();
  }

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
                child: Icon(
              Icons.chevron_left,
              size: 30,
            )),
          ),
          Expanded(
            child: Center(
              child: dogImageUrl.isEmpty
                  ? CircularProgressIndicator()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(dogImageUrl, width: 300, height: 300),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            fetchRandomDogImage();
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
      ),
      bottomNavigationBar: CustomNavigationBar(
        index: 0,
      ),
    );
  }
}
