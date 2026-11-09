# CLAUDE.md

Native shells (Capacitor iOS/Android, Tauri macOS/Windows) for Artology CRM.
See README.md.

- `artology/` is a git submodule. **Never edit it from this repo.** CRM
  screens, the app shell (`artology/src/crm-app/`), translations and data
  code change in the artology repo; then move the pin here with
  `npm run update-artology`.
- `npm run web:build` must pass before committing a submodule bump.
- Native settings live here: `capacitor.config.ts`, `ios/App/App/Info.plist`
  (+ `en.lproj` / `zh-Hans.lproj` `InfoPlist.strings` — every permission
  prompt in English and Simplified Chinese), `android/app/src/main/AndroidManifest.xml`,
  `src-tauri/tauri.conf.json`.
- Commit `ios/` and `android/` after `npx cap sync`; the copied web assets
  (`ios/App/App/public`, `android/app/src/main/assets/public`) are ignored.
