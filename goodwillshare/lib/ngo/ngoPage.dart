import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NGO_Page extends StatefulWidget {
  const NGO_Page({super.key});

  @override
  State<NGO_Page> createState() => _NGO_PageState();
}

class _NGO_PageState extends State<NGO_Page> {
  int _selectedIndex = 0; // This will handle selected tab, if needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NGO Page"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('donations').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data available'));
          }

          List<DocumentSnapshot> donationList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: donationList.length,
            itemBuilder: (context, index) {
              // Get each individual document
              DocumentSnapshot document = donationList[index];

              // Get data from the document
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              // Now pass this data to a custom widget
              return _buildDonationCard(data);
            },
          );
        },
      ),
    );
  }

  Widget _buildDonationCard(Map<String, dynamic> donation) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(8),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_selectedIndex ==
                    0) // Only show 'Accept' button for pending items
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement accept functionality
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
}
