import 'package:flutter/material.dart';
import 'about_app.dart';
import 'pet_input.dart';
import 'profile_view.dart';
import '../data/user_data.dart';
import 'login_page.dart';


class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = LoggedInUser.user;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Center(
          child: Text('No user logged in'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          // Profile picture and name
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: user.profileImage.isNotEmpty
                      ? AssetImage(user.profileImage)
                      : NetworkImage('https://i.pravatar.cc/300') as ImageProvider,
                ),
                SizedBox(height: 16),
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  user.username,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Profile settings
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileView()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.pets),
                  title: Text('Pet'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PetPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About Petcare Hub'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                // Logout logic here
                LoggedInUser.user = null; // Clear logged-in user data
                Navigator.of(context).pop();
                // Navigate to login page or exit the app
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}