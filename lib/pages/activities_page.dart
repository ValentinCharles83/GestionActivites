import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'activity_detail_page.dart';

class ActivitiesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activités"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('activites').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Erreur lors du chargement des activités');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Card(
                child: ListTile(
                  leading: Image.network(data['imageUrl'] ?? 'URL_image_par_defaut'),
                  title: Text(data['title'] ?? 'Titre non disponible'),
                  subtitle: Text(data['location'] ?? 'Lieu non disponible'),
                  trailing: Text(data['price'] != null
                      ? "${data['price']}€"
                      : 'Prix non disponible'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ActivityDetailPage(
                              title: data['title'] ?? 'Titre non disponible',
                              location:
                                  data['location'] ?? 'Lieu non disponible',
                              price: data['price'] ??
                                  0, // Assurez-vous que 'price' est un int
                              activityId: document
                                  .id, // Utilisez document.id pour l'ID de l'activité
                              type: data['type'] ??
                                  'Type non disponible', // Assurez-vous d'avoir un champ 'type' dans vos documents Firestore
                              imageUrl: data['imageUrl'] ?? 'image non disponible',
                              minPeople: data['minPeople'] ?? 0,

                            )));
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
