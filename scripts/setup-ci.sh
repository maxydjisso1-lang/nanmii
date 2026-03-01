#!/bin/bash

# 🔐 Script de configuration automatique pour EAS Build CI/CD
# Usage: chmod +x ./scripts/setup-ci.sh && ./scripts/setup-ci.sh

set -e

echo "🚀 Configuration EAS Build avec GitHub Secrets"
echo "=============================================="
echo ""

# Couleurs
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Vérifier Node.js
if ! command -v node &> /dev/null; then
    echo -e "${RED}✗ Node.js n'est pas installé${NC}"
    exit 1
fi

echo -e "${BLUE}ℹ️  Node.js version:${NC} $(node --version)"

# Vérifier NVM
if [ -f ~/.nvm/nvm.sh ]; then
    source ~/.nvm/nvm.sh
fi

# Étape 1: Vérifier la connexion Expo
echo ""
echo -e "${BLUE}1. Vérification de la connexion Expo...${NC}"
if npx eas whoami &> /dev/null; then
    EXPO_USER=$(npx eas whoami 2>/dev/null || echo "Unknown")
    echo -e "${GREEN}✓ Connecté en tant que: ${EXPO_USER}${NC}"
else
    echo -e "${YELLOW}⚠  Pas connecté à Expo. Connexion requise...${NC}"
    npx eas login
fi

echo ""
echo -e "${BLUE}2. Récupération du EXPO_TOKEN...${NC}"
echo -e "${YELLOW}⚠️  Les étapes suivantes vont ouvrir le navigateur${NC}"
echo ""
echo "Options:"
echo "  A) Générer un nouveau token (recommandé)"
echo "  B) Utiliser un token existant"
echo ""
read -p "Votre choix (A/B) [A]: " TOKEN_CHOICE
TOKEN_CHOICE=${TOKEN_CHOICE:-A}

if [[ $TOKEN_CHOICE == [Aa] ]]; then
    echo ""
    echo -e "${BLUE}Génération d'un nouveau token...${NC}"
    echo "Allez sur: https://expo.dev/settings/applications"
    echo "1. Cliquez 'Create token'"
    echo "2. Donnez-lui un nom (ex: 'nanmii-github-ci')"
    echo "3. Copiez le token généré"
    echo ""
    read -p "Collez votre token ici: " EXPO_TOKEN
else
    echo ""
    echo -e "${BLUE}Utilisation d'un token existant...${NC}"
    read -p "Collez votre token ici: " EXPO_TOKEN
fi

if [ -z "$EXPO_TOKEN" ]; then
    echo -e "${RED}✗ Token vide. Opération annulée.${NC}"
    exit 1
fi

# Valider le token
echo -e "${BLUE}Validation du token...${NC}"
if EXPO_TOKEN="$EXPO_TOKEN" npx eas whoami &> /dev/null; then
    echo -e "${GREEN}✓ Token valide!${NC}"
else
    echo -e "${RED}✗ Token invalide. Vérifiez et réessayez.${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}3. Configuration du Keystore Android...${NC}"
# Vérifier si un Keystore existe déjà
if npx eas credentials --platform android &> /dev/null; then
    echo -e "${GREEN}✓ Keystore Android trouvé${NC}"
else
    echo -e "${YELLOW}⚠️  Création d'un nouveau Keystore...${NC}"
    { echo "yes"; sleep 5; } | npx eas credentials configure-build --platform android || true
fi

echo ""
echo -e "${BLUE}4. Informations du projet EAS...${NC}"
npx eas project:info

echo ""
echo "=============================================="
echo -e "${GREEN}✓ Configuration complète!${NC}"
echo "=============================================="
echo ""
echo -e "${BLUE}📋 Prochaines étapes:${NC}"
echo ""
echo "1️⃣  Ajoutez le token dans GitHub Secrets:"
echo "   - Allez sur: https://github.com/maxydjisso1-lang/nanmii/settings/secrets/actions"
echo "   - New repository secret"
echo "   - Name: EXPO_TOKEN"
echo "   - Value: (votre token)"
echo ""
echo "2️⃣  Committez les changements:"
echo "   git add ."
echo "   git commit -m 'ci: add GitHub Actions EAS Build workflow'"
echo "   git push origin main"
echo ""
echo "3️⃣  Déclenchez le workflow:"
echo "   - Allez sur: https://github.com/maxydjisso1-lang/nanmii/actions"
echo "   - Sélectionnez 'EAS Build - Android APK'"
echo "   - Cliquez 'Run workflow'"
echo ""
echo -e "${YELLOW}💡 Conseil: Gardez le token secret et ne le committez jamais!${NC}"
