import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DonorProfile extends StatefulWidget {
  @override
  _DonorProfileState createState() => _DonorProfileState();
}

class _DonorProfileState extends State<DonorProfile> {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Donor Profile'),
          backgroundColor: Colors.teal,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileInfo(), // Fetch and display donor name
              const SizedBox(height: 20),
              const Text(
                'My Donations',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(child: _buildDonorPosts()), // Fetch and display donations by the donor
            ],
          ),
        ),
      ),
    );
  }

  // Fetch and display donor's profile info (name and email)
  Widget _buildProfileInfo() {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('donors')
          .doc(currentUser!.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const Text('No Profile Info Found');
        }
        var donorData = snapshot.data!.data() as Map<String, dynamic>;
        String donorName = donorData['name'] ?? 'Donor';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: $donorName',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 5),
            Text(
              'Email: ${currentUser!.email}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        );
      },
    );
  }

  // Fetch and display donations posted by the current donor
  Widget _buildDonorPosts() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('donations')
          .where('donorEmail', isEqualTo: currentUser!.email)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('No Donations Found');
        }
        var donations = snapshot.data!.docs;

        return ListView.builder(
          itemCount: donations.length,
          itemBuilder: (context, index) {
            var donationData = donations[index].data() as Map<String, dynamic>;
            String foodName = donationData['foodName'];
            String foodQuantity = donationData['foodQuantity'];
            String foodExpiry = donationData['foodExpiry'];

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(foodName),
                subtitle: Text('Quantity: $foodQuantity\nExpiry: $foodExpiry'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteDonation(donations[index].id),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Function to delete a donation from Firebase
  Future<void> _deleteDonation(String donationId) async {
    await FirebaseFirestore.instance
        .collection('donations')
        .doc(donationId)
        .delete();

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Donation deleted successfully!')),
    );
  }
}
