
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stash_fund/components/auth_provider.dart';
import 'package:stash_fund/screens/login.dart';
import 'package:stash_fund/screens/signup.dart';
import 'package:stash_fund/screens/categories.dart';
import 'package:stash_fund/screens/form.dart';
import 'package:stash_fund/screens/pay.dart';
import 'package:stash_fund/screens/profile.dart';
import 'package:stash_fund/screens/groupVault.dart';
import 'package:stash_fund/screens/needsandwants.dart';
import 'package:stash_fund/screens/savings.dart';
import 'package:stash_fund/screens/manual_entry.dart';
import 'package:stash_fund/screens/Grouplist.dart';
import 'package:stash_fund/components/savings_chart.dart';
import 'package:stash_fund/components/navbar.dart';
import 'package:stash_fund/components/AnimatedTextButton.dart';
import 'package:stash_fund/components/streak_widget.dart';
import 'package:stash_fund/services/geminiService.dart';
import 'package:stash_fund/services/goalService.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MyApp(),
    ),
  );
}


class SavingsChartCard extends StatefulWidget {
  @override
  _SavingsChartCardState createState() => _SavingsChartCardState();
}

class _SavingsChartCardState extends State<SavingsChartCard> {
  late Future<List<CircleConfig>> _circlesFuture;

  @override
  void initState() {
    super.initState();
    _circlesFuture = _fetchCircleConfigs();
  }

  Future<List<CircleConfig>> _fetchCircleConfigs() async {
    try { 
      final goalService = GoalService();
      final userId = "6749954e5c6f1e3fc91d100f"; // Replace with the actual user ID
      final response = await goalService.getGoals(userId);
    
      print(response);
      var i=0;
      if (response["success"]) {
        final goals = response["goals"];
        return goals.map<CircleConfig>((goal) {
          i=i+1;
          final progress = goal["spentAmount"] / goal["targetAmount"];
          return CircleConfig(
            progress: progress.clamp(0.0, 1.0), // Ensure progress is between 0 and 1
            gradient: _getGradientForGoalType(goal["type"]),
            size: 100+(i * 25), // Dynamic size based on progress
            stroke: 10,
          );
        }).toList();
      } else {
        throw Exception(response["message"]);
      }
    } catch (error) {
      print("Error fetching goals: $error");
      return [];
    }
  }

  LinearGradient _getGradientForGoalType(String type) {
  switch (type) {
    case 'Dining Out':
      return LinearGradient(colors: [Colors.orange, Colors.deepPurpleAccent]);
    case 'Shopping':
      return LinearGradient(colors: [Colors.pinkAccent, Colors.yellowAccent]);
    case 'Entertainment':
      return LinearGradient(colors: [Colors.cyan, Colors.deepOrangeAccent]);
    case 'Movies':
      return LinearGradient(colors: [Colors.indigo, Colors.purpleAccent]);
    case 'Vacation':
      return LinearGradient(colors: [Colors.lightGreenAccent, Colors.blue]);
    case 'Rent':
      return LinearGradient(colors: [Colors.grey, Colors.brown]);
    case 'Food':
      return LinearGradient(colors: [Colors.redAccent, Colors.lightBlueAccent]);
    case 'Transportation':
      return LinearGradient(colors: [Colors.blueGrey, Colors.greenAccent]);
    case 'Utilities':
      return LinearGradient(colors: [Colors.teal, Colors.amberAccent]);
    case 'Insurance':
      return LinearGradient(colors: [Colors.deepOrange, Colors.pinkAccent]);
    default:
      return LinearGradient(colors: [Colors.black87, Colors.white70]);
  }
}


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/savings');
        },
        child: Card(
          color: Colors.white,
          child: FutureBuilder<List<CircleConfig>>(
            future: _circlesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error loading savings chart"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text("No savings goals available"));
              } else {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(18),
                      child: SavingsChart(circles: snapshot.data!),
                    ),
                    Text(
                      "Savings",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/groupList':
            return _createRoute(GroupListScreen());
          case '/manualentry':
            return _createRoute(ManualPage());
          case '/savings':
            return _createRoute(SavingsPage());
          case '/needsandwants':
            return _createRoute(EmptyPage());
          case '/home':
            return _createRoute(HomeScreen());
          case '/categories':
            return _createRoute(CategoriesPage());
          case '/form':
            return _createRoute(BudgetForm());
          case '/groupVault':
            return _createRoute(GroupVaultScreen());
          case '/pay':
            return _createRoute(PayScreen());
          case '/profile':
            return _createRoute(ProfileScreen());
          case '/signup':
            return _createRoute(SignupScreen());
          case '/login':
            return _createRoute(LoginScreen());
          default:
            return null;
        }
      },
    );
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Start from right to left
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF4F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFEDF4F2),
        elevation: 0,
        toolbarHeight: 100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0, right: 30),
              child: _buildScanToPayButton(context),
            ),
            GestureDetector(
              onTap: () {
                _showNotificationDialog(context);
              },
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_animation.value, 0),
                    child: child,
                  );
                },
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(right: 140),
                child: AnimatedTextButton(
                  text: 'Log Untracked Expenses ->',
                  route: '/manualentry',
                ),
              ),
              SizedBox(height: 20),
              SavingsChartCard(),
              SizedBox(height: 20),
              StreakWidget(),

            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        parentContext: context,
        currentIndex: 0,
      ),
    );
  }

 void _showNotificationDialog(BuildContext context) async {
  var co = GeminiService();
    // Fetch content for Rent and Movies
  // final a = await co.generateContent("6749954e5c6f1e3fc91d100f", "Rent", "alert");
  // final q = await co.generateContent("6749954e5c6f1e3fc91d100f", "Movies", "question");
  // List of categories
  final categories = ["Vacation", "Rent", "Dining Out", "Movies"];

  // Create a Random object
  final random = Random();

  // Randomly pick an index within the list of categories
  final randomIndex1 = random.nextInt(categories.length);
  final randomIndi2 = random.nextInt(categories.length);

  // Get the random category
  final randi1 = categories[randomIndex1];
  final randi2 = categories[randomIndi2];

   // Generate content based on the random category
  final a = await co.generateContent("6749954e5c6f1e3fc91d100f", randi1, "alert");
  final q = await co.generateContent("6749954e5c6f1e3fc91d100f", randi2, "question");
  // Extract relevant text content from the responses 
  final Content1 = a['data']['candidates'][0]['content']['parts'][0]['text'] ?? 'No content available';
  final Content2 = q['data']['candidates'][0]['content']['parts'][0]['text'] ?? 'No content available';

  // Display the dialog
   showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFF31473A), // Set background color
      title: Row(
        children: [
          Container(
            width: 40, // Set the desired width
            height: 40, // Set the desired height
            child: ClipRect(
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain, // Adjust the fit property as needed
              ),
            ),
          ),
          SizedBox(width: 10), // Add spacing between logo and text
          Text(
            'Hello User',
            style: TextStyle(
              color: Colors.white, // Set text color to white
              fontFamily: 'Helvetica', // Set font to Helvetica
            ),
          ),
        ],
      ),
      content: SingleChildScrollView( // Make content scrollable
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
          children: [
            Text(
              "$Content1",
              style: TextStyle(
                color: Colors.white, // Set text color to white
                fontFamily: 'Helvetica', // Set font to Helvetica
              ),
            ),
            SizedBox(height: 10),
            Divider(
              color: Colors.white, // Set divider color to white
              thickness: 1, // Adjust thickness
            ),
            SizedBox(height: 10),
            Text(
              "$Content2",
              style: TextStyle(
                color: Colors.white, // Set text color to white
                fontFamily: 'Helvetica', // Set font to Helvetica
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Your response',
                labelStyle: TextStyle(
                  color: Colors.white70, // Set label text color
                  fontFamily: 'Helvetica', // Set font to Helvetica
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // White border
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // White border when focused
                ),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(
                color: Colors.white, // Text color inside TextField
                fontFamily: 'Helvetica', // Set font to Helvetica
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Send',
            style: TextStyle(
              color: Colors.white, // Set button text color
              fontFamily: 'Helvetica', // Set font to Helvetica
            ),
          ),
        ),
      ],
    );
  },
);

}

  Widget _buildScanToPayButton(BuildContext context) {
    return SizedBox(
      width: 270,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, '/pay');
        },
        icon: Icon(Icons.qr_code_scanner, color: Color.fromARGB(255, 50, 171, 54)),
        label: Text(
          'Scan to pay',
          style: TextStyle(color: Color(0xFF31473A)),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightGreen[100],
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
