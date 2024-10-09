import 'dart:async';
import 'dart:developer';

import 'package:webspark/feature/app/logic/app_runner.dart';

void main() => runZonedGuarded(
      () => const AppRunner().initializeAndRun(),
      (_, __) => log('runZonedGuarded error'),
    );
