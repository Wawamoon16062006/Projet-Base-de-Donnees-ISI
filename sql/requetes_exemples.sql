-- =============================================
-- REQUÊTES EXEMPLES
-- =============================================

-- 1. Liste des patients d'un médecin
SELECT p.NomPers, p.PrenomPers, p.DatNais
FROM PATIENT p
WHERE p.IdMedecin_Traitant = 1;

-- 2. Historique des visites d'un patient
SELECT v.DateVisite, v.Motif, m.NomMed, m.PrenomMed
FROM VISITE v
JOIN MEDECIN m ON v.IdMedecin = m.IdMedecin
WHERE v.IdPatient = 1
ORDER BY v.DateVisite DESC;

-- 3. Ordonnances avec posologie
SELECT p.NomPers, p.PrenomPers, v.DateVisite, med.NomMedoc,
       pr.NbrPrises, pr.NbrDoses, pr.FrequenceJour, pr.DureeTraitement
FROM PATIENT p
JOIN VISITE v ON p.IdPatient = v.IdPatient
JOIN PRESCRIPTION pr ON v.IdVisite = pr.IdVisite
JOIN MEDICAMENT med ON pr.IdMedoc = med.IdMedoc
WHERE p.IdPatient = 1;

-- 4. Patients allergiques à un médicament
SELECT p.NomPers, p.PrenomPers, med.NomMedoc
FROM PATIENT p
JOIN ALLERGIE a ON p.IdPatient = a.IdPatient
JOIN MEDICAMENT med ON a.IdMedoc = med.IdMedoc
WHERE med.NomMedoc = 'Loratadine';

-- 5. Nombre de visites par médecin
SELECT m.NomMed, m.PrenomMed, COUNT(v.IdVisite) AS NbVisites
FROM MEDECIN m
LEFT JOIN VISITE v ON m.IdMedecin = v.IdMedecin
GROUP BY m.IdMedecin, m.NomMed, m.PrenomMed
ORDER BY NbVisites DESC;