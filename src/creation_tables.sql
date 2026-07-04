-- =========================================================
-- SOLUTION 1 : MODÈLE RELATIONNEL (SGBDR)
-- =========================================================

CREATE TABLE MEDECIN (
    IdMedecin SERIAL PRIMARY KEY,
    NomMed VARCHAR(50) NOT NULL,
    PrenomMed VARCHAR(50) NOT NULL
);

CREATE TABLE PATIENT (
    IdPatient SERIAL PRIMARY KEY,
    NomPers VARCHAR(50) NOT NULL,
    PrenomPers VARCHAR(50) NOT NULL,
    DatNais DATE NOT NULL,
    Poids DECIMAL(5,2),
    Taille DECIMAL(3,2),
    Adresse TEXT,
    IdMedecin_Traitant INT REFERENCES MEDECIN(IdMedecin)
);

CREATE TABLE MALADIE (
    IdMaladie SERIAL PRIMARY KEY,
    NomMaladie VARCHAR(100) NOT NULL
);

CREATE TABLE MEDICAMENT (
    IdMedoc SERIAL PRIMARY KEY,
    NomMedoc VARCHAR(100) NOT NULL,
    Categorie VARCHAR(50),
    Description TEXT
);

CREATE TABLE VISITE (
    IdVisite SERIAL PRIMARY KEY,
    DateVisite TIMESTAMP NOT NULL,
    Motif TEXT,
    Lieu VARCHAR(10) CHECK (Lieu IN ('Cabinet', 'Domicile')),
    Prescrip BOOLEAN DEFAULT FALSE,
    Analyses BOOLEAN DEFAULT FALSE,
    Result BOOLEAN DEFAULT FALSE,
    IdPatient INT REFERENCES PATIENT(IdPatient) ON DELETE CASCADE,
    IdMedecin INT REFERENCES MEDECIN(IdMedecin)
);

CREATE TABLE PRESCRIPTION (
    IdVisite INT REFERENCES VISITE(IdVisite) ON DELETE CASCADE,
    IdMedoc INT REFERENCES MEDICAMENT(IdMedoc),
    NbrPrises INT NOT NULL,
    NbrDoses INT NOT NULL,
    FrequenceJour INT NOT NULL,
    DureeTraitement INT NOT NULL,
    PRIMARY KEY (IdVisite, IdMedoc)
);

CREATE TABLE ALLERGIE (
    IdPatient INT REFERENCES PATIENT(IdPatient) ON DELETE CASCADE,
    IdMedoc INT REFERENCES MEDICAMENT(IdMedoc) ON DELETE CASCADE,
    PRIMARY KEY (IdPatient, IdMedoc)
);

CREATE TABLE SOUFFRE_DE (
    IdPatient INT REFERENCES PATIENT(IdPatient) ON DELETE CASCADE,
    IdMaladie INT REFERENCES MALADIE(IdMaladie) ON DELETE CASCADE,
    PRIMARY KEY (IdPatient, IdMaladie)
);

CREATE TABLE SEJOUR_TIERS (
    IdSejour SERIAL PRIMARY KEY,
    NomCentre VARCHAR(100) NOT NULL,
    DateEntree DATE NOT NULL,
    DateSortie DATE,
    OperationSubie TEXT,
    IdPatient INT REFERENCES PATIENT(IdPatient) ON DELETE CASCADE
);

-- Trigger de sécurité pour les allergies
CREATE OR REPLACE FUNCTION verifier_allergie_prescription() 
RETURNS TRIGGER AS $$
DECLARE
    v_id_patient INT;
BEGIN
    SELECT IdPatient INTO v_id_patient FROM VISITE WHERE IdVisite = NEW.IdVisite;
    IF EXISTS (
        SELECT 1 FROM ALLERGIE 
        WHERE IdPatient = v_id_patient AND IdMedoc = NEW.IdMedoc
    ) THEN
        RAISE EXCEPTION 'Sécurité : Le patient est allergique à ce médicament !';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_allergie_avant_prescription
BEFORE INSERT OR UPDATE ON PRESCRIPTION
FOR EACH ROW EXECUTE FUNCTION verifier_allergie_prescription();


-- =========================================================
-- SOLUTION 2 : MODÈLE OBJET-RELATIONNEL (SGBDOR)
-- =========================================================

CREATE TYPE Sejour_Type AS (
    NomCentre VARCHAR(100),
    DateEntree DATE,
    DateSortie DATE,
    OperationSubie TEXT
);

CREATE TABLE PATIENT_OR (
    IdPatient SERIAL PRIMARY KEY,
    NomPers VARCHAR(50) NOT NULL,
    PrenomPers VARCHAR(50) NOT NULL,
    DatNais DATE NOT NULL,
    Poids DECIMAL(5,2),
    Taille DECIMAL(3,2),
    Adresse TEXT,
    IdMedecin_Traitant INT REFERENCES MEDECIN(IdMedecin),
    AllergiesMedoc INT[], 
    MaladiesId INT[],     
    HistoriqueSejours Sejour_Type[] 
);