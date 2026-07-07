# 🔐 POLITIQUE DE CONFIDENTIALITÉ - CABINET MÉDICAL

## 1. Acteurs du système

| Utilisateur | Rôle | Accès |
|-------------|------|-------|
| **Médecin traitant** | Médecin principal du patient | Accès complet à ses patients |
| **Médecin collègue** | Médecin du cabinet | Consultation des autres patients |
| **Secrétaire** | Gestion administrative | Création/Modification des patients |
| **Administrateur** | Gestion du système | Accès total |

## 2. Matrice des autorisations

| Table | Médecin traitant | Médecin collègue | Secrétaire | Admin |
|-------|------------------|------------------|------------|-------|
| **PATIENT** | Lecture/Ecriture (ses patients) | Lecture (tous) | Lecture/Ecriture | Lecture/Ecriture |
| **VISITE** | Lecture/Ecriture (ses patients) | Lecture (tous) | Lecture | Lecture/Ecriture |
| **PRESCRIPTION** | Lecture/Ecriture (ses patients) | Lecture (tous) | Lecture | Lecture/Ecriture |
| **MEDICAMENT** | Lecture | Lecture | Lecture | Lecture/Ecriture |
| **ALLERGIE** | Lecture/Ecriture (ses patients) | Lecture (tous) | Lecture | Lecture/Ecriture |

## 3. Vues SQL pour la confidentialité

- `Vue_Patients_Medecin` : Un médecin voit uniquement ses patients
- `Vue_Patients_Cabinet` : Un médecin peut consulter les patients des collègues
- `Vue_Secretaire` : La secrétaire a des informations limitées