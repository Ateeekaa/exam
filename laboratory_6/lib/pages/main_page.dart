import 'package:flutter/material.dart';
import 'package:laboratory_6/model/user.dart';
import 'package:laboratory_6/pages/home_page.dart';
import 'package:laboratory_6/pages/placeholder_page.dart';
import 'package:laboratory_6/pages/settings_page.dart';
import 'package:laboratory_6/pages/user_info_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register_form_page.dart';

// ✅ Добавьте это:
class MainPage extends StatefulWidget {
  // ignore: use_super_parameters
  const MainPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  User? registeredUser;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      registeredUser = User(
        name: prefs.getString('fullName') ?? '',
        email: prefs.getString('email') ?? '',
        phone: prefs.getString('phone') ?? '',
        country: prefs.getString('country') ?? '',
        password: prefs.getString('password') ?? '',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      RegisterFormPage(
        onRegistered: (user) {
          setState(() {
            registeredUser = user;
            _selectedIndex = 3;
          });
        },
      ),
      const HomePage(),
      const SettingsPage(),
      registeredUser != null
          ? UserInfoPage(userInfo: registeredUser!)
          : const PlaceholderPage(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[800],
        unselectedItemColor: Colors.green[200],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.app_registration), label: 'Register'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User Info'),
        ],
      ),
    );
  }
}
