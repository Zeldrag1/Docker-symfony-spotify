# Infrastructure Docker - Projet Symfony Spotify

Ce projet met en œuvre une architecture conteneurisée complète pour une application Symfony (clone de Spotify). L'infrastructure est conçue pour être entièrement autonome, garantissant la persistance des données, leur initialisation automatique et leur sauvegarde régulière, conformément au cahier des charges.

## Prérequis

* Docker Desktop (ou Docker Engine + Docker Compose)
* Git

## Installation et Démarrage

Le projet est configuré pour être opérationnel immédiatement. Le fichier de configuration `.env` est inclus dans le dépôt pour faciliter le lancement sans étape manuelle.

**1. Lancement unique**
Ouvrez un terminal à la racine du projet et exécutez la commande suivante :

```bash
docker compose up -d --build

```

**2. Initialisation**
Le déploiement est entièrement automatisé. Le conteneur web se charge d'installer les dépendances Composer et de configurer la base de données.
Vous pouvez suivre l'avancement de l'initialisation avec la commande :

```bash
docker compose logs -f php-apache

```

*L'application est accessible dès que le serveur Apache est démarré.*

---

## Accès à l'application

### Application Web

* **URL :** http://localhost:8080
* **Compte de démonstration (pré-installé) :**
* Email : `test@test.com`
* Mot de passe : `test123`



### Gestion de la Base de Données (Adminer)

Une interface graphique est disponible pour administrer la base de données sans ligne de commande.

* **URL :** http://localhost:8085

**Identifiants de connexion :**

| Paramètre | Valeur |
| --- | --- |
| **Système** | MySQL / MariaDB |
| **Serveur** | `database` |
| **Utilisateur** | `symfony_user` |
| **Mot de passe** | `motdepasse123` |
| **Base de données** | `sportify` |

---

## Architecture et Points Forts

### 1. Persistance des Données

L'infrastructure utilise des volumes Docker nommés pour garantir que les données survivent au redémarrage ou à la suppression des conteneurs :

* `db-data` : Assure la persistance de la base de données MariaDB.
* `uploads-data` : Assure la persistance des fichiers médias (images, musiques) stockés dans le dossier `/public/uploads`.

### 2. Initialisation Automatique

Au premier lancement, le conteneur de base de données importe automatiquement le fichier `docker/database/init.sql`. Cela permet de livrer un projet contenant déjà des utilisateurs et des pistes audio, prêt à être testé immédiatement.

### 3. Système de Sauvegarde (Backup)

Un service dédié (`symfony_backup`) fonctionne en arrière-plan pour sécuriser les données.

* **Fonctionnalité :** Exécute un dump SQL complet et compresse le dossier des uploads (`.tar.gz`).
* **Fréquence :** Automatique toutes les heures.
* **Rétention :** Rotation automatique conservant les 14 dernières archives.
* **Localisation :** Les sauvegardes sont accessibles sur la machine hôte dans le dossier `./backup/`.

---

## Procédure de Restauration (Disaster Recovery)

En cas de suppression accidentelle des volumes (commande `down -v`), il est possible de restaurer l'intégralité du site grâce aux sauvegardes.

**Commande pour restaurer la base de données :**
(À exécuter à la racine du projet, en remplaçant `NOM_DU_FICHIER` par l'archive souhaitée située dans le dossier `backup/`)

```bash
gunzip -c backup/NOM_DU_FICHIER.sql.gz | docker exec -i symfony_db mariadb -u symfony_user -pmotdepasse123 sportify

