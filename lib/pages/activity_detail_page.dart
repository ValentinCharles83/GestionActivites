import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ActivityDetailPage extends StatefulWidget {
  final String title;
  final String location;
  final int price;
  final String activityId; 
  final String type;
  final String imageUrl;
  final int minPeople;

  const ActivityDetailPage({
    Key? key,
    required this.title,
    required this.location,
    required this.price,
    required this.activityId,
    required this.type,
    required this.imageUrl,
    required this.minPeople,

  }) : super(key: key);

  @override
  _ActivityDetailPageState createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  @override
  void initState() {
    super.initState();
    saveActivityPreference(
        widget.activityId, widget.type, widget.price.toDouble());
  }

  void saveActivityPreference(String activityId, String type, double prix) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('utilisateurs')
          .doc(user.uid)
          .collection('preferences')
          .add({
        'activityId': activityId,
        'type': type,
        'prix': prix,
        'timestamp': FieldValue
            .serverTimestamp(),
      });
    }
  }

  void addToCart(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vous devez être connecté pour ajouter au panier.")));
    return;
  }
  FirebaseFirestore.instance.collection('paniers').doc(user.uid).collection('activites').doc(widget.activityId).set({
    'title': widget.title,
    'location': widget.location,
    'price': widget.price,
    'imageUrl': widget.imageUrl,
    'timestamp': FieldValue.serverTimestamp(),
  }).then((_) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Activité ajoutée au panier.")));
  }).catchError((error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erreur lors de l'ajout au panier : $error")));
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'type: ${widget.type}',
              style: TextStyle(fontSize: 20)),

            Text(
              'Lieu: ${widget.location}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Prix: ${widget.price}€',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Nombre minimum de personnes: ${widget.minPeople}', style: TextStyle(fontSize: 18)),
            ElevatedButton(
              onPressed: () => addToCart(context),
              child: Text('Ajouter au panier'),
            )
          ],
        ),
      ),
    );
  }
}
