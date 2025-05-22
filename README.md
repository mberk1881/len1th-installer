````markdown
# Len1th Installer

## Script’i İndirme ve Çalıştırma Rehberi

### Windows Üzerinden (PowerShell + WSL)

1. **PowerShell’i açın ve masaüstüne gidin:**

```powershell
cd $env:USERPROFILE\Desktop
````

2. **Script dosyasını GitHub’dan indirin:**

```powershell
curl -Lo len1th_installer.sh https://raw.githubusercontent.com/mberk1881/len1th-installer/main/len1th_installer.sh
```

3. **WSL terminalini açın:**

Windows’da WSL (Ubuntu veya başka bir Linux dağıtımı) yüklü değilse, Microsoft Store’dan kurun. Ardından PowerShell’den:

```powershell
wsl
```

4. **WSL içinde masaüstüne gidin:**

```bash
cd /mnt/c/Users/$(powershell.exe -NoProfile -Command '[Environment]::UserName' | tr -d '\r')/Desktop
```

5. **Script’e çalıştırma izni verin ve çalıştırın:**

```bash
chmod +x len1th_installer.sh
sudo ./len1th_installer.sh
```

---

### Linux / WSL (Bash) Üzerinden

1. **Terminali açın ve masaüstüne gidin:**

```bash
cd ~/Desktop
```

2. **Script’i indirin:**

```bash
wget https://raw.githubusercontent.com/mberk1881/len1th-installer/main/len1th_installer.sh -O len1th_installer.sh
```

3. **Çalıştırma izni verin ve script’i başlatın:**

```bash
chmod +x len1th_installer.sh
sudo ./len1th_installer.sh
```

---

### Script Çalışırken

* Menüden kurmak istediğiniz işletim sistemini seçin.
* Modlu ISO’lara göz atmak için `M` seçeneğini kullanabilirsiniz.
* USB sürücünüz listelenecek, doğru olanı seçin (örneğin `/dev/sdb`).
* Sistem otomatik olarak boot modunu (UEFI veya Legacy) ve USB bölümleme tipini (GPT veya MBR) algılar.
* Uyumsuzluk durumunda size uyarı verir ve devam etmek isteyip istemediğinizi sorar.
* Onay verdiğinizde ISO indirilecek ve USB’ye yazılacaktır.

---

### Dikkat Edilmesi Gerekenler

* USB sürücünüzü dikkatlice seçin, yanlış seçim veri kaybına yol açabilir!
* Script `sudo` yetkisi gerektirir, şifrenizi isteyebilir.
* Windows’ta çalıştırmak için WSL kullanmanız gerekir.
* ISO dosyası `/tmp/os.iso` yoluna kaydedilir, ihtiyaca göre düzenlenebilir.

---

## İletişim

Herhangi bir sorun veya öneri için GitHub üzerinden [mberk1881](https://github.com/mberk1881) ile iletişime geçebilirsiniz.

```

