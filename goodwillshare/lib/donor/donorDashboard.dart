import 'package:flutter/material.dart';
import 'addnewDonation.dart'; // Import the addnewDonation page

class DonorDashboard extends StatefulWidget {
  const DonorDashboard({Key? key}) : super(key: key);

  @override
  State<DonorDashboard> createState() => _DonorDashboardState();
}

class _DonorDashboardState extends State<DonorDashboard> {
  // Sample data for food lists
  final List<String> acceptedFood = ['Pizza', 'Pasta', 'Bread'];
  final List<String> expiredFood = ['Fruits', 'Vegetables', 'Canned Goods'];

  int _selectedIndex = 0;

  // Navigation handler for BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) { // Check if 'Add' tab is selected
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => addnewDonation()), // Navigate to the addnewDonation page
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text(
                'Donor Name', // Replace with donor's name from your backend
                style: const TextStyle(fontSize: 18),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chat),
              onPressed: () {
                // Navigate to chat screen
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
              },
            )
          ],
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Accepted Donations',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: acceptedFood.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(acceptedFood[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.chat),
                      onPressed: () {
                        // Navigate to chat screen with selected food
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Expired',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: expiredFood.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(expiredFood[index]),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Add item to organic harvesters
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('${expiredFood[index]} added to organic harvesters'),
                        ));
                      },
                      child: const Text('Add to Organic Harvesters'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 30),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(
                  'https://example.com/profile_photo'), // Replace with the fetched profile photo URL
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Dummy chat screen for navigation
class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: const Center(
        child: Text('Chat Messages'),
      ),
    );
  }
}
