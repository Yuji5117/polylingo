# Polylingo - Translation App for Real-Life Conversations

> A multilingual translation app focused on natural, conversational expressions — especially for language learners and overseas travelers.

---

## 🚀 Overview

Polylingo is a cross-platform translation app built with Flutter and Express (TypeScript), deployed via GCP Cloud Run.  
Unlike conventional translation apps, Polylingo focuses on **natural, real-life language use**, including **slang, nuance, and casual expressions**.

---

## 🎯 Motivation

Many widely used translation tools struggle with casual speech, slang, and subtle nuance, often resulting in translations that sound unnatural or even misleading.
As a multilingual learner and overseas resident, I repeatedly encountered this problem both in daily life and while supporting others.

Polylingo was born from a desire to:

- Provide **translations that actually work in real conversations**
- Help **language learners learn natural, spoken language patterns**
- Make cross-cultural communication more intuitive and accurate

---

## 👤 Target Users

- People living abroad who need real-time, reliable translations
- Language learners who want to learn **how things are _actually_ said**
- Travelers who frequently encounter language barriers in casual settings

---

## 🛠️ Tech Stack

- Flutter
- Provider
- HTTP
- dotenv (API key management)

---

## 🚀 How to Run

```bash
flutter pub get
flutter run
```

---

## 📂 Folder Structure

```
lib/
├── constants/ # App-wide constants (e.g. error messages)
├── exceptions/ # Custom exception classes
├── models/ # Data models (e.g. request/response formats)
├── screens/ # UI screens and page layout
├── services/ # API integrations and service logic
├── utils/ # Utility/helper functions
├── view_model/ # State management and business logic
├── widgets/ # Reusable UI components
├── env.dart # Environment variable loader
└── main.dart # App entry point
```

---

## 💡 Features

- Language selection
- Input field with validation
- Display translated results
- API communication with backend
- (Coming soon) Save favorites, history

---

## 🔗 Related Projects

- **Backend (Express + TypeScript)** → [polylingo-api](https://github.com/Yuji5117/polylingo-api)
