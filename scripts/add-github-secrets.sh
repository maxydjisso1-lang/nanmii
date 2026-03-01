#!/bin/bash

# 🔑 Script pour ajouter automatiquement les secrets à GitHub
# Usage: ./scripts/add-github-secrets.sh <EXPO_TOKEN>

set -e

if [ $# -lt 1 ]; then
    echo "Usage: $0 <EXPO_TOKEN>"
    echo ""
    echo "Exemple:"
    echo "  $0 'YOUR_EXPO_TOKEN_HERE'"
    echo ""
    echo "Ou avec variable d'environnement:"
    echo "  EXPO_TOKEN='YOUR_TOKEN' $0"
    exit 1
fi

EXPO_TOKEN="${1:-$EXPO_TOKEN}"
REPO="maxydjisso1-lang/nanmii"

if [ -z "$EXPO_TOKEN" ]; then
    echo "❌ Token non fourni"
    exit 1
fi

# Couleurs
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🔐 Ajout des secrets GitHub${NC}"
echo "Repository: $REPO"
echo ""

# Vérifier que GitHub CLI est installé
if ! command -v gh &> /dev/null; then
    echo -e "${RED}❌ GitHub CLI n'est pas installé${NC}"
    echo "Installation: https://cli.github.com/"
    exit 1
fi

# Vérifier l'authentification GitHub
if ! gh auth status &> /dev/null; then
    echo -e "${BLUE}📝 Authentification GitHub requise${NC}"
    gh auth login
fi

echo ""
echo -e "${BLUE}1. Ajout de EXPO_TOKEN...${NC}"

# Ajouter le secret
gh secret set EXPO_TOKEN --body "$EXPO_TOKEN" --repo "$REPO" 2>/dev/null && \
    echo -e "${GREEN}✓ EXPO_TOKEN ajouté${NC}" || \
    echo -e "${RED}❌ Erreur lors de l'ajout de EXPO_TOKEN${NC}"

echo ""
echo -e "${BLUE}2. Vérification des secrets...${NC}"
gh secret list --repo "$REPO"

echo ""
echo -e "${GREEN}✅ Secrets configurés!${NC}"
echo ""
echo "Vous pouvez maintenant utiliser GitHub Actions pour les builds."
echo "Allez sur: https://github.com/$REPO/actions"
