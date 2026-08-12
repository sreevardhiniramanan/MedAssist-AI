# MedAssist AI – Intelligent Hospital Assistant

MedAssist AI is an AI-powered hospital assistant designed to simplify patient and healthcare workflows through a unified web application.

It combines **FastAPI, PostgreSQL, JWT authentication, OCR, Machine Learning, RAG, and LLM-based assistance** to support hospital operations such as patient management, appointments, prescriptions, lab reports, and AI-powered healthcare assistance.

> **Project status:** Active development

## ✨ Key Features

### 👤 Patient Module
- Patient registration and login
- JWT-based authentication
- Patient profile management
- Appointment booking
- Appointment history
- Prescription upload
- Prescription OCR/scanning
- Medicine reminders
- Lab report access
- AI-assisted lab report explanation
- AI hospital chatbot

### 👨‍⚕️ Doctor Module
- Doctor authentication
- View appointments
- View patient information/history
- Upload lab reports
- Upload prescriptions
- Add doctor notes

### 🛡️ Admin Module
- Administrative APIs and hospital workflow support
- User and system management capabilities

### 🤖 AI Features
- LLM-powered hospital chatbot
- Retrieval-Augmented Generation (RAG)
- Prescription/document OCR
- AI-assisted medical report explanation
- Disease prediction / ML integration
- Vector-store based knowledge retrieval

## 🏗️ Technology Stack

| Layer | Technology |
|---|---|
| Frontend | HTML, CSS, JavaScript |
| Backend | Python, FastAPI |
| Database | PostgreSQL |
| ORM / Data Access | SQLAlchemy |
| Authentication | JWT |
| Password Security | Passlib |
| AI / LLM | LLM-based assistant |
| RAG | Retrieval-Augmented Generation |
| OCR | Python OCR pipeline |
| Machine Learning | Scikit-learn |
| Vector Database | ChromaDB / FAISS |
| API Testing | Swagger / OpenAPI |
| Development | VS Code |

## 📁 Project Structure

```text
MedAssist-AI/
│
├── ai/
│   ├── chatbot.py
│   ├── ocr.py
│   └── report_explainer.py
│
├── backend/
│   ├── core/
│   │   └── security.py
│   ├── models/
│   │   ├── appointment.py
│   │   ├── chat_history.py
│   │   ├── disease_prediction.py
│   │   ├── doctor.py
│   │   ├── hospital_document.py
│   │   ├── lab_report.py
│   │   ├── medicine_reminder.py
│   │   ├── patient.py
│   │   ├── prescription.py
│   │   ├── prescription_scan.py
│   │   ├── staff.py
│   │   └── user.py
│   ├── routes/
│   │   ├── admin.py
│   │   ├── auth.py
│   │   ├── chatbot.py
│   │   ├── doctor.py
│   │   └── patient.py
│   ├── schemas/
│   ├── services/
│   ├── config.py
│   ├── database.py
│   ├── main.py
│   └── requirements.txt
│
├── database/
│   └── schema.sql
│
├── docs/
│   ├── architecture.md
│   └── requirements.md
│
├── frontend/
│   ├── css/
│   ├── js/
│   ├── index.html
│   ├── login.html
│   └── pages/
│
├── ml/
│   ├── model.py
│   └── train_model.py
│
├── rag/
│   ├── rag_pipeline.py
│   └── vector_store.py
│
├── .gitignore
└── README.md
```

## ⚙️ Installation

### 1. Clone the repository

```bash
git clone https://github.com/sreevardhiniramanan/MedAssist-AI.git
cd MedAssist-AI
```

### 2. Create a virtual environment

Windows:

```bash
python -m venv venv
venv\Scripts\activate
```

### 3. Install dependencies

```bash
pip install -r backend/requirements.txt
```

### 4. Configure environment variables

Create:

```text
backend/.env
```

Add your local configuration and secrets there.

**Never commit `.env` to GitHub.**

Example:

```env
DATABASE_URL=your_database_url
SECRET_KEY=your_secret_key
```

Use your actual local values; do not copy secrets into the repository.

### 5. Configure PostgreSQL

Create the required PostgreSQL database and apply the schema from:

```text
database/schema.sql
```

Then make sure your database connection settings match your `backend/.env`.

## ▶️ Run the Backend

From the project root:

```bash
uvicorn backend.main:app --reload
```

The FastAPI server will normally be available at:

```text
http://127.0.0.1:8000
```

### 📚 API Documentation

FastAPI provides interactive API documentation at:

```text
http://127.0.0.1:8000/docs
```

Alternative OpenAPI documentation:

```text
http://127.0.0.1:8000/redoc
```

## 🔐 Security

The project uses:
- JWT authentication
- Password hashing
- Environment variables for secrets
- Role-based API structure
- PostgreSQL-backed application data

For production deployment, additional security hardening, HTTPS, secure secret management, input validation, rate limiting, logging, and access-control reviews should be implemented.

## 🧠 AI Architecture

The AI layer is organized around multiple components:

```text
User
  │
  ▼
Frontend
  │
  ▼
FastAPI Backend
  │
  ├── Authentication
  ├── Patient / Doctor APIs
  ├── Appointment APIs
  ├── Prescription APIs
  ├── Lab Report APIs
  │
  ▼
AI Layer
  ├── LLM Chatbot
  ├── OCR
  ├── RAG Pipeline
  ├── Vector Store
  └── ML Prediction
  │
  ▼
PostgreSQL
```

## 🔮 Future Enhancements

- Flutter mobile application
- Advanced hospital chatbot
- Improved medical-document OCR
- More comprehensive RAG knowledge base
- Real-time medicine reminders
- Doctor-patient communication
- Appointment notifications
- Advanced analytics dashboard
- Cloud deployment
- Role-based access control improvements
- Comprehensive automated testing
- Production-grade monitoring and logging

## ⚠️ Disclaimer

MedAssist AI is a software/academic project intended to assist with healthcare workflows and information access.

It is **not a replacement for qualified medical professionals, diagnosis, or emergency medical care**. AI-generated information should be reviewed by appropriate healthcare professionals before being used for clinical decisions.

## 👩‍💻 Author

**Sree Vardhini Ramanan**

GitHub: [sreevardhiniramanan](https://github.com/sreevardhiniramanan)

## ⭐ Project

If you find this project useful or interesting, consider giving the repository a ⭐ on GitHub.
