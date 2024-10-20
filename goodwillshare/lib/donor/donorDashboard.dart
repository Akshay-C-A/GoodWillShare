import 'package:flutter/material.dart';
import 'package:goodwillshare/donor/addnewDonation.dart';
import 'package:goodwillshare/donor/donorHomePage.dart';
import 'package:goodwillshare/donor/donorProfile.dart';

// Main Donor Dashboard page that acts as a navigation hub
class DonorDashboard extends StatefulWidget {
  const DonorDashboard({Key? key}) : super(key: key);

  @override
  State<DonorDashboard> createState() => _DonorDashboardState();
}

class _DonorDashboardState extends State<DonorDashboard> {
  int _selectedIndex = 0;

  // Pages for IndexedStack navigation
  List<Widget> widgetOptions = <Widget>[
    DonorHomePage(), // Home Page widget for accepted and rejected items
    addnewDonation(), // Add new donation form
    DonorProfile(), // Donor profile screen
  ];

  // Method to update the selected index on tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Dynamically change title based on selected tab
        title: Text(_selectedIndex == 0
            ? 'Donor Dashboard'
            : _selectedIndex == 1
                ? 'Add Donation'
                : 'Profile'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {
              // Placeholder for chat functionality
              print('Open chat');
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 30),
            label: 'Add Donation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
