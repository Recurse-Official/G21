import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pay');
              },
              child: Text('Go to Pay'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/missions');
              },
              child: Text('Go to Missions'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/savings');
              },
              child: Text('Go to Savings'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: Text('Go to Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

// class dashboard extends StatefulWidget {
//   const dashboard({super.key});

//   @override
//   State<dashboard> createState() => _dashboardState();
// }

// class _dashboardState extends State<dashboard> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       center:
//     );
//   }
// }

// class DashboardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dashboard'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: GridView.count(
//           crossAxisCount: 2, // Number of columns
//           crossAxisSpacing: 16.0,
//           mainAxisSpacing: 16.0,
//           children: [
//             _buildDashboardCard(
//               title: 'Profile',
//               icon: Icons.person,
//               color: Colors.blue,
//               onTap: () {
//                 // Navigate to Profile
//                 print("Profile tapped");
//               },
//             ),
//             _buildDashboardCard(
//               title: 'Settings',
//               icon: Icons.settings,
//               color: Colors.green,
//               onTap: () {
//                 // Navigate to Settings
//                 print("Settings tapped");
//               },
//             ),
//             _buildDashboardCard(
//               title: 'Messages',
//               icon: Icons.message,
//               color: Colors.orange,
//               onTap: () {
//                 // Navigate to Messages
//                 print("Messages tapped");
//               },
//             ),
//             _buildDashboardCard(
//               title: 'Notifications',
//               icon: Icons.notifications,
//               color: Colors.red,
//               onTap: () {
//                 // Navigate to Notifications
//                 print("Notifications tapped");
//               },
//             ),
//             _buildDashboardCard(
//               title: 'Reports',
//               icon: Icons.bar_chart,
//               color: Colors.purple,
//               onTap: () {
//                 // Navigate to Reports
//                 print("Reports tapped");
//               },
//             ),
//             _buildDashboardCard(
//               title: 'Help',
//               icon: Icons.help,
//               color: Colors.teal,
//               onTap: () {
//                 // Navigate to Help
//                 print("Help tapped");
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Helper method to build a reusable dashboard card
//   Widget _buildDashboardCard({
//     required String title,
//     required IconData icon,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.9),
//           borderRadius: BorderRadius.circular(16.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.3),
//               blurRadius: 10,
//               offset: Offset(2, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               icon,
//               size: 48.0,
//               color: Colors.white,
//             ),
//             SizedBox(height: 12.0),
//             Text(
//               title,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }