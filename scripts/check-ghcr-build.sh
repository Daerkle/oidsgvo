#!/bin/bash

# 🔍 GHCR Build Status Checker für DSGVO-Open WebUI
# Überprüft den Status des automatischen Builds

echo "🚀 GHCR Build Status Checker"
echo "=============================="

# Variablen
REPO="Daerkle/oidsgvo"
REGISTRY="ghcr.io"
IMAGE_NAME="daerkle/oidsgvo"

echo ""
echo "📋 Repository: $REPO"
echo "📦 Registry: $REGISTRY"
echo "🏷️ Image: $IMAGE_NAME"
echo ""

# GitHub Actions Status prüfen (benötigt gh CLI)
if command -v gh &> /dev/null; then
    echo "🔄 GitHub Actions Status:"
    gh run list --repo=$REPO --workflow="Build and Push DSGVO-konforme Open WebUI to GHCR" --limit=5
    echo ""
else
    echo "⚠️ GitHub CLI nicht installiert. Installiere mit: brew install gh"
    echo "🌐 Manuell prüfen: https://github.com/$REPO/actions"
    echo ""
fi

# Docker Image verfügbarkeit prüfen
echo "🐳 Prüfe verfügbare Docker Images..."
echo ""

# Verfügbare Tags prüfen
TAGS=("latest" "dsgvo-compliant" "master")

for tag in "${TAGS[@]}"; do
    echo -n "📌 $IMAGE_NAME:$tag - "
    
    if docker manifest inspect $REGISTRY/$IMAGE_NAME:$tag &> /dev/null; then
        echo "✅ Verfügbar"
        
        # Image-Details abrufen
        SIZE=$(docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}" | grep "$IMAGE_NAME" | grep "$tag" | awk '{print $3}' 2>/dev/null || echo "Unknown")
        if [ "$SIZE" != "Unknown" ] && [ "$SIZE" != "" ]; then
            echo "   📊 Größe: $SIZE"
        fi
        
        # Erstellungsdatum
        CREATED=$(docker inspect $REGISTRY/$IMAGE_NAME:$tag --format='{{.Created}}' 2>/dev/null | cut -d'T' -f1 || echo "Unknown")
        if [ "$CREATED" != "Unknown" ] && [ "$CREATED" != "" ]; then
            echo "   📅 Erstellt: $CREATED"
        fi
        
    else
        echo "❌ Nicht verfügbar"
    fi
    echo ""
done

# Plattform-Support prüfen
echo "🖥️ Multi-Platform Support:"
if docker manifest inspect $REGISTRY/$IMAGE_NAME:latest &> /dev/null; then
    docker manifest inspect $REGISTRY/$IMAGE_NAME:latest | jq -r '.manifests[] | "   🏗️ " + .platform.architecture + "/" + .platform.os' 2>/dev/null || echo "   ℹ️ jq nicht installiert für Details"
else
    echo "   ❌ Image nicht verfügbar für Plattform-Check"
fi
echo ""

# Deployment-Befehle
echo "🚀 Deployment-Befehle:"
echo ""
echo "# Schnellstart:"
echo "docker run -d --name oidsgvo -p 3000:8080 \\"
echo "  -e ENABLE_ADMIN_EXPORT=false \\"
echo "  -e ENABLE_ADMIN_CHAT_ACCESS=false \\"
echo "  $REGISTRY/$IMAGE_NAME:latest"
echo ""
echo "# Mit Docker Compose:"
echo "curl -O https://raw.githubusercontent.com/$REPO/master/docker-compose.ghcr.yaml"
echo "docker-compose -f docker-compose.ghcr.yaml up -d"
echo ""

# Nützliche Links
echo "🔗 Nützliche Links:"
echo "• GitHub Repo: https://github.com/$REPO"
echo "• GitHub Actions: https://github.com/$REPO/actions"
echo "• GHCR Package: https://github.com/$REPO/pkgs/container/oidsgvo"
echo "• Pull Commands: docker pull $REGISTRY/$IMAGE_NAME:latest"
echo ""

echo "✅ Check abgeschlossen!"