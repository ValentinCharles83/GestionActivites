import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    _emailController.text = user?.email ?? 'Non disponible';
    _passwordController.text = "********"; // Placeholder pour le mot de passe
    loadUserProfile();
  }

  void loadUserProfile() async {
    if (user != null) {
      DocumentSnapshot userProfile = await FirebaseFirestore.instance
          .collection('utilisateurs')
          .doc(user!.uid)
          .get();
      Map<String, dynamic> data = userProfile.data() as Map<String, dynamic>;
      _birthdayController.text = data['anniversaire'] ?? '';
      _addressController.text = data['adresse'] ?? '';
      _postalCodeController.text = data['code postal'] ?? '';
      _cityController.text = data['ville'] ?? '';
      setState(
          () {}); // Mettez à jour l'interface utilisateur avec les données chargées
    }
  }

  void updateUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('utilisateurs')
          .doc(user.uid)
          .update({
        'anniversaire': _birthdayController.text,
        'adresse': _addressController.text,
        'code postal': _postalCodeController.text,
        'ville': _cityController.text,
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profil mis à jour avec succès')),
        );
      }).catchError((error) {
        // Gérez l'erreur ici
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la mise à jour')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Utilisateur'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              readOnly: true, // Rend le champ en lecture seule
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              readOnly: true, // Rend le champ en lecture seule
              obscureText: true, // Offusque le mot de passe
            ),
            TextField(
                controller: _birthdayController,
                decoration: InputDecoration(labelText: 'Anniversaire')),
            TextField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Adresse')),
            TextField(
                controller: _postalCodeController,
                decoration: InputDecoration(labelText: 'Code Postal')),
            TextField(
                controller: _cityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Ville')),
            ElevatedButton(
              onPressed: () {
                updateUserProfile();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Profil mis à jour')));
              },
              child: Text('Mettre à Jour'),
            ),
          ],
        ),
      ),
    );
  }
}
