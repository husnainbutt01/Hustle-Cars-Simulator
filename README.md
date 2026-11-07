# Hustle Cars Simulator
**Developed by Husnain Butt**

A starter 3D Android-ready car dealership and open-world driving simulator built with Godot 4.

## Included
- Small 3D city block, road, sidewalks and showroom
- Drivable third-person car prototype
- Keyboard driving: W/Up accelerate, S/Down brake/reverse, A/D steer
- Press E near the showroom to open the dealership
- Buy/sell economy prototype and cash HUD
- Godot GL Compatibility renderer selected for Android-oriented performance

## Important status
This is a playable starter prototype, not a finished commercial-grade simulator. It uses primitive placeholder geometry and simplified vehicle physics. It does **not** yet contain licensed real car models, detailed interiors, pedestrians, traffic AI, sound, save system, or touch steering controls. Those need to be added and tested in later development.

## Open on desktop
1. Install Godot 4.2 or newer.
2. Import this folder's `project.godot`.
3. Press F6/F5 to run the main scene.

## Export Android APK
1. Install Godot 4.x and its matching export templates.
2. Install Android Studio / Android SDK and configure Java SDK + Android SDK paths in Godot Editor > Editor Settings > Export > Android.
3. In Project > Export, add an Android preset. Set package name to `com.husnainbutt.hustlecars`, orientation Landscape, and renderer to Compatibility.
4. For a local test APK, use a debug keystore/debug export. For Play Store release, create and protect your own release keystore.
5. Export the APK and install it on your Android phone.

## Next development milestones
- Touchscreen steering wheel / pedals and mobile camera controls
- Better vehicle physics (suspension, wheel rotation, collision)
- Garage inventory, persistent save/load, missions and customer AI
- More city blocks, traffic, pedestrians and optimized LOD
- Original vehicle meshes/materials and audio


## Build APK online (no local Android/Godot installation)
This project includes a GitHub Actions workflow at `.github/workflows/android.yml`.

1. Create a GitHub account and a **new public or private repository**.
2. Upload the contents of this ZIP (including the hidden `.github` folder) to the repository. Easiest: create a repository, then use **Add file > Upload files** and drag the extracted folder contents. Ensure `.github/workflows/android.yml` is included.
3. Open the repository's **Actions** tab.
4. Select **Build Android APK** on the left, click **Run workflow**, then confirm.
5. When the run finishes successfully, open that run and download the artifact named **HustleCars-Android-APK**. Extract the artifact ZIP to get `HustleCars.apk`.

The cloud runner uses a Godot CI container, so you do not need to install Godot or Android SDK on your own computer. A GitHub account and internet connection are required. This is a debug/testing APK, not a Play Store release build. If the workflow image/version becomes unavailable, the workflow may need a version update.
