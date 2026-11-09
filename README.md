# Artology CRM — native apps

iOS, Android, macOS and Windows apps for **Artology CRM**.

This repo holds only the native shells. All app code — the CRM screens, the
app shell, sign-in, translations — lives in
[artology](https://github.com/antoinetterocks/artology) and is included here
as a git submodule (`artology/`). There is one CRM codebase: a fix made in
artology reaches artology.live/crm and these apps.

```
artology/      submodule, pinned to one artology commit
ios/           Capacitor iOS project (Xcode)
android/       Capacitor Android project (Gradle)
src-tauri/     Tauri desktop app (macOS, Windows)
assets/        icon artwork for iOS / Android (npx @capacitor/assets generate --assetPath assets)
scripts/web-build.sh   builds the CRM from artology → dist/
```

## Setup

```bash
git clone --recurse-submodules https://github.com/antoinetterocks/local-crm
cd local-crm
npm ci
```

Already cloned without the submodule: `git submodule update --init`.

## Commands

```bash
npm run web:build      # build the CRM from artology/ → dist/
npm run ios            # build, sync, open Xcode
npm run android        # build, sync, open Android Studio
npm run desktop:dev    # desktop window against artology's dev server (:8081)
npm run desktop:build  # desktop installer for the current OS
```

## Updating to a newer artology

The submodule is pinned, so an artology change never alters these apps until
you choose to take it:

```bash
npm run update-artology     # move the pin to the latest artology main
npm run web:build           # check it builds
git commit -m "Update artology"
```

Rule of thumb: **change CRM behaviour in artology, change native settings
(icons, permissions, bundle IDs, signing) here.** Never edit files inside
`artology/` from this repo.

## Releasing

One-time: Apple Developer Program (App Store + macOS notarization), Google
Play Console, optionally Microsoft Partner Center. Bundle / package ID:
`live.artology.crm`.

- **iOS:** `npm run ios` → in Xcode set the team, bump the version, Product →
  Archive → Distribute to App Store Connect.
- **Android:** `npm run android` → Build → Generate Signed Bundle (AAB) →
  Play Console. CI builds a debug APK on every PR.
- **macOS / Windows:** push a tag `v<version>` or run the `build` workflow by
  hand. Add `APPLE_CERTIFICATE`, `APPLE_CERTIFICATE_PASSWORD`,
  `APPLE_SIGNING_IDENTITY`, `APPLE_ID`, `APPLE_PASSWORD`, `APPLE_TEAM_ID` as
  secrets for a signed, notarized Mac build.

CI needs the secret `ARTOLOGY_READ_TOKEN` (read access to artology) to
check out the submodule.

Keep versions in step: `src-tauri/tauri.conf.json`, Xcode Marketing Version,
Android `versionName` in `android/app/build.gradle`.
