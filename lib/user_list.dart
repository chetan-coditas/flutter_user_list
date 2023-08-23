import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_user_list_api_assignment/user_data_model.dart';
import 'Data/database_repo.dart';
import 'user_details_page.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    getUsersData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        backgroundColor: Colors.blue,
      ),
      body: GridView.count(
        crossAxisCount: 3,
        // crossAxisSpacing: 5,
        // mainAxisSpacing: 5,
        children: List.generate(users.length, (index) {
          final String imageURL = users[index].picture;
          final String fullName = users[index].name;
          return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserDetailPage(
                          userDetails: users[index],
                        )));
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(imageURL),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      fullName,
                      style: const TextStyle(fontSize: 15, color: Colors.blue),
                    )
                  ],
                ),
              ));
        }),
      ),
    );
  }

  Future<void> getUsersData() async {
    // Make a GET request to the API
    Response response =
        await Dio().get("https://randomuser.me/api/?results=50");

    UserListData userListData = UserListData.fromJson(response.data);

    // TODOs: need to improve insert logic
    for (var userData in userListData.results) {
      //  String id = userData.id.value;
      String userName = '${userData.name.first}, ${userData.name.last}';
      String gender = userData.gender;
      int age = userData.dob.age;
      String dob = userData.dob.date.toString();
      String picture = userData.picture.medium;
      String address =
          '${userData.location.city}, ${userData.location.state}, ${userData.location.country}, ${userData.location.postcode}';
      User user = User(
          name: userName,
          gender: gender,
          age: age,
          dob: dob,
          address: address,
          picture: picture);
      DatabaseRepository.instance.insert(user: user);
    }

    users = await DatabaseRepository.instance.getAllUser();
    setState(() {});
  }
}
