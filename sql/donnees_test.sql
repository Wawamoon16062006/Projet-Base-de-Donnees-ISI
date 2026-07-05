-- =============================================
-- DONNÉES DE TEST
-- =============================================

INSERT INTO MEDECIN (NomMed, PrenomMed) VALUES
('DUPONT', 'Jean'),
('MARTIN', 'Sophie'),
('DURAND', 'Pierre');

INSERT INTO PATIENT (NomPers, PrenomPers, DatNais, Poids, Taille, Adresse, IdMedecin_Traitant) VALUES
('LEFEBVRE', 'Marie', '1985-03-15', 65.5, 1.65, '12 rue de Paris, 75001 Paris', 1),
('BERTRAND', 'Thomas', '1990-07-22', 78.0, 1.80, '45 avenue des Champs, 75008 Paris', 1),
('ROUSSEAU', 'Claire', '1978-11-02', 58.2, 1.62, '8 rue de Lyon, 69002 Lyon', 2),
('FONTAINE', 'Lucas', '2005-12-10', 55.0, 1.70, '22 boulevard du Nord, 59000 Lille', 3),
('LAMBERT', 'Emma', '1995-09-30', 62.0, 1.68, '15 rue des Fleurs, 33000 Bordeaux', 2);

INSERT INTO MALADIE (NomMaladie) VALUES
('Diabète de type 2'),
('Hypertension artérielle'),
('Asthme'),
('Migraine chronique'),
('Arthrose');

INSERT INTO MEDICAMENT (NomMedoc, Categorie, Description) VALUES
('Paracétamol', 'Antalgique', 'Douleurs légères à modérées'),
('Amoxicilline', 'Antibiotique', 'Infections bactériennes'),
('Loratadine', 'Antihistaminique', 'Allergies saisonnières'),
('Ramipril', 'Antihypertenseur', 'Hypertension'),
('Salbutamol', 'Bronchodilatateur', 'Asthme'),
('Insuline', 'Antidiabétique', 'Diabète type 1 et 2'),
('Oméprazole', 'Inhibiteur pompe à protons', 'RGO, ulcère');

INSERT INTO ALLERGIE (IdPatient, IdMedoc) VALUES
(1, 3), (2, 2), (5, 3);

INSERT INTO SOUFFRE_DE (IdPatient, IdMaladie) VALUES
(1, 1), (1, 2), (2, 3), (3, 4), (4, 5);

INSERT INTO VISITE (DateVisite, Motif, Lieu, Prescrip, Analyses, Result, IdPatient, IdMedecin) VALUES
('2026-06-10 09:30:00', 'Consultation annuelle', 'Cabinet', TRUE, TRUE, FALSE, 1, 1),
('2026-06-15 14:00:00', 'Crise d''asthme', 'Cabinet', TRUE, FALSE, FALSE, 2, 1),
('2026-06-18 11:00:00', 'Douleurs chroniques', 'Cabinet', FALSE, TRUE, FALSE, 3, 2),
('2026-06-20 16:30:00', 'Visite à domicile', 'Domicile', TRUE, FALSE, FALSE, 4, 3),
('2026-06-22 10:00:00', 'Contrôle tension', 'Cabinet', TRUE, TRUE, TRUE, 1, 1),
('2026-06-25 09:00:00', 'Allergies printanières', 'Cabinet', TRUE, FALSE, FALSE, 5, 2);

INSERT INTO PRESCRIPTION (IdVisite, IdMedoc, NbrPrises, NbrDoses, FrequenceJour, DureeTraitement) VALUES
(1, 6, 2, 1, 2, 30),
(1, 4, 1, 1, 1, 365),
(2, 5, 1, 2, 4, 7),
(4, 1, 1, 1, 3, 3),
(5, 4, 1, 1, 1, 180),
(6, 3, 1, 1, 1, 5);

INSERT INTO SEJOUR_TIERS (NomCentre, DateEntree, DateSortie, OperationSubie, IdPatient) VALUES
('Hôpital Saint-Louis', '2025-11-01', '2025-11-05', 'Appendicectomie', 1),
('Clinique du Parc', '2024-08-10', '2024-08-12', 'Gastro-entérite', 3),
('Hôpital Nord', '2025-12-20', '2025-12-25', 'Pneumonie', 2);