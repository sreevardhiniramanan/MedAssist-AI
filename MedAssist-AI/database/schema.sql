-- ============================================================
-- MedAssist AI - Hospital Database Schema
-- PostgreSQL
-- ============================================================

-- ============================================================
-- 1. USERS
-- Common authentication table for all roles
-- ============================================================

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,

    role VARCHAR(20) NOT NULL
        CHECK (role IN ('patient', 'doctor', 'staff', 'admin')),

    phone VARCHAR(20),
    is_active BOOLEAN DEFAULT TRUE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- 2. PATIENTS
-- ============================================================

CREATE TABLE IF NOT EXISTS patients (
    id SERIAL PRIMARY KEY,

    user_id INTEGER UNIQUE NOT NULL
        REFERENCES users(id) ON DELETE CASCADE,

    date_of_birth DATE,
    gender VARCHAR(20),
    blood_group VARCHAR(10),

    address TEXT,
    emergency_contact_name VARCHAR(100),
    emergency_contact_phone VARCHAR(20),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- 3. DOCTORS
-- ============================================================

CREATE TABLE IF NOT EXISTS doctors (
    id SERIAL PRIMARY KEY,

    user_id INTEGER UNIQUE NOT NULL
        REFERENCES users(id) ON DELETE CASCADE,

    specialization VARCHAR(100) NOT NULL,
    qualification VARCHAR(200),
    experience_years INTEGER DEFAULT 0,

    license_number VARCHAR(100) UNIQUE,

    department VARCHAR(100),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- 4. HOSPITAL STAFF / NURSE / LAB STAFF
-- ============================================================

CREATE TABLE IF NOT EXISTS staff (
    id SERIAL PRIMARY KEY,

    user_id INTEGER UNIQUE NOT NULL
        REFERENCES users(id) ON DELETE CASCADE,

    staff_type VARCHAR(50) NOT NULL
        CHECK (staff_type IN ('nurse', 'lab_technician', 'medical_assistant', 'staff')),

    department VARCHAR(100),

    employee_id VARCHAR(100) UNIQUE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- 5. APPOINTMENTS
-- Patient books appointment with doctor
-- ============================================================

CREATE TABLE IF NOT EXISTS appointments (
    id SERIAL PRIMARY KEY,

    patient_id INTEGER NOT NULL
        REFERENCES patients(id) ON DELETE CASCADE,

    doctor_id INTEGER NOT NULL
        REFERENCES doctors(id) ON DELETE CASCADE,

    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,

    reason TEXT,

    status VARCHAR(30) DEFAULT 'scheduled'
        CHECK (
            status IN (
                'scheduled',
                'confirmed',
                'completed',
                'cancelled'
            )
        ),

    doctor_notes TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- 6. PRESCRIPTIONS
-- Doctor creates prescription
-- Patient can view it
-- ============================================================

CREATE TABLE IF NOT EXISTS prescriptions (
    id SERIAL PRIMARY KEY,

    patient_id INTEGER NOT NULL
        REFERENCES patients(id) ON DELETE CASCADE,

    doctor_id INTEGER NOT NULL
        REFERENCES doctors(id) ON DELETE CASCADE,

    appointment_id INTEGER
        REFERENCES appointments(id) ON DELETE SET NULL,

    prescription_file TEXT,

    medicine_details TEXT,

    diagnosis TEXT,

    instructions TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- 7. LAB REPORTS
-- Hospital Staff uploads reports
-- Patient and Doctor can view
-- ============================================================

CREATE TABLE IF NOT EXISTS lab_reports (
    id SERIAL PRIMARY KEY,

    patient_id INTEGER NOT NULL
        REFERENCES patients(id) ON DELETE CASCADE,

    uploaded_by_staff_id INTEGER
        REFERENCES staff(id) ON DELETE SET NULL,

    report_name VARCHAR(200) NOT NULL,

    report_type VARCHAR(100),

    file_path TEXT NOT NULL,

    report_date DATE,

    ai_summary TEXT,

    ai_explanation TEXT,

    status VARCHAR(30) DEFAULT 'uploaded'
        CHECK (
            status IN (
                'uploaded',
                'processing',
                'processed',
                'reviewed'
            )
        ),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- 8. MEDICINE REMINDERS
-- ============================================================

CREATE TABLE IF NOT EXISTS medicine_reminders (
    id SERIAL PRIMARY KEY,

    patient_id INTEGER NOT NULL
        REFERENCES patients(id) ON DELETE CASCADE,

    medicine_name VARCHAR(200) NOT NULL,

    dosage VARCHAR(100),

    frequency VARCHAR(100),

    reminder_time TIME,

    start_date DATE,

    end_date DATE,

    is_active BOOLEAN DEFAULT TRUE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- 9. AI CHAT HISTORY
-- Patient ↔ AI Hospital Assistant
-- ============================================================

CREATE TABLE IF NOT EXISTS chat_history (
    id SERIAL PRIMARY KEY,

    patient_id INTEGER NOT NULL
        REFERENCES patients(id) ON DELETE CASCADE,

    user_message TEXT NOT NULL,

    ai_response TEXT NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- 10. HOSPITAL DOCUMENTS
-- Documents used by RAG system
-- ============================================================

CREATE TABLE IF NOT EXISTS hospital_documents (
    id SERIAL PRIMARY KEY,

    uploaded_by INTEGER
        REFERENCES users(id) ON DELETE SET NULL,

    document_name VARCHAR(255) NOT NULL,

    document_type VARCHAR(100),

    file_path TEXT NOT NULL,

    description TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- 11. OCR PRESCRIPTION SCANS
-- Stores OCR extracted information
-- ============================================================

CREATE TABLE IF NOT EXISTS prescription_scans (
    id SERIAL PRIMARY KEY,

    patient_id INTEGER NOT NULL
        REFERENCES patients(id) ON DELETE CASCADE,

    uploaded_by_staff_id INTEGER
        REFERENCES staff(id) ON DELETE SET NULL,

    image_path TEXT NOT NULL,

    extracted_text TEXT,

    extracted_medicines TEXT,

    ocr_status VARCHAR(30) DEFAULT 'pending'
        CHECK (
            ocr_status IN (
                'pending',
                'processing',
                'completed',
                'failed'
            )
        ),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- 12. AI DISEASE RISK PREDICTIONS
-- ML model results
-- ============================================================

CREATE TABLE IF NOT EXISTS disease_predictions (
    id SERIAL PRIMARY KEY,

    patient_id INTEGER NOT NULL
        REFERENCES patients(id) ON DELETE CASCADE,

    model_name VARCHAR(150),

    prediction VARCHAR(200),

    probability DECIMAL(5,4),

    input_data JSONB,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- INDEXES
-- Improve database search performance
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_users_email
ON users(email);

CREATE INDEX IF NOT EXISTS idx_appointments_patient
ON appointments(patient_id);

CREATE INDEX IF NOT EXISTS idx_appointments_doctor
ON appointments(doctor_id);

CREATE INDEX IF NOT EXISTS idx_lab_reports_patient
ON lab_reports(patient_id);

CREATE INDEX IF NOT EXISTS idx_prescriptions_patient
ON prescriptions(patient_id);

CREATE INDEX IF NOT EXISTS idx_chat_history_patient
ON chat_history(patient_id);

CREATE INDEX IF NOT EXISTS idx_documents_type
ON hospital_documents(document_type);


-- ============================================================
-- DATABASE SCHEMA COMPLETE
-- ============================================================