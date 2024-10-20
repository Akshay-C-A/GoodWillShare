import 'package:flutter/material.dart';
import 'package:goodwillshare/farmers/farmerpage.dart';
import 'package:goodwillshare/farmers/farmersacceptpage.dart';

class OrganicFarmersDashboard extends StatefulWidget {
  @override
  _OrganicFarmersDashboardState createState() => _OrganicFarmersDashboardState();
}

class _OrganicFarmersDashboardState extends State<OrganicFarmersDashboard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      OrganicFarmersPage(), // Replace with your organic farmers homepage widget
      OrganicHarvestersAcceptPage(), // Replace with the organic farmers accepted items widget
      // Add more pages if needed (requests, notifications, etc.)
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
    return Center(
      child: Text('Organic Farmers Home Page'),
    );
  }
}

// Placeholder for Organic Farmers accepted items page
class OrganicFarmersAcceptedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Accepted Items will be shown here'),
    );
  }
}
