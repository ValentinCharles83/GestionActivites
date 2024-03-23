import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/user_preferences_service.dart';
import 'package:flutter_application_1/pages/activity_detail_page.dart';

class SuggestionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suggestions d\'Activités'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: UserPreferencesService().getSuggestedActivities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Aucune suggestion disponible"));
          }
          final activities = snapshot.data!;
          // Ici, nous utilisons directement 'activities' qui est une List<Map<String, dynamic>>
          return ListView.builder(
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              return Card(
                child: ListTile(
                  leading: Image.network(activity['imageUrl'] ?? 'URL_image_par_defaut'),
                  title: Text(activity['title'] ?? 'Titre non disponible'),
                  subtitle: Text(activity['location'] ?? 'Lieu non disponible'),
                  trailing: Text(activity['price'] != null ? "${activity['price']}€" : 'Prix non disponible'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ActivityDetailPage(
                        imageUrl: activity['imageUrl'] ?? 'Image non disponible',
                        title: activity['title'] ?? 'Titre non disponible',
                        location: activity['location'] ?? 'Lieu non disponible',
                        price: activity['price'] ?? 0,
                        activityId: activity['id'], // Assurez-vous que 'id' est inclus dans les données renvoyées par getSuggestedActivities
                        type: activity['type'] ?? 'Type non spécifié',
                        minPeople: activity['minPeople'] ?? 0,
                      ),
                    ));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
