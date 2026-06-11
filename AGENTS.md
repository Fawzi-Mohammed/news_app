# Repository Guidelines

## Project Structure & Module Organization
`lib/` contains the app code. Shared code lives under `lib/core/` (`constants/`, `datasource/`, `models/`, `repos/`, `theme/`, `widgets/`), while feature screens are grouped in `lib/features/<feature>/` with local `controllers/`, `models/`, `widgets/`, or `components/` folders as needed. Entry point: `lib/main.dart`.

Assets are in `assets/images/` and `assets/fonts/`, both declared in `pubspec.yaml`. Platform shells live in `android/`, `ios/`, `web/`, `linux/`, `macos/`, and `windows/`. The repository also vendors `packages/image_picker_android/` through `dependency_overrides`; treat changes there as package-level work, not app feature work.

## Build, Test, and Development Commands
- `flutter pub get` installs dependencies.
- `flutter run` launches the app on the selected device/emulator.
- `flutter analyze` runs static analysis with `flutter_lints`.
- `flutter test` runs the project test suite.
- `dart run build_runner build --delete-conflicting-outputs` regenerates Hive and other `*.g.dart` files after model changes.

Use `flutter test test/widget_test.dart` for the root widget test, or run tests inside `packages/image_picker_android/` separately when touching the override.

## Coding Style & Naming Conventions
Follow Dart defaults: 2-space indentation, trailing commas where formatter-friendly, and a max line width of 80 (`analysis_options.yaml`). Use `dart format .` before opening a PR.

Name classes/widgets in `PascalCase`, methods/variables in `camelCase`, and files/folders in `snake_case` such as `profile_screen.dart` or `home_controller.dart`. Keep screens and controllers inside their owning feature folder. Do not hand-edit generated files like `lib/core/models/user_model.g.dart` or `lib/hive_registrar.g.dart`.

## Testing Guidelines
Use `flutter_test` for widget and unit tests. Place app tests under `test/` and mirror the source area when possible, for example `test/features/home/home_controller_test.dart`. Name files with the `_test.dart` suffix. Add tests for controller logic, repository behavior, and critical UI flows when modifying them.

## Commit & Pull Request Guidelines
Recent history uses short, lowercase, task-focused commit messages such as `done details and profile screens`. Keep subjects concise, but prefer clearer imperative wording, for example `add profile bottom sheet validation`.

PRs should describe the user-facing change, list affected screens/features, mention any generated files or `packages/image_picker_android` edits, and include screenshots for UI work. Link the related issue when one exists.
