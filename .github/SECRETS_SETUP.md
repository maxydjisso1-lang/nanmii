# 🔐 Configuration GitHub Secrets pour EAS Build CI/CD

## 📋 Secrets à configurer

### 1️⃣ **EXPO_TOKEN** (Obligatoire)
Token d'authentification Expo pour les builds automatisées.

**Étapes pour obtenir le token :**

```bash
# Connectez-vous à Expo
eas login

# Générez un token personnel si besoin
npx expo publish:history --count 1
```

**Ou directement depuis Expo Dashboard:**
1. Allez sur https://expo.dev/settings/applications
2. Cliquez sur "Create token"
3. Sélectionnez "Full access" ou limit aux builds
4. Copiez le token

### 2️⃣ Configuration dans GitHub

1. **Allez sur votre repository GitHub**
   - https://github.com/maxydjisso1-lang/nanmii

2. **Settings → Secrets and variables → Actions**

3. **New repository secret**
   - **Name:** `EXPO_TOKEN`
   - **Value:** Collez le token d'Expo

4. **Save secret**

---

## 🚀 Utilisation du Workflow

### Déclencher automatiquement (sur push)
```bash
git add .
git commit -m "feat: new feature"
git push origin main
```
→ GitHub Actions lancera automatiquement le build 🎯

### Déclencher manuellement
1. Allez sur **Actions** → **EAS Build - Android APK**
2. Cliquez **Run workflow**
3. Sélectionnez le profil (preview ou production)
4. Cliquez **Run workflow**

---

## 📊 Vérifier le statut du build

**Dans GitHub Actions:**
- Actions tab → View workflow runs

**Dans Expo Dashboard:**
- https://expo.dev/accounts/maxy123/projects/nanmii-mobile-app/builds

---

## ⚠️ Troubleshooting

### ❌ Erreur: "EXPO_TOKEN not found"
→ Vérifiez que le secret est bien créé dans Settings → Secrets

### ❌ Erreur: "Keystore not configured"
→ Créez le Keystore une fois manuellement:
```bash
. ~/.nvm/nvm.sh
npx eas credentials configure-build --platform android
```

### ❌ Build failed: "Android Keystore"
→ Les credentials sont stockés côté Expo, pas besoin de les ajouter dans GitHub

---

## 🔍 Variables d'environnement disponibles

Le workflow utilise les variables suivantes:

| Variable | Source | Utilisée pour |
|----------|--------|---------------|
| `EXPO_TOKEN` | GitHub Secrets | Authentification Expo |
| `EAS_BUILD_PROFILE` | Input du workflow | Sélection du profil (preview/production) |
| `GITHUB_TOKEN` | GitHub (auto) | Commenter les PRs |

---

## 📱 Télécharger l'APK après le build

Une fois le build terminé:

1. **Via GitHub Actions:**
   - Actions → Workflow run → Check build output

2. **Via Expo Dashboard:**
   - https://expo.dev/accounts/maxy123/projects/nanmii-mobile-app
   - Cliquez sur le build → "Download"

3. **Va lire le lien affich dans le terminal:**
   ```
   ✔ Build complete
   Build URL: https://expo.dev/accounts/maxy123/projects/nanmii-mobile-app/builds/XXXX
   APK: https://download.url/app-release.apk
   ```

---

## ✅ Vérification rapide

```bash
# 1. Tester le login Expo
eas login

# 2. Vérifier l'accès au projet
eas project:info

# 3. Vérifier les builds précédents
eas build:list --limit 3

# 4. Pousser pour trigger le workflow
git push origin main
```

---

## 🎯 Prochaines étapes

Une fois le workflow qui marche:
- ✅ Ajouter des notifications Slack
- ✅ Générer automatiquement les changelogs
- ✅ Publier les builds sur Firebase App Distribution
- ✅ Créer un workflow iOS en parallèle
