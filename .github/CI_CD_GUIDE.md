# 🚀 CI/CD avec GitHub Actions & EAS Build

Configuration complète pour automatiser les builds Android avec Expo EAS et GitHub Actions.

## 📋 Table des matières

- [Configuration initiale](#-configuration-initiale)
- [Workflows disponibles](#-workflows-disponibles)
- [Déclencher un build](#-déclencher-un-build)
- [Télécharger l'APK](#-télécharger-lapk)
- [Troubleshooting](#-troubleshooting)

---

## 🔧 Configuration initiale

### Étape 1: Obtenir un token Expo

**Option A: Via le script automatique (Recommandé)**

```bash
# Rendre le script exécutable
chmod +x scripts/setup-ci.sh

# Lancer le script
./scripts/setup-ci.sh
```

**Option B: Manuel**

1. Allez sur https://expo.dev/settings/applications
2. Cliquez "Create token"
3. Nommez-le (ex: `github-ci`)
4. Copiez le token

### Étape 2: Ajouter le token à GitHub Secrets

**Méthode A: Via GitHub CLI**

```bash
# Installer GitHub CLI si besoin: https://cli.github.com/

chmod +x scripts/add-github-secrets.sh
./scripts/add-github-secrets.sh "YOUR_EXPO_TOKEN"
```

**Méthode B: Via l'interface GitHub**

1. Allez sur: https://github.com/maxydjisso1-lang/nanmii/settings/secrets/actions
2. Cliquez "New repository secret"
3. **Name:** `EXPO_TOKEN`
4. **Value:** Collez votre token
5. Cliquez "Add secret"

### Étape 3: Configurer le Keystore Android (Une seule fois)

```bash
. ~/.nvm/nvm.sh
cd ~/Desktop/nanmii\ asset
eas login
npx eas credentials configure-build --platform android
# → Sélectionnez: Generate a new Android Keystore (yes)
# → Attendez ~30 secondes
```

Le Keystore est maintenant stocké dans EAS Cloud et sera réutilisé par GitHub Actions ✅

### Étape 4: Pousser vers GitHub

```bash
git add .github/ scripts/ .gitignore
git commit -m "ci: add GitHub Actions EAS Build workflow"
git push origin main
```

---

## 📊 Workflows disponibles

### 1️⃣ **EAS Build - Android APK** (Automatique)

**Déclenché par:**
- ✅ Push sur `main` ou `develop`
- ✅ Pull requests
- ✅ Manuellement via Actions

**Profil:** `preview` (APK interne)

**Configuration:** [.github/workflows/eas-build.yml](.github/workflows/eas-build.yml)

### 2️⃣ **Manual EAS Build** (Personnalisé)

**Déclenché par:** Actions tab → Run workflow

**Options:**
- Platform: `android`, `ios`, ou `both`
- Profile: `preview` ou `production`
- Clear cache: `true` ou `false`

**Configuration:** [.github/workflows/manual-build.yml](.github/workflows/manual-build.yml)

---

## 🎯 Déclencher un build

### Option 1: Automatique (Push)

```bash
git commit -m "feat: add new feature"
git push origin main
```

→ Le workflow se déclenche automatiquement! 🚀

Vérifiez l'état: https://github.com/maxydjisso1-lang/nanmii/actions

### Option 2: Manuellement

**Via GitHub UI:**
1. Allez sur https://github.com/maxydjisso1-lang/nanmii/actions
2. Sélectionnez workflow:
   - `EAS Build - Android APK` (simple)
   - `Manual EAS Build` (avancé)
3. Cliquez "Run workflow"
4. Configurez les options (si manuel)
5. Cliquez "Run workflow"

**Via GitHub CLI:**

```bash
# Build preview (simple)
gh workflow run eas-build.yml -r main

# Build production (personnalisé)
gh workflow run manual-build.yml -f platform=android -f profile=production -r main
```

---

## 📱 Télécharger l'APK

### Method 1: Via Expo Dashboard

1. Allez sur: https://expo.dev/accounts/maxy123/projects/nanmii-mobile-app
2. Vous verrez le dernier build
3. Cliquez la ligne du build
4. Cliquez "Download" pour l'APK

### Method 2: Via Terminal

```bash
. ~/.nvm/nvm.sh
npx eas build:list --limit 1

# Copiez l'URL de "Application Archive URL"
# Téléchargez: curl -O <URL>
```

### Method 3: Via GitHub Actions

1. Allez sur Actions → Workflow run
2. Cliquez sur le build
3. Scrollez vers le bas
4. Cherchez "artifacts" ou le lien de build dans les logs

---

## 🏗️ Structure des workflows

```
.github/
├── workflows/
│   ├── eas-build.yml          ← Automatique (push/PR)
│   └── manual-build.yml        ← Manuel avec options
└── SECRETS_SETUP.md            ← Guide de configuration
```

---

## 🔍 Vérifier le statut

### Via GitHub Actions

```bash
# Voir les builds récents
gh run list --workflow eas-build.yml --limit 5
```

### Via Expo Dashboard

```bash
npx eas build:list --limit 10
```

### Logs détaillés

```bash
# Logs du dernier build
eas build:list --limit 1

# Ou directement:
eas build:view <BUILD_ID>
```

---

## ⚙️ Variables d'environnement

| Variable | Source | Usage |
|----------|--------|-------|
| `EXPO_TOKEN` | GitHub Secrets | Auth expo/eas |
| `GITHUB_TOKEN` | GitHub (auto) | Commenter PRs |
| `EAS_BUILD_PROFILE` | Input (workflow) | Sélectionner profil |

---

## 🛡️ Bonnes pratiques sécurité

✅ **À faire:**
- Stockez les secrets dans GitHub Secrets
- Utilisez des tokens avec permissions limitées
- Révoquz les anciens tokens
- N'committez jamais les secrets

❌ **À éviter:**
- Ne mettez pas le token dans `.env` local
- Ne le partagez pas dans Slack/Discord
- Ne le committez pas dans le code

**Révoquer un token compromis:**
1. Allez sur https://expo.dev/settings/applications
2. Cherchez et supprimez le token
3. Mettez à jour GitHub Secrets
4. Les builds suivants utiliseront le nouveau

---

## 🚨 Troubleshooting

### ❌ "EXPO_TOKEN not found"

```
Error: EXPO_TOKEN is not set in secrets
```

**Solution:**
```bash
# Ajouter le secret
gh secret set EXPO_TOKEN --body "YOUR_TOKEN" -R maxydjisso1-lang/nanmii

# Ou via UI:
# https://github.com/maxydjisso1-lang/nanmii/settings/secrets/actions
```

### ❌ "Build failed: Keystore not configured"

```
Error: Android Keystore is not configured
```

**Solution:**
```bash
npx eas credentials configure-build --platform android
# Sélectionnez: Generate a new Android Keystore
```

### ❌ "Build timed out"

**Raison:** Build prend > 30-45 min

**Solution:**
- Réduisez la taille des dépendances
- Vérifiez les logs EAS Dashboard
- Utilisez le profil `preview` (APK) au lieu de `production` (AAB)

### ❌ "Branch not found"

```
Error: refs/heads/develop not found
```

**Solution:**
```bash
# Vérifiez les branches disponibles
git branch -a

# Ou changez le workflow pour utiliser 'main' seulement
# .github/workflows/eas-build.yml:
#   on:
#     push:
#       branches:
#         - main
```

### ❌ "Permission denied"

```
Error: You do not have permission to run this workflow
```

**Solution:**
- Vérifiez votre compte GitHub a accès au repo
- Vérifiez les permissions dans Settings → Actions

---

## 📚 Ressources

- [Expo EAS Build Docs](https://docs.expo.dev/eas-update/getting-started)
- [GitHub Actions Docs](https://docs.github.com/en/actions)
- [EAS CLI Reference](https://docs.expo.dev/eas/ecosystem-tools/)

---

## ✨ Prochaines étapes

Une fois que le workflow fonctionne:

- [ ] Ajouter notifications Slack
- [ ] Publier sur Firebase App Distribution
- [ ] Créer un workflow iOS
- [ ] Ajouter sur Google Play Store
- [ ] Implémenter un changelog automatique

---

## 📞 Support

Si vous rencontrez des problèmes:

1. Vérifiez les logs: GitHub Actions → Workflow run
2. Consultez les logs EAS: https://expo.dev/.../builds
3. Relancez le workflow avec cache vide

---

**🎉 Enjoy automated builds!**
