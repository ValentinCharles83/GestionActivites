import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text("Mon Panier"),
      ),
      body: user == null
          ? Center(child: Text("Vous devez être connecté."))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('paniers')
                  .doc(user.uid)
                  .collection('activites')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                final activities = snapshot.data!.docs;
                double total = 0;
                activities.forEach((doc) {
                  total += doc['price'];
                });

                return Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: activities
                            .map((doc) => ListTile(
                                  leading: Image.network(doc['imageUrl'],
                                      width: 100,
                                      height: 56,
                                      fit: BoxFit.cover),
                                  title: Text(doc['title']),
                                  subtitle: Text(doc['location']),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize
                                        .min, // Empêche le débordement
                                    children: [
                                      Text(
                                          "${doc['price']}€"), // Assurez-vous que data['price'] retourne bien un nombre.
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () => removeFromCart(
                                            user.uid,
                                            doc.id), // Vérifiez que user.uid et doc.id sont valides.
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(), // Convertit l'Iterable en List
                      ),
                    ),
                    Text("Total: $total€"),
                  ],
                );
              },
            ),
    );
  }

  void removeFromCart(String userId, String activityId) {
    FirebaseFirestore.instance
        .collection('paniers')
        .doc(userId)
        .collection('activites')
        .doc(activityId)
        .delete();
  }
}
