import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/profile_page.dart';
import 'activities_page.dart';
import 'suggestion_page.dart';
import 'package:flutter_application_1/pages/cart_page.dart'; // Mettez à jour le chemin en fonction de votre structure de projet

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Text('Accueil'),
    ActivitiesPage(),
    CartPage(),
    ProfilePage(),
    SuggestionsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application Flutter'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Force le type à fixed
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore, color: Colors.red),
            label: 'Activités',
          ),
          BottomNavigationBarItem(
            // Ici on utilise Icon(Icons.shopping_cart) directement pour le panier
            // et on applique la couleur rouge indépendamment de l'état de sélection
            icon: Icon(Icons.shopping_cart),
            label: 'Panier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Suggestions',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
