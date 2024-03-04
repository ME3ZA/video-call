import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String username;
  final String email;
  final String image;

  AppUser({
    required this.username,
    required this.email,
    required this.image,
  });
}

class ContactsUI extends StatefulWidget {
  final String username;

  ContactsUI({required this.username});

  @override
  _ContactsUIState createState() => _ContactsUIState();
}

class _ContactsUIState extends State<ContactsUI> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<AppUser> _friends = [];

  void _searchUser() async {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  void _addFriend(AppUser user) {
    if (!_friends.contains(user)) {
      setState(() {
        _friends.add(user);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Friend added successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${user.username} is already your friend.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _searchedUserList(String searchQuery) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: searchQuery)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No user found with the username: $searchQuery');
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot userSnapshot = snapshot.data!.docs[index];
            Map<String, dynamic>? userData =
                userSnapshot.data() as Map<String, dynamic>?;

            if (userData == null || !userData.containsKey('username')) {
              return SizedBox.shrink();
            }

            String username = userData['username'] ?? '';
            String image = userData['image'] ?? '';

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(image),
              ),
              title: Text(username),
              trailing: ElevatedButton(
                onPressed: () {
                  AppUser user =
                      AppUser(username: username, email: '', image: image);
                  _addFriend(user);
                },
                child: Text('Add Friend'),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for users...',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _searchUser,
                  child: Text('Search'),
                ),
              ],
            ),
          ),
          _searchQuery.isNotEmpty
              ? _searchedUserList(_searchQuery)
              : Container(),
          SizedBox(height: 20),
          Text(
            'My Friends',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: _friends.isEmpty
                ? Center(
                    child: Text('You have no friends yet.'),
                  )
                : MyFriendsList(friends: _friends),
          ),
        ],
      ),
    );
  }
}

class MyFriendsList extends StatelessWidget {
  final List<AppUser> friends;

  MyFriendsList({required this.friends});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: friends.length,
      itemBuilder: (context, index) {
        AppUser friend = friends[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(friend.image),
          ),
          title: Text(friend.username),
        );
      },
    );
  }
}
