-- =============================================
-- VUES POUR LA CONFIDENTIALITÉ
-- =============================================

-- Vue pour un médecin (ses patients uniquement)
CREATE OR REPLACE VIEW Vue_Patients_Medecin AS
SELECT p.*
FROM PATIENT p
WHERE p.IdMedecin_Traitant = (SELECT IdMedecin FROM MEDECIN WHERE IdMedecin = CURRENT_USER);

-- Vue pour un médecin (consultation des collègues)
CREATE OR REPLACE VIEW Vue_Patients_Cabinet AS
SELECT 
    p.IdPatient,
    p.NomPers,
    p.PrenomPers,
    p.DatNais,
    p.Poids,
    p.Taille,
    p.Adresse,
    m.NomMed AS NomMedecinTraitant,
    m.PrenomMed AS PrenomMedecinTraitant
FROM PATIENT p
JOIN MEDECIN m ON p.IdMedecin_Traitant = m.IdMedecin;

-- Vue pour la secrétaire (informations limitées)
CREATE OR REPLACE VIEW Vue_Secretaire AS
SELECT 
    p.IdPatient,
    p.NomPers,
    p.PrenomPers,
    p.Adresse,
    m.NomMed AS MedecinTraitant,
    m.PrenomMed AS PrenomMedecinTraitant
FROM PATIENT p
JOIN MEDECIN m ON p.IdMedecin_Traitant = m.IdMedecin;