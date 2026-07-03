# Getting Capability Flow onto your phone via TestFlight

One-time setup. After this, every release is one click in GitHub → the app
appears/updates in the TestFlight app on your phone, no cable, no expiry.

## Prerequisites
- Apple Developer Program membership active ($99/yr).
- This repo on GitHub (already done).

## 1. Register the app in App Store Connect
1. Go to https://appstoreconnect.apple.com → **Apps** → **+** → **New App**.
2. Platform **iOS**; Name **Capability Flow**; Primary language English;
   Bundle ID **com.sethgilleland.capabilityflow** (pick it from the list — if it
   isn't there, create it first at
   https://developer.apple.com/account/resources/identifiers, type App IDs);
   SKU can be anything (e.g. `capabilityflow`).
3. Create. (You do NOT need to fill in screenshots or submit for review —
   TestFlight only needs the app record to exist.)

## 2. Create an App Store Connect API key
1. https://appstoreconnect.apple.com → **Users and Access** → **Integrations**
   (or **Keys**) → **App Store Connect API** → **+**.
2. Name it (e.g. `ci-upload`), Access role **App Manager**, **Generate**.
3. Note the **Key ID** and the **Issuer ID** (shown at the top of the page).
4. **Download the `.p8` file** — you can only download it once. Keep it safe.

## 3. Find your Team ID
https://developer.apple.com/account → **Membership details** → **Team ID**
(10 characters).

## 4. Add four secrets to GitHub
Repo → **Settings** → **Secrets and variables** → **Actions** → **New repository secret**:

| Secret name       | Value |
| ----------------- | ----- |
| `ASC_KEY_ID`      | The Key ID from step 2 |
| `ASC_ISSUER_ID`   | The Issuer ID from step 2 |
| `ASC_PRIVATE_KEY` | The full contents of the `.p8` file (open in a text editor, copy everything including the `-----BEGIN PRIVATE KEY-----` / `-----END PRIVATE KEY-----` lines) |
| `ASC_TEAM_ID`     | Your Team ID from step 3 |

## 5. Run the build
Repo → **Actions** → **TestFlight** → **Run workflow** → pick the branch → **Run**.
Takes ~5–10 minutes. When it's green, the build lands in App Store Connect →
your app → **TestFlight**. Processing there takes a few more minutes.

## 6. Install on your phone
1. Install **TestFlight** (free) from the App Store on your iPhone.
2. On your Mac/phone, in App Store Connect → your app → TestFlight, add yourself
   as an **Internal Tester** (Users and Access → your Apple ID must be on the team;
   internal testers get builds immediately with no review).
3. Open TestFlight on the phone → the build appears → **Install**.

Updates: each time you (or I) run the TestFlight workflow, TestFlight shows an
**Update**. To share with a colleague, add their email as a tester — they install
TestFlight and get the same link. No cable, no 7-day expiry.

## Notes
- The workflow uses automatic signing via the API key, so no certificates or
  provisioning profiles are stored in the repo.
- Build numbers auto-increment from the GitHub run number, so every upload is
  unique (App Store Connect requires that).
- Export compliance is pre-answered (the app makes no network calls), so uploads
  won't stop to ask about encryption.
