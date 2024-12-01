import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stash_fund/components/navbar.dart';
import 'package:stash_fund/screens/categories.dart';
import 'package:stash_fund/components/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30), // Adjust padding as needed
          Padding(
            padding: const EdgeInsets.only(top: 50.0), // Add padding above the avatar
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(
                  'assets/images/logo.png'), 
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Avtomat Kalashnikova",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 5),
          const Text(
            "@kalashnikova_ak47",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 30),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.blueGrey),
            title: const Text("Edit Profile"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Edit Profile page
            },
          ),
          const Divider(height: 1, thickness: 1),
          ListTile(
            leading: const Icon(Icons.flag, color: Colors.blueGrey),
            title: const Text("Set up Goal"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to CategoriesPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoriesPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout'),
            onTap: () => _confirmLogout(context),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        parentContext: context,
        currentIndex: 3, // 3 for Profile
      ),
    );
  }
}

