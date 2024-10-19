import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Map<String, String>> donations = [
    {
      'foodName': 'Rice',
      'foodQuantity': '10 kg',
      'foodExpiry': '2023-12-31',
      'address': '123 Main St, City',
      'contact': '555-1234',
      'status': 'pending',
    },
    {
      'foodName': 'Canned Vegetables',
      'foodQuantity': '20 cans',
      'foodExpiry': '2024-06-30',
      'address': '456 Elm St, Town',
      'contact': '555-5678',
      'status': 'accepted',
    },
    {
      'foodName': 'Bread',
      'foodQuantity': '15 loaves',
      'foodExpiry': '2023-11-15',
      'address': '789 Oak St, Village',
      'contact': '555-9012',
      'status': 'pending',
    },
    {
      'foodName': 'Pasta',
      'foodQuantity': '25 packets',
      'foodExpiry': '2024-03-20',
      'address': '101 Pine St, Suburb',
      'contact': '555-3456',
      'status': 'accepted',
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildDonationCard(Map<String, String> donation) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(donation['foodName']!),
              subtitle: Text(
                'Quantity: ${donation['foodQuantity']}\n'
                'Expiry: ${donation['foodExpiry']}\n'
                'Address: ${donation['address']}\n'
                'Contact: ${donation['contact']}',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_selectedIndex == 0) // Only show 'Add to Cart' for pending items
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement add to cart functionality
                      print('Accept: ${donation['foodName']}');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amberAccent,
                    ),
                    child: Text('Accept'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'NGO Dashboard' : 'Accepted Items'),
        backgroundColor: Color.fromARGB(255, 195, 202, 243),
        actions: [
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {
              // TODO: Implement chat functionality
              print('Open chat');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: donations.length,
              itemBuilder: (context, index) {
                final donation = donations[index];
                if (_selectedIndex == 0 || (_selectedIndex == 1 && donation['status'] == 'accepted')) {
                  return _buildDonationCard(donation);
                } else {
                  return SizedBox.shrink(); // Don't show if it doesn't match the current view
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Accepted Items',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
       // Only show FAB in dashboard view
    );
  }
}