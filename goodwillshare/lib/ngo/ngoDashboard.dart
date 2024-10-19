import 'package:flutter/material.dart';
import 'package:goodwillshare/ngo/ngoAcceptPage.dart';
import 'package:goodwillshare/ngo/ngoPage.dart';

class NGO_Dashboard extends StatefulWidget {
  @override
  _NGO_DashboardState createState() => _NGO_DashboardState();
}

class _NGO_DashboardState extends State<NGO_Dashboard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      NGO_Page(),
      NGO_Accept_Page(),
      // RequestPage(),
      // NotificationsPage(),
    ];

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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.add),
          //   label: 'Post',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.notifications),
          //   label: 'Notification',
          // ),
        ],
      ),
    );
  }

  // This is a placeholder for the accepted items list
  Widget _buildAcceptedItems() {
    return Center(
      child: Text('Accepted Items will be shown here'),
    );
  }
}
