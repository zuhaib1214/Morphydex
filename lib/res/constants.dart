class Constants {
  static String getSuggestions(String diagnosedLabel) {
    switch (diagnosedLabel) {
      case 'Malnourised':
        return '1. Consult a pediatrician or a healthcare professional for a comprehensive evaluation and tailored nutritional advice. \n2. Introduce nutrient-dense foods into the baby\'s diet, such as fruits, vegetables, whole grains, and lean proteins. \n3. Ensure the baby is getting sufficient calories and balanced nutrition according to their age and developmental needs. \n4. Monitor the baby\'s growth and development regularly to track progress and make necessary adjustments. \n5. Educate caregivers about the importance of hygiene and food safety to prevent infections and illnesses that can worsen malnutrition.';
      case 'Normal':
        return '1. Continue regular check-ups with a pediatrician to monitor the baby\'s growth and development. \n2. Provide a balanced diet that includes a variety of fruits, vegetables, grains, and proteins appropriate for the baby\'s age. \n3. Ensure the baby stays hydrated by offering water, breast milk, or formula as needed. \n4. Encourage physical activity and play to support overall health and development. \n5. Stay up to date with vaccinations and preventive healthcare measures to protect the baby from common illnesses.';
      default:
        return '';
    }
  }
}
