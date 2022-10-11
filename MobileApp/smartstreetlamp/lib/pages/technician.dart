import 'package:flutter/material.dart';
import 'package:smartstreetlamp/pages/technicianhome.dart';
import 'package:smartstreetlamp/pages/tjobs.dart';
import 'package:smartstreetlamp/pages/tprofile.dart';


class Technician extends StatefulWidget{
@override
  _MState createState() => _MState();
}

class _MState extends State<Technician> {
PageController _pageController = PageController();
  List<Widget> _screens = [
    TechnicianHome(),
    TProfile(),
    TJobs(),
  ];
  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.build,
              color: _selectedIndex == 0 ? Colors.cyan : Colors.grey,
            ),
            title: Text(
              'Issues',
              style: TextStyle(
                  color: _selectedIndex == 0 ? Colors.cyan : Colors.grey),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_rounded,
              color: _selectedIndex == 1 ? Colors.cyan : Colors.grey,
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                  color: _selectedIndex == 1 ? Colors.cyan : Colors.blue),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.work,
              color: _selectedIndex == 2 ? Colors.cyan : Colors.grey,
            ),
            title: Text(
              'My Jobs',
              style: TextStyle(
                  color: _selectedIndex == 2 ? Colors.cyan : Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
