# MorphyDex — Malnutrition Detection using CNN and Flutter Integration

## 🩺 Project Overview
**MorphyDex** is an AI-based health monitoring system designed to detect and classify **malnutrition in children** using image-based analysis.  
A **custom-trained Convolutional Neural Network (CNN)** model was developed to identify malnourished versus healthy individuals. The system was deployed via a **FastAPI backend** and integrated with a **Flutter mobile application** for real-time, accessible health assessment.

This project aims to support **early detection of malnutrition** in resource-limited settings, assisting medical professionals and NGOs in faster, automated screening.

---

## 🚀 Key Features
- **CNN-based classification** of malnutrition from facial and physical features.  
- **Custom dataset training** with balanced samples of malnourished and healthy individuals.  
- **FastAPI backend** enabling real-time inference and scalable API architecture.  
- **Flutter mobile application** integration for easy field deployment and visual feedback.  
- **Optimized inference speed** suitable for low-power mobile devices.

---

## 🧠 Model Architecture
``` id="yzqtxx"
[Image Input] → [Preprocessing] → [CNN Model] → [Prediction (Healthy / Malnourished)] → [API → Flutter App]
