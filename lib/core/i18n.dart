import 'dart:ui' as ui;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppLocalizations get l10n {
  return lookupAppLocalizations(ui.PlatformDispatcher.instance.locale);
}