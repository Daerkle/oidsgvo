# 🔧 **Platform Fix für GHCR Images**

## ❌ **Problem:**
```
The requested image's platform (linux/arm64) does not match the detected host platform (linux/amd64/v4)
```

## ✅ **Lösung:**

### **1. Explizite Plattform angeben:**
```bash
# Für AMD64 (Intel/AMD Systeme)
docker pull --platform linux/amd64 ghcr.io/daerkle/oidsgvo:amd64

# Oder spezifisch AMD64 Tag verwenden
docker pull ghcr.io/daerkle/oidsgvo:amd64
```

### **2. Docker Run mit Plattform:**
```bash
docker run -d \
  --name oidsgvo \
  --platform linux/amd64 \
  -p 3000:8080 \
  -e ENABLE_ADMIN_EXPORT=false \
  -e ENABLE_ADMIN_CHAT_ACCESS=false \
  ghcr.io/daerkle/oidsgvo:amd64
```

### **3. Docker Compose (Aktualisiert):**
```yaml
services:
  open-webui:
    image: ghcr.io/daerkle/oidsgvo:amd64
    platform: linux/amd64
    container_name: open-webui-dsgvo
    ports:
      - "3000:8080"
    environment:
      - 'ENABLE_ADMIN_EXPORT=false'
      - 'ENABLE_ADMIN_CHAT_ACCESS=false'
    restart: unless-stopped
```

### **4. Verwendung der aktualisierten docker-compose.ghcr.yaml:**
```bash
curl -O https://raw.githubusercontent.com/Daerkle/oidsgvo/master/docker-compose.ghcr.yaml
docker-compose -f docker-compose.ghcr.yaml up -d
```

## 🏷️ **Verfügbare Tags:**

- `ghcr.io/daerkle/oidsgvo:amd64` - ✅ Für Intel/AMD64 Systeme
- `ghcr.io/daerkle/oidsgvo:latest` - ⚠️ Multi-arch (kann ARM64 sein)

## 📝 **Warum passiert das?**

GitHub Actions kann Multi-Platform Images erstellen, wobei das `latest` Tag manchmal auf ARM64 zeigt. Durch explizite Plattform-Tags wird das Problem vermieden.

---
**✅ Problem gelöst! Verwende den `amd64` Tag für zuverlässige AMD64/Intel Kompatibilität.**