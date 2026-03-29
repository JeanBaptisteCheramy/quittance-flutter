# Revue de l'application Quittance

## Objectif

Application Flutter de gestion de quittances de loyer pour les propriétaires. Fonctionne entièrement en local via SQLite (pas de backend externe).

---

## Architecture

L'app suit une architecture en couches propre :

```
UI (Screens) → Service → Repository → DatabaseHelper (SQLite)
```

- **`database/`** — Singleton `DatabaseHelper` qui gère la BDD SQLite (`quittance.db`)
- **`models/`** — Modèles de données avec sérialisation `toMap()` / `fromMap()`
- **`repository/`** — Accès BDD, implémentent `InterfaceRepository<T>`
- **`service/`** — Couche métier, wrappent les repositories
- **`components/`** — UI : écrans et composants communs
- **`utils/`** — Validateurs de formulaires

---

## Base de données (SQLite)

4 tables définies dans `database_helper.dart` :

| Table | Colonnes clés |
|---|---|
| `owners` | id, lastname, firstname, address |
| `renters` | id, firstname, lastname, address |
| `rentals` | id, address, owner_id (FK), renter_id (FK) |
| `quittances` | id, rental_id (FK), date_quittance, start_date, end_date, rent, charges, energy_saving, total, total_letter, payment_date |

---

## État du développement par fonctionnalité

### Propriétaire (Owner) — Complet
- Modèle, repository, service : OK
- Pattern singleton (id forcé à 1, un seul propriétaire)
- Écran `AccountScreen` : affichage + édition + sauvegarde fonctionnels
- Validation des champs

### Locataires (Renter) — Partiellement fonctionnel
- Modèle, repository, service : OK
- `RentersScreen` : liste des locataires affichée, bouton ajout, bouton édition
- `RenterForm` : création fonctionnelle
- **TODO** : La mise à jour (edit) ne fonctionne pas — le formulaire ignore l'`id` et crée toujours un nouveau locataire
- **TODO** : Le bouton supprimer est présent mais non connecté

### Locations (Rentals) — Non implémenté
- Table BDD créée
- `RentalsScreen` : écran vide (stub)
- Aucun modèle, repository ni service créés

### Quittances — Non implémenté
- Table BDD créée
- `QuittancesScreen` : écran vide, FAB désactivé
- Aucun modèle, repository ni service créés
- Dépendance `flutter_to_pdf` déjà ajoutée dans `pubspec.yaml`

---

## Navigation

GoRouter avec les routes suivantes :

| Route | Écran |
|---|---|
| `/` | QuittancesScreen |
| `/account` | AccountScreen |
| `/renters` | RentersScreen |
| `/rentals` | RentalsScreen |
| `/renterForm` | RenterForm (création) |
| `/renterForm/:id` | RenterForm (édition, paramètre optionnel) |

Navigation par bottom navigation bar (3 onglets : Quittances, Locations, Locataires).

---

## UI / Thème

- Palette : violet foncé (primary), violet clair (secondary), orange/brun (tertiary)
- `CustomAppBar` : barre d'app avec bouton compte et bouton retour configurables
- `CustomBottomNavigationBar` : 3 onglets avec highlighting de la route active
- Extensions de thème custom pour les couleurs d'état (disabled, validate, cancel)

---

## Dépendances notables

| Package | Usage |
|---|---|
| `sqflite ^2.3.0` | BDD SQLite locale |
| `go_router ^17.0.1` | Navigation |
| `flutter_to_pdf ^0.4.1` | Export PDF (pas encore utilisé) |

---

## Résumé — Ce qui reste à faire

1. **Renter update** — Corriger `RenterForm` pour charger et sauvegarder avec l'`id` existant
2. **Renter delete** — Connecter le bouton supprimer au `RenterService`
3. **Rentals** — Modèle, repository, service, écran CRUD complet
4. **Quittances** — Modèle, repository, service, écran CRUD complet + génération PDF via `flutter_to_pdf`
5. **Lien Rental ↔ Renter ↔ Owner** — La quittance doit agréger les données des 3 entités
