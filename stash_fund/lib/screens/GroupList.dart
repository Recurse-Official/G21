import 'package:flutter/material.dart';
import 'package:stash_fund/components/navbar.dart';

class GroupListScreen extends StatelessWidget {
  const GroupListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Group List',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/groupVault');
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 3,
                    child: const ListTile(
                      title: Text(
                        'Group 1',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/groupVault');
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 3,
                    child: const ListTile(
                      title: Text(
                        'Group 2',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/groupVault');
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 3,
                    child: const ListTile(
                      title: Text(
                        'Group 3',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/groupVault');
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 3,
                    child: const ListTile(
                      title: Text(
                        'Group 4',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/groupVault');
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 3,
                    child: const ListTile(
                      title: Text(
                        'Group 5',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        parentContext: context,
        currentIndex: 1,
      ),
    );
  }
}
void main() {
  runApp(MaterialApp(
    home: GroupListScreen(),
  ));
}

