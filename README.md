# 🔒 DSGVO-konforme Open WebUI 

![GitHub stars](https://img.shields.io/github/stars/Daerkle/oidsgvo?style=social)
![GitHub forks](https://img.shields.io/github/forks/Daerkle/oidsgvo?style=social)
![Docker Image](https://img.shields.io/badge/docker-ghcr.io%2Fداerkle%2Foidsgvo-blue)
![DSGVO Compliant](https://img.shields.io/badge/DSGVO-Compliant-green)
![License](https://img.shields.io/github/license/Daerkle/oidsgvo)

**Eine DSGVO-konforme Version von Open WebUI ohne Admin-Chat-Zugriffsfunktionen zum Schutz der Benutzer-Privatsphäre.**

> 🛡️ **DSGVO-Konformität garantiert**: Keine Admin-Einsicht in Benutzer-Chats, keine Massen-Datenexporte, vollständiger Datenschutz durch Design.

## 🚀 **Schnellstart**

### **Mit Docker (GHCR)**
```bash
docker run -d \
  --name oidsgvo \
  -p 3000:8080 \
  -e ENABLE_ADMIN_EXPORT=false \
  -e ENABLE_ADMIN_CHAT_ACCESS=false \
  ghcr.io/daerkle/oidsgvo:latest
```

### **Mit Docker Compose**
```bash
git clone https://github.com/Daerkle/oidsgvo.git
cd oidsgvo
docker-compose up -d
```

### **Direkt von GHCR mit Compose**
```bash
curl -O https://raw.githubusercontent.com/Daerkle/oidsgvo/master/docker-compose.ghcr.yaml
docker-compose -f docker-compose.ghcr.yaml up -d
```

**Zugriff:** http://localhost:3000

## 🔒 **DSGVO-Compliance Features**

### ❌ **Entfernte Admin-Funktionen**
- **Keine Chat-Einsicht**: Admins können nicht in Benutzer-Chats einsehen
- **Kein Chat-Export**: Keine Massen-Exports aller Benutzer-Daten
- **Keine Datensammlung**: Standardmäßig deaktivierte Telemetrie
- **Datenschutz durch Design**: Minimierung der Datenverarbeitung

### ✅ **Erhaltene Funktionen**
- Alle Standard Open WebUI Features (außer Admin-Chat-Zugriff)
- Vollständige Ollama/OpenAI Integration
- Benutzer-Verwaltung (ohne Chat-Zugriff)
- RAG, Tools, Modelle, etc.

## 🔧 **Technische Details**

### **Entfernte Backend-Endpoints:**
- `GET /api/v1/chats/list/user/{user_id}` ❌
- `GET /api/v1/chats/all/db` ❌

### **Entfernte Frontend-Komponenten:**
- Chat-Bubble-Buttons in Admin-Benutzeroberfläche ❌
- "Export All Chats" Button in Database-Einstellungen ❌
- UserChatsModal und zugehörige APIs ❌

### **Konfiguration:**
```bash
ENABLE_ADMIN_EXPORT=false
ENABLE_ADMIN_CHAT_ACCESS=false
```

## 📚 **Verfügbare Docker Tags**

- `latest` - Neueste stabile Version
- `dsgvo-compliant` - DSGVO-zertifizierte Version
- `v1.0.0` - Erste stabile Release

## 🆚 **Unterschied zur Original Open WebUI**

| Feature | Original | DSGVO-Version |
|---------|----------|---------------|
| Admin-Chat-Einsicht | ✅ Verfügbar | ❌ Entfernt |
| Chat-Massen-Export | ✅ Verfügbar | ❌ Entfernt |
| Benutzer-Verwaltung | ✅ Vollständig | ✅ Ohne Chat-Zugriff |
| Alle anderen Features | ✅ Verfügbar | ✅ Verfügbar |
| DSGVO-Konformität | ⚠️ Problematisch | ✅ Konform |

## 🔍 **Verifikation der DSGVO-Konformität**

### 1. **Admin-Interface prüfen:**
```
URL: http://localhost:3000/admin/users
✅ Keine Chat-Bubble-Buttons sichtbar
```

### 2. **Database-Einstellungen prüfen:**
```
URL: http://localhost:3000/admin/settings (Database Tab)
✅ Kein "Export All Chats" Button vorhanden
```

### 3. **API-Endpoints testen:**
```bash
# Diese sollten 404 zurückgeben:
curl -I http://localhost:3000/api/v1/chats/list/user/123
curl -I http://localhost:3000/api/v1/chats/all/db
```

## 📖 **Dokumentation**

- [📋 DSGVO-Änderungen Zusammenfassung](./DSGVO_DEAKTIVIERUNG_ZUSAMMENFASSUNG.md)
- [🚀 Schnellstart-Anleitung](./DSGVO_START_ANLEITUNG.md)
- [🐳 Docker Rebuild Guide](./DOCKER_REBUILD_ANLEITUNG.md)
- [📦 GHCR Publishing Guide](./GHCR_PUBLISH_ANLEITUNG.md)

## ⚖️ **Rechtliche Hinweise**

Diese Version wurde speziell für die Einhaltung der EU-Datenschutz-Grundverordnung (DSGVO) entwickelt:

- ✅ **Art. 5 DSGVO** - Datenminimierung implementiert
- ✅ **Art. 25 DSGVO** - Datenschutz durch Technikgestaltung
- ✅ **Art. 32 DSGVO** - Sicherheit der Verarbeitung
- ✅ **Keine unbefugte Einsichtnahme** durch Administratoren

## 🤝 **Contributing**

Contributions sind willkommen! Bitte stellen Sie sicher, dass alle Änderungen die DSGVO-Konformität beibehalten.

## 📄 **Lizenz**

Dieses Projekt steht unter der gleichen Lizenz wie das Original Open WebUI Projekt.

## 🙏 **Danksagungen**

Basiert auf [Open WebUI](https://github.com/open-webui/open-webui) - Ein großartiges Open Source Projekt!

---
**🔒 Datenschutz ist ein Grundrecht - Verwenden Sie Software, die dieses respektiert.**
