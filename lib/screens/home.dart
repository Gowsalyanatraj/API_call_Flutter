// ignore_for_file: unused_local_variable
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Widgets/container.dart';

Future getUserList() async {
  try {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == 200) {
      log(response.body);
      final result = json.decode(response.body);
      return result;
    } else {
      return throw Exception('Issues');
    }
  } catch (e) {
    throw Exception("Failed to Fetch");
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future futureUserData;

  @override
  void initState() {
    super.initState();
    futureUserData = getUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest API Call'),
      ),
      body: FutureBuilder(
        future: futureUserData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return  ListTile(
                    title: Text("${snapshot.data[index]['body']}"),
                  );
                });
          }
          if (snapshot.hasError) {
            return const Text("Failed to Fetch User List");
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}

// class _HomeScreenState extends State<HomeScreen> {
//   Future? futureUserData;
//   bool isLoading = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Rest API Call'),
//       ),
//       body: FutureBuilder(
//         future: futureUserData,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             if (isLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else {
//               return ListView.builder(
//                   itemCount: snapshot.data.length, // 10
//                   itemBuilder: (context, index) {
//                     return ContainerWidget(description: "${snapshot.data[index]['body']}",);
//                   });
//             }
//           }
//           if (snapshot.hasError) {
//             return const Text("Failed to Fetch User List");
//           } else {
//             return const Center(child: Text("Fetch Data"));
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//           child: const Icon(Icons.download),
//           onPressed: () {
//             setState(() {
//               isLoading = true;
//               futureUserData = getUserList();
//             });
//             Future.delayed(const Duration(seconds: 2),
//                 () => {isLoading = false, setState(() {})});
//           }),
//     );
//   }
// }
