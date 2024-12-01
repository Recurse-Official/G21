import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stash_fund/services/authService.dart';
import 'dart:convert';

import 'package:stash_fund/services/groupVaultService.dart'; // For decoding JSON

class GroupVaultScreen extends StatefulWidget {
  @override
  _GroupVaultScreenState createState() => _GroupVaultScreenState();
}

class _GroupVaultScreenState extends State<GroupVaultScreen> with SingleTickerProviderStateMixin {
  Map<String, dynamic>? group;
  var grp = GroupVaultService();
  bool isLoading = true;
  final userId = "6749954e5c6f1e3fc91d100f";
  var usr = AuthService();
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -5.0, end: 5.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticIn,
      ),
    );
    fetchGroupData();
  }

  Future<void> fetchGroupData() async {
    final prefs = await SharedPreferences.getInstance();
    final groupString = await prefs.getString('selectedGroup');
    print(jsonDecode(groupString!));
    final grou = await grp.getGroupVaultDetails(jsonDecode(groupString)["groupVaultId"]);
    print("grou: $grou");

    setState(() {
      group = grou["groupVault"];
      isLoading = false;
    });
  }

  Future<void> chipIn(String userId, double amount) async {
    final response = await grp.chipIn(group!["groupVaultId"], userId, amount, "personal_vault");
    if (response['success']) {
      setState(() {
        group!['contributions'][userId] =
            (group!['contributions'][userId] ?? 0) + amount;
        group!['totalAmount'] += amount;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully chipped in ₹$amount!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response["message"]}')),
      );
    }
  }

  Future<void> chipOut(String userId, double amount) async {
    final response = await grp.chipOut(group!["groupVaultId"], userId, amount);
    if (response['success']) {
      setState(() {
        group!['contributions'][userId] =
            (group!['contributions'][userId] ?? 0) - amount;
        group!['totalAmount'] -= amount;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully chipped out ₹$amount!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response["message"]}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Loading...'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (group == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('No group data found.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(group!['name']),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/groupList');
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_animation.value, 0),
                  child: child,
                );
              },
              child: GestureDetector(
                onTap: () {
                  _showNotificationDialog(context);
                },
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 40, // Adjust the width as needed for AppBar
                  height: 40, // Adjust the height as needed for AppBar
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green.withOpacity(0.2),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Total Savings',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '₹ ${group!['totalAmount'].toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => _buildChipInDialog(),
                          );
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Chip In'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => _buildChipOutDialog(),
                          );
                        },
                        icon: const Icon(Icons.remove),
                        label: const Text('Chip Out'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Contributions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: (group!['contributions'] as Map).length,
                itemBuilder: (context, index) {
                  final userId = group!['contributions'].keys.elementAt(index);
                  final amount = group!['contributions'][userId];

                  return FutureBuilder<Map<String, dynamic>>(
                    future: usr.findUser(userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError || !snapshot.hasData) {
                        return const Center(
                          child: Text('Error loading user data'),
                        );
                      }

                      final userData = snapshot.data!;
                      return ContributionCard(
                        name: userData['name'],
                        amount: amount,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => _buildAddUserDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildChipInDialog() {
    double amount = 0.0;
    return AlertDialog(
      title: const Text('Chip In'),
      content: TextField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(hintText: 'Enter amount'),
        onChanged: (value) {
          amount = double.tryParse(value) ?? 0.0;
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            chipIn(userId, amount);
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }

  Widget _buildChipOutDialog() {
    double amount = 0.0;
    return AlertDialog(
      title: const Text('Chip Out'),
      content: TextField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(hintText: 'Enter amount'),
        onChanged: (value) {
          amount = double.tryParse(value) ?? 0.0;
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            chipOut(userId, amount);
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }

  Widget _buildAddUserDialog() {
    String newUserId = '';
    return AlertDialog(
      title: const Text('Add User to Vault'),
      content: TextField(
        decoration: const InputDecoration(hintText: 'Enter User ID'),
        onChanged: (value) {
          newUserId = value;
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            if (newUserId.isNotEmpty) {
              chipIn(newUserId, 0);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('User ID cannot be empty!')),
              );
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  void _showNotificationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notification'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Question 1: How was your experience?'),
              SizedBox(height: 10),
              Text('Question 2: Any suggestions for improvement?'),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Your response',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Send'),
            ),
          ],
        );
      },
    );
  }
}

class ContributionCard extends StatelessWidget {
  final String name;
  final dynamic amount;

  ContributionCard({required this.name, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[300],
          child: const Icon(Icons.person, color: Colors.black54),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          '₹ ${amount is double ? amount.toStringAsFixed(2) : (amount+0.0).toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
