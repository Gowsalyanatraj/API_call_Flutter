// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest API Call'),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
      
            for (var i = 0; i < user['results'].length; i++) {
               ListTile(
                title: Text(user['results'][i]['email'].toString()),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(onPressed: fetchUsers),
    );
  }
}

void fetchUsers() async {
  print('fetchUsers called');
  const url = 'https://randomuser.me/api/?results=10';
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  final body = response.body;
  final json = jsonDecode(body);
  // print(json['results']);
  // print(json['results'].length);
  //  print(json['results'].length);
  for (var i = 0; i < json['results'].length; i++) {
    print(json['results'][i]['email'].toString());
  }
  // json variable have data
  setState(() {
    var users = json['results'];
  });
  print('fetchUsers completed');
}

void setState(Null Function() param0) {}
