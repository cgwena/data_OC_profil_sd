# 🎓 Projet : Profil Sociodémographique des Étudiants Data (OpenClassrooms x INSEE)

## 📌 Objectif du projet
Ce projet dbt a pour but d'analyser le profil sociodémographique des étudiants en formation Data chez OpenClassrooms (2022-2025). Pour donner du sens aux effectifs, les données internes des étudiants sont croisées et enrichies avec les indicateurs macro-économiques publics de l'INSEE (taux de chômage par âge, genre et région).

L'objectif final est de fournir une table de dimension propre et fiable (`dim_students`) pour alimenter les tableaux de bord et orienter la stratégie d'inclusion d'OpenClassrooms.

---

## 🏗️ Architecture du Workflow dbt

Le pipeline de données suit les meilleures pratiques de modélisation en 3 couches (Staging, Intermediate, Marts) :

### 1. Couche Staging (`stg_`) : Nettoyage et Standardisation
Cette couche ingère les données brutes et effectue le premier nettoyage technique, sans altérer la granularité.
* **`stg_students_info`** : Nettoyage des données internes (anonymisation implicite des ID, formatage).
* **`stg_insee_chomage_*` (Age, Genre, Region)** : Les données de l'INSEE arrivent souvent sous format texte (avec des virgules). Une macro Jinja personnalisée (`replace_comma`) a été développée pour nettoyer ces chaînes de caractères et les convertir en format numérique exploitable de manière dynamique. Les colonnes ont également été renommées pour correspondre aux standards internes (ex: "Femmes" -> "F").

### 2. Couche Intermediate (`int_`) : Transformation Métier
Cette couche contient la logique métier complexe et la préparation aux jointures.
* **Fonction UNPIVOT** : Les données INSEE étaient initialement au format "Large" (Wide - une colonne par trimestre ou par catégorie). Elles ont été basculées au format "Long" (une ligne par observation) via la fonction `UNPIVOT` pour permettre les jointures par année.
* **Agrégration annuelle** : Calcul des moyennes annuelles des taux de chômage.
* **Mapping Géographique** : Regroupement spécifique des départements d'outre-mer sous une entité unique `DROM` pour éviter la duplication des données (Fan-out) lors des jointures finales, et correction de la casse (ex: "GRAND EST").

### 3. Couche Mart / Dimension (`dim_`) : Le Produit Data Final
* **`dim_students`** : La table "Gold". Elle part de la base étudiante (`student_year_id`) et vient s'enrichir via des `LEFT JOIN` avec les trois tables intermédiaires de l'INSEE. C'est cette table unique qui est connectée à l'outil de Data Visualisation.

---

## 📊 Graphe de Lignage (DAG)

<img width="1371" height="597" alt="Capture d’écran 2026-04-12 à 21 23 02" src="https://github.com/user-attachments/assets/3d1b5929-2deb-4127-ab81-5f064068a9ac" />


---

## 🛡️ Assurance Qualité et Tests

La fiabilité des données est garantie par une suite de tests rigoureux implémentés dans les fichiers `.yml` et via des requêtes SQL personnalisées :

* **Tests d'intégrité** : `not_null` sur les clés primaires et les colonnes critiques (Année, Région).
* **Tests d'unicité** : `unique` sur la clé primaire `student_year_id` dans la table finale pour s'assurer de l'absence de *fan-out* (dédoublonnage accidentel suite aux jointures).
* **Tests de validité (Accepted Values)** : Vérification stricte des formats de l'âge Insee (`15-24 ans`, `25-49 ans`, `50 ans ou plus`) et du genre (`F`, `M`, `unknown`).

---

## 🚀 Comment exécuter ce projet

1. **Générer les tables et exécuter les tests :**
   ```bash
   dbt build
