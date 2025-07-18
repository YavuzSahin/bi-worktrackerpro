import 'package:flutter/material.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  String _selectedLanguage = 'en';

  final Map<String, String> _languages = {
    'en': '🇺🇸 English',
    'tr': '🇹🇷 Türkçe',
    'es': '🇪🇸 Español',
    'pt': '🇵🇹 Português',
    'ar': '🇸🇦 العربية',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedLanguage,
          isExpanded: true,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          items: _languages.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Text(entry.value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedLanguage = newValue;
              });
              // TODO: Implement language change logic
            }
          },
        ),
      ),
    );
  }
}