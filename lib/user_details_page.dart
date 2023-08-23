import 'package:flutter/material.dart';
import 'package:flutter_user_list_api_assignment/user_data_model.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({super.key, required this.userDetails});

  final User userDetails;

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  @override
  Widget build(BuildContext context) {
    final String imageURL = widget.userDetails.picture;
    final String fullName = '${widget.userDetails.name}}';
    final String gender = widget.userDetails.gender;
    final String dateOfbirth = widget.userDetails.dob;
    final int age = widget.userDetails.age;
    final String location = widget.userDetails.address;

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(imageURL),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Name: $fullName',
            style: const TextStyle(fontSize: 15, color: Colors.blue),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Age: $age',
            style: const TextStyle(fontSize: 15, color: Colors.blue),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Gender: $gender',
            style: const TextStyle(fontSize: 15, color: Colors.blue),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'DOB: ${dateOfbirth.toString()}',
            style: const TextStyle(fontSize: 15, color: Colors.blue),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Address: $location',
            style: const TextStyle(fontSize: 15, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
