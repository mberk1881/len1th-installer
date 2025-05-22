#!/bin/bash

clear
echo "============================="
echo "     LEN1TH INSTALLER"
echo "============================="

echo "1. Ubuntu 24.04"
echo "2. Fedora 40"
echo "3. Windows 11 Pro"
echo "4. Windows 10 Pro"
echo "5. Kali Linux"
echo "6. Pardus 21.5"
echo "M. Modlu İsolara Göz At"
echo ""
read -p "Sistem seçin (1-6 ya da M): " OSCHOICE

# MODLU ISO MENÜSÜ
if [[ "$OSCHOICE" == "M" || "$OSCHOICE" == "m" ]]; then
    clear
    echo "============================="
    echo "   MODLU ISO SEÇİM MENÜSÜ"
    echo "============================="
    echo "1. Windows 11 Pro Lite v1"
    echo "2. Tiny 11"
    echo "3. Windows 10 Enterprise LTSC 2019 64 Bit"
    echo "4. Geri dön"
    echo ""
    read -p "Modlu sistem seçin (1-4): " MODCHOICE

    case $MODCHOICE in
        1)
            NAME="Windows 11 Pro Lite v1"
            URL="https://download2391.mediafire.com/8mk0lyc1bccgw2ZqSoXhX2w1SCLAYOqQ9FVNnnvoK2fi1eeXhhSEr-0LwLCGSrjeexvyRpLZ3QjBVbbTTzysz6vLsomMwDKKe7Ei3nV6ASGfIVapIx5kSChh-UXCRO3gz4l4NudUzb8XIGbugrAD9pWTM-XEHczZRfhdew9_IPVvqA/nxjbb1n99pvq0ze/Win_11_Pro_Lite_x64_v1.00.iso"
            ;;
        2)
            NAME="Tiny 11"
            URL="https://dn721801.ca.archive.org/0/items/tiny-11-22-h-2-by-harbour-of-tech/Tiny%2011%20%2822H2%29%20by%20Harbour%20of%20Tech.iso"
            ;;
        3)
            NAME="Windows 10 Enterprise LTSC 2019"
            URL="https://ia800501.us.archive.org/22/items/windows-10-enterprise-ltsc-2019-64-bit/en_windows_10_enterprise_ltsc_2019_x64_dvd_5795bb03.iso"
            ;;
        4)
            bash "$0"
            exit
            ;;
        *)
            echo "Geçersiz seçim."; exit 1
            ;;
    esac
else
    case $OSCHOICE in
        1)
            NAME="Ubuntu 24.04"
            URL="https://releases.ubuntu.com/24.04/ubuntu-24.04-desktop-amd64.iso"
            ;;
        2)
            NAME="Fedora 40"
            URL="https://download.fedoraproject.org/pub/fedora/linux/releases/40/Workstation/x86_64/iso/Fedora-Workstation-Live-x86_64-40-1.14.iso"
            ;;
        3)
            NAME="Windows 11 Pro"
            URL="https://dn721806.ca.archive.org/0/items/windows-11-23h2-turkish-iso/Win11_23H2_Turkish_x64.iso"
            ;;
        4)
            NAME="Windows 10 Pro"
            URL="https://dn721303.ca.archive.org/0/items/21296.1000.210115-1423.-rs-prerelease-clientmulti-x-86-fre-en-us/21296.1000.210115-1423.RS_PRERELEASE_CLIENTMULTI_X86FRE_EN-US.ISO"
            ;;
        5)
            NAME="Kali Linux"
            URL="https://cdimage.kali.org/kali-2024.1/kali-linux-2024.1-installer-amd64.iso"
            ;;
        6)
            NAME="Pardus 21.5"
            URL="https://indir.pardus.org.tr/ISO/Pardus21/Pardus-21.5-XFCE-amd64.iso"
            ;;
        *)
            echo "Geçersiz seçim."; exit 1
            ;;
    esac
fi

# ISO İNDİRME
echo ""
echo "$NAME indiriliyor..."
wget --show-progress -O /tmp/os.iso "$URL" || { echo "İndirme başarısız."; exit 1; }
echo "$NAME başarıyla indirildi."

# USB SEÇTİRME
echo ""
echo "Takılı USB aygıtları:"
lsblk -d -e 7,11 -o NAME,SIZE,MODEL
read -p "Kurulum yapılacak USB aygıtı (/dev/sdX): " USB

# BOOT TİPİ ALGILAMA
if [ -d /sys/firmware/efi ]; then
    BOOT_MODE="UEFI"
else
    BOOT_MODE="Legacy"
fi
echo "Sistem önyükleme modu: $BOOT_MODE"

# PARTITION TİPİ ALGILAMA
PART_TYPE=$(sudo parted $USB print 2>/dev/null | grep "Partition Table" | awk '{print $3}')
echo "$USB bölümleme tablosu: $PART_TYPE"

# UYUMLULUK ANALİZİ
if [[ "$BOOT_MODE" == "UEFI" && "$PART_TYPE" == "gpt" ]]; then
    echo "✓ Uyumlu: UEFI + GPT"
elif [[ "$BOOT_MODE" == "Legacy" && "$PART_TYPE" == "msdos" ]]; then
    echo "✓ Uyumlu: Legacy + MBR"
else
    echo "! UYUMLULUK SORUNU!"
    echo "Sistem: $BOOT_MODE - USB: $PART_TYPE"
    read -p "Devam etmek istiyor musunuz? (y/n): " FORCE
    if [[ "$FORCE" != "y" ]]; then
        echo "İşlem iptal edildi."; exit 1
    fi
fi

# KULLANICI ONAYI
echo ""
read -p "$USB üzerine $NAME yazılacak. Devam etmek istiyor musunuz? (y/n): " CONFIRM
if [ "$CONFIRM" != "y" ]; then
    echo "İşlem iptal edildi."; exit 1
fi

# ISO'YU YAZDIR
echo ""
echo "$USB aygıtına yazılıyor..."
sudo dd if=/tmp/os.iso of=$USB bs=4M status=progress oflag=sync conv=fsync
sync

echo ""
echo "$NAME başarıyla $USB'ye yazıldı!"

