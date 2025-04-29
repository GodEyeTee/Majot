import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:majot/core/config/localization/localization.dart';
import 'package:majot/core/config/theme/app_themes.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);
    final currentThemeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Language Section
          Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.language,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  ...LocalizationService.supportedLocales.map((locale) {
                    final isSelected =
                        currentLocale.languageCode == locale.languageCode;
                    final languageName = LocalizationService
                            .availableLanguages[locale.languageCode] ??
                        locale.languageCode;

                    return RadioListTile<String>(
                      title: Text(languageName),
                      value: locale.languageCode,
                      groupValue: currentLocale.languageCode,
                      onChanged: (_) {
                        ref.read(localeProvider.notifier).setLocale(locale);
                      },
                      selected: isSelected,
                      activeColor: Theme.of(context).colorScheme.primary,
                    );
                  }).toList(),
                ],
              ),
            ),
          ),

          // Theme Section
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.theme,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  RadioListTile<AppThemeMode>(
                    title: Text(context.l10n.lightMode),
                    value: AppThemeMode.light,
                    groupValue: currentThemeMode,
                    onChanged: (value) {
                      if (value != null) {
                        ref
                            .read(themeModeProvider.notifier)
                            .setThemeMode(value);
                      }
                    },
                    activeColor: Theme.of(context).colorScheme.primary,
                  ),
                  RadioListTile<AppThemeMode>(
                    title: Text(context.l10n.darkMode),
                    value: AppThemeMode.dark,
                    groupValue: currentThemeMode,
                    onChanged: (value) {
                      if (value != null) {
                        ref
                            .read(themeModeProvider.notifier)
                            .setThemeMode(value);
                      }
                    },
                    activeColor: Theme.of(context).colorScheme.primary,
                  ),
                  RadioListTile<AppThemeMode>(
                    title: Text(context.l10n.systemMode),
                    value: AppThemeMode.system,
                    groupValue: currentThemeMode,
                    onChanged: (value) {
                      if (value != null) {
                        ref
                            .read(themeModeProvider.notifier)
                            .setThemeMode(value);
                      }
                    },
                    activeColor: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
