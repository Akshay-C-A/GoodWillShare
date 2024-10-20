import 'package:flutter/material.dart';
import 'package:goodwillshare/auth/login.dart';
import 'package:goodwillshare/farmers/farmerpage.dart';
import 'package:goodwillshare/farmers/farmersacceptpage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrganicFarmersDashboard extends StatefulWidget {
  @override
  _OrganicFarmersDashboardState createState() => _OrganicFarmersDashboardState();
}

class _OrganicFarmersDashboardState extends State<OrganicFarmersDashboard> {
  int _selectedIndex = 0;

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false,
                  ); // Replace with your login route
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error logging out: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      OrganicFarmersPage(),
      OrganicHarvestersAcceptPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Organic Farmers Dashboard' : 'Accepted Items'),
        backgroundColor: const Color.fromARGB(255, 195, 202, 243),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat),
            onPressed: () {
              // TODO: Implement chat functionality
              print('Open chat');
            },
          ),
          // Add logout button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Show confirmation dialog before logging out
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Logout'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          _logout();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const SizedBox(width: 8), // Add some padding after the logout button
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Accepted',
          ),
        ],
      ),
    );
  }
}

// Placeholder for Organic Farmers home page
class OrganicFarmersHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Organic Farmers Home Page'),
    );
  }
}

// Placeholder for Organic Farmers accepted items page
class OrganicFarmersAcceptedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Accepted Items will be shown here'),
    );
  }
}