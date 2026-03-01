# ✅ Configuration CI/CD GitHub Actions + EAS Build

## 🎯 Objectif atteint !

Votre repository Nanmii est maintenant configuré avec une **CI/CD complètement automatisée** pour générer des APK Android via GitHub Actions et EAS Build.

---

## 📦 Ce qui a été ajouté

```
nanmii/
├── .github/
│   ├── workflows/
│   │   ├── eas-build.yml              ← Build automatique sur push/PR
│   │   └── manual-build.yml            ← Build manuel avec options
│   ├── CI_CD_GUIDE.md                  ← Guide complet
│   └── SECRETS_SETUP.md                ← Configuration des secrets
├── scripts/
│   ├── setup-ci.sh                     ← Config auto du token
│   └── add-github-secrets.sh           ← Ajout secrets GitHub
└── .env.example                        ← Variab.d'environnement
```

---

## 🚀 À faire maintenant (5 minutes max)

### 1️⃣ Générer un token Expo

```bash
cd ~/Desktop/nanmii\ asset
chmod +x scripts/setup-ci.sh
./scripts/setup-ci.sh
```

→ Cela va vous guider pour obtenir votre token et configurer le Keystore Android

### 2️⃣ Ajouter le token à GitHub Secrets

**Méthode automatique (recommandée):**
```bash
chmod +x scripts/add-github-secrets.sh
./scripts/add-github-secrets.sh "YOUR_EXPO_TOKEN"
```

**Ou manuellement:**
1. https://github.com/maxydjisso1-lang/nanmii/settings/secrets/actions
2. "New repository secret"
3. Name: `EXPO_TOKEN`
4. Value: Collez votre token
5. "Add secret"

### 3️⃣ C'est tout ! 🎉

---

## 📱 Comment faire un build

### Option A: Automatique (Push)
```bash
git commit -m "feat: add new feature"
git push origin main
```
→ Le build se déclenche automatiquement!

### Option B: Manuel (Interface GitHub)
1. https://github.com/maxydjisso1-lang/nanmii/actions
2. Sélectionnez workflow:
   - "EAS Build - Android APK" (simple)
   - "Manual EAS Build" (avec options)
3. Cliquez "Run workflow"
4. Attendendez 15-45 minutes ⏳

### Option C: Via Terminal
```bash
. ~/.nvm/nvm.sh
gh workflow run eas-build.yml -r main
```

---

## 📊 Workflows détail

### 🟢 EAS Build - Android APK (Automatique)
- **Déclenché par:** Push sur main, PRs
- **Profil:** `preview` (APK)
- **Durée:** ~20-30 min
- **Résultat:** APK téléchargeable

Configuration: [.github/workflows/eas-build.yml](.github/workflows/eas-build.yml)

### 🔵 Manual EAS Build (Personnalisé)
- **Déclenché par:** Actions UI
- **Options:** Platform (android/ios), Profile (preview/production)
- **Durée:** ~20-45 min
- **Résultat:** APK ou AAB

Configuration: [.github/workflows/manual-build.yml](.github/workflows/manual-build.yml)

---

## 📥 Télécharger l'APK

### Après un build

1. **Via Expo Dashboard:**
   - https://expo.dev/accounts/maxy123/projects/nanmii-mobile-app
   - Cliquez le build → Download

2. **Via Logs GitHub Actions:**
   - Actions → Workflow run → Scroll down → "Build complete" link

3. **Via Terminal:**
   ```bash
   npx eas build:list --limit 1
   # Copiez l'URL de "Application Archive URL"
   ```

---

## 📚 Documentation

- **Guide complet:** [.github/CI_CD_GUIDE.md](.github/CI_CD_GUIDE.md)
- **Configuration secrets:** [.github/SECRETS_SETUP.md](.github/SECRETS_SETUP.md)
- **Workflows:** Voir `.github/workflows/`

---

## ✨ Avantages

✅ **Automatisation:** Pas besoin de commande `eas build`  
✅ **Keystore sécurisé:** Stocké dans EAS Cloud  
✅ **Token protégé:** Via GitHub Secrets (invisible)  
✅ **Logs complets:** Accessible dans GitHub Actions  
✅ **Scaling:** Builds Android + iOS côte à côte (possibilité future)  
✅ **Intégration:** Slack, Firebase, Google Play (extensible)  

---

## 🔐 Sécurité

| Élément | Où stocké | Sécurité |
|---------|-----------|---------|
| EXPO_TOKEN | GitHub Secrets | ✅ Chiffré, masqué |
| Android Keystore | EAS Cloud | ✅ Privé, auto-géré |
| Code sources | GitHub | ✅ Privé (si repo privé) |

**Important:** Le token GitHub Secrets n'est jamais visible dans les logs publics!

---

## 🐛 Troubleshooting rapide

**"EXPO_TOKEN not found"**
```bash
./scripts/add-github-secrets.sh "YOUR_TOKEN"
```

**"Build failed: Keystore"**
```bash
npx eas credentials configure-build --platform android
```

**"Build timed out"**
→ Normal, ça peut prendre 45 min max. Vérifiez les logs EAS Dashboard.

Pour plus d'aide → [CI_CD_GUIDE.md](.github/CI_CD_GUIDE.md#-troubleshooting)

---

## 🎓 Prochaines étapes

Une fois que les builds fonctionnent:

- [ ] Ajouter notifications Slack quand build complete
- [ ] Publier directement sur Firebase App Distribution
- [ ] Créer workflow iOS parallel
- [ ] Automatiser déploiement Google Play Store
- [ ] Générer changelog automatique

---

## 📞 Support

**Questions?** Consultez:
1. Logs GitHub Actions: https://github.com/maxydjisso1-lang/nanmii/actions
2. Logs EAS Build: https://expo.dev/accounts/maxy123/projects/nanmii-mobile-app/builds
3. Documentation: [CI_CD_GUIDE.md](.github/CI_CD_GUIDE.md)

---

## 🎉 C'est bon !

**Status:**
- ✅ Workflows créés
- ✅ Scripts de setup prêts
- ✅ Documentation complète
- ⏳ En attente: EXPO_TOKEN configuration par vos soins

**Prochaine étape:** Lancez `./scripts/setup-ci.sh` puis poussez vers GitHub!

```bash
cd ~/Desktop/nanmii\ asset
./scripts/setup-ci.sh
```

Bon builds! 🚀
