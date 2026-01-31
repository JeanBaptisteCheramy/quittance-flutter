class Validators {

  static String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Le champ est obligatoire';
    if (value.length < 2) return 'Le champ doit contenir au moins 2 caractères';
    return null;
  }

   static String? addressValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Le champ est obligatoire';
    if (value.length < 10) return 'Le champ doit contenir au moins 10 caractères';
    return null;
  }
}