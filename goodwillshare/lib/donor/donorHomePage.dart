import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DonorHomePage extends StatefulWidget {
  const DonorHomePage({Key? key}) : super(key: key);

  @override
  State<DonorHomePage> createState() => _DonorHomePageState();
}

class _DonorHomePageState extends State<DonorHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    String userEmail = currentUser?.email ?? 'anonymous';

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.teal,
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Accepted Food'),
                Tab(text: 'Expired Food'),
              ],
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAcceptedFoodTab(userEmail),
                _buildExpiredFoodTab(userEmail),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAcceptedFoodTab(String userEmail) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('doner_accept')
          .doc(userEmail)
          .collection('accepted')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No accepted food data available'));
        }

        List<DocumentSnapshot> donationList = snapshot.data!.docs;

        return ListView.builder(
          itemCount: donationList.length,
          itemBuilder: (context, index) {
            DocumentSnapshot document = donationList[index];
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;

            return _buildDonationCard(data, document.id); // Call custom widget to display data
          },
        );
      },
    );
  }

  Widget _buildExpiredFoodTab(String userEmail) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    return ListView.builder(
      itemCount: 3, // Replace with actual expired food length if you're pulling from Firestore
      itemBuilder: (context, index) {
        String expiredFoodItem = 'Expired Item ${index + 1}'; // Replace with actual expired items
        return ListTile(
          title: Text(expiredFoodItem),
          trailing: ElevatedButton(
            onPressed: () async {
              if (currentUser != null) {
                await FirebaseFirestore.instance
                    .collection('expired_food')
                    .doc(userEmail)
                    .collection('accepted')
                    .add({'FoodName': expiredFoodItem});
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('$expiredFoodItem added to organic harvesters'),
                ));
              }
            },
            child: const Text('Add to Organic Harvesters'),
          ),
        );
      },
    );
  }

  Widget _buildDonationCard(Map<String, dynamic> donation, String donationId) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(donation['foodName'] ?? 'Unknown Food'),
              subtitle: Text(
                'Quantity: ${donation['foodQuantity'] ?? 'N/A'}\n'
                'Expiry: ${donation['foodExpiry'] ?? 'N/A'}\n'
                'Address: ${donation['address'] ?? 'N/A'}\n'
                'Contact: ${donation['contact'] ?? 'N/A'}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key); // Added const constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Chat Messages'),
      ),
    );
  }
}
