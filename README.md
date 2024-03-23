# Application de Gestion d'Activités - Valentin Charles

## Introduction

Ce projet est une application mobile développée avec Flutter, destinée à la gestion et à la suggestion d'activités pour les utilisateurs. Elle permet aux utilisateurs de consulter des activités, de les ajouter à leur panier, et reçoit des suggestions basées sur leurs préférences.

## User Stories Implémentées

### US#1 : Interface de Login

- Implémentation d'une interface de login avec Firebase Auth pour la gestion des utilisateurs.
- Les champs de saisie pour le login et le mot de passe, avec obfuscation pour ce dernier.
- Validation des champs pour assurer que l'utilisateur ne puisse se connecter avec des champs vides.

### US#2 : Liste des Activités

- Affichage d'une liste d'activités récupérées depuis Firestore, chaque activité présentant une image (URL), un titre, un lieu, et un prix.
- Navigation intégrée vers le détail de l'activité via un clic sur un élément de la liste.

### US#3 : Détail d'une Activité

- La page de détail montre une image, un titre, une catégorie, le lieu, le nombre de personnes minimum, et le prix de l'activité.
- Ajout de l'activité au panier possible grâce à un bouton "Ajouter au panier".
- Retour à la liste des activités via un bouton "Retour".

### US#4 : Le Panier

- Visualisation du panier avec la liste des activités ajoutées, chacune affichant une image, un titre, un lieu, et un prix.
- Affichage du total général des prix des activités dans le panier.
- Possibilité de retirer une activité du panier grâce à une icône de suppression.

### US#5 : Profil Utilisateur

- Page de profil permettant à l'utilisateur de voir et de modifier ses informations (à l'exception de l'email qui est en lecture seule et le mot de passe est offusqué).
- Les informations modifiables incluent l'anniversaire, l'adresse, le code postal (avec saisie numérique uniquement), et la ville.
- Boutons pour sauvegarder les modifications et pour se déconnecter.

### US#6 : IA Simpliste de Suggestions d'Activités

- Suggestions d'activités basées sur les préférences de l'utilisateur, déterminées par les activités précédemment consultées.
- Page de suggestions montrant une liste d'activités recommandées, avec une logique pour éviter les duplications.


## Conclusion

Cette application offre une base solide pour une application de gestion d'activités, avec des fonctionnalités clés pour la consultation, la sélection, et la suggestion d'activités basées sur les préférences des utilisateurs. L'architecture de l'application est conçue pour être extensible, permettant l'ajout de fonctionnalités supplémentaires et l'amélioration des fonctionnalités existantes.
