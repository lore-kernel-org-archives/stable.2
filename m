Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3A33CAA3B
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785086082; cv=none; b=C+VrwZLPk1DArVOgd5klmB73+Z+SbjBH1VA4QwR/cNWm0HPpzKuqWPaTKoVrvcFquyEFadQPmF2zyg4qoAI3uxT+GG9H+RUoV7f7FeCLvWfQuFI7xAAU+4VcSRSPFCBXWbuKndtGNmsofx0iqaALGxZg2VUQqhFeeVvS01lWEVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785086082; c=relaxed/simple;
	bh=c21zYm+YIfq9qlHRb7BIpAgZgHpsoEwFgPl+uj11lUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I6Ftha64Igustgw3mb2aVo1S+PpLfrNsqeXdlLYxIlrsEmL+Nu5RA0q2pgyNT+ZrHhhjK9lxp2gfS6TZqFlEpfi21JnJ+1MLW0GaH29Uf8z6PWdynA6Ih9QsRK9VSMv8wF73KSyUOa0VoSLYC3Sj9d7keDfnyruvmpZF7IZ0gq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3/midVR; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3/midVR"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84830c774a0so1937445b3a.1
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 10:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785086080; x=1785690880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g/nhnjXpXTzpv4HZx3luPaZMhOwup2jg5QVpK+5t2H0=;
        b=l3/midVRs7su2sCaKY54TfGwWPFW3toZFc/7BFPO1o8YPpLg1Cr65Jmtu8d63HyEc3
         Fzswa9g5Ccmku6f2eAqVpqvoQhLK9QOSNLWFEHGjJAfmRfH+4QBSIEwXFNKFuImuWAbx
         8ZjBeKX4K8UvVUbUaOlVbiO5zITShLfHoVwr2sMrAA4YmFs7DMGuPlZA4pBv0NaiNb99
         uZUoeImoW7kqqeiO2uSOhUW2JfoUKnU1o9lQXJ21TMnvR83/4DrqQD8kTmFRJ07wHkrN
         j8FD0+F01E4dzphw9rB5Hrbd7ksa/kNP3SKn1uFTY4zoruJ4zcbkNhyHmAxK0SojtJlk
         pulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785086080; x=1785690880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g/nhnjXpXTzpv4HZx3luPaZMhOwup2jg5QVpK+5t2H0=;
        b=F8F9Jea6OebPQLWijDJKXmir99lvVjMNb9hLrnowClbQtaI+IQbyptZC9/BdvNIV/L
         vg4gWNx6TiKVw2c2icupU4q8ZYJ9lF2SQr2Y6ZlGXwFMee3jRQIPHlCMyi+mlhVMyZbq
         +BZvcgyqCMfZ+JXXJ2gaOiv4iQJFHhXboeVfnJXBNO8KsCKUtLJX4oLYOPWA3biXB+P1
         MDl7apGVMvLEUESjFUsqInyecVlpwlDOjXzr6rIt8JKr2eUFLnrtBoARCjcW6qz0zb8X
         IPDyI9EAs8Awk0sdz2LK7nFObxn4LTrDlnnwjWdkr2N1affrlbEXFPZz1wJqkoLvxGJj
         5tLQ==
X-Forwarded-Encrypted: i=1; AHgh+RqjseTARnXaFAuYxzUdDoTLlDtXXD/vpROmncCVzCxGEGVXM9nImcvqgVha/tyqb6VrCRswDrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyty5fLpF4q7gDLbdXJsfc3nQ+zi5G4lCZQpvwahpYrLQbbKYiR
	7VVAojrRaaec4jLDuWs5XO5Ch3iCtSdf8UDuDVuqHp/SdkOOSlmVHjGo
X-Gm-Gg: AR+sD13NtX+czEjTnZDXvIORsTr5mVLazyqjTtteFir1TNdHRvyZI74nQktPsYwe/HE
	hdk9z16CazMYo4veRUT+bezRBrPp4J20GQCCYoQYnTXISXD/PrDRaT6oW2RoTveTYEhDKTR5Ot3
	ftQZ6q/hlqm5BLbKo7l89PptQuLRLfKsrpGCjxcu7D6tJtt7Ps8GiHkNHyoODYeq/R0uPN7xt+q
	ohUN8dH78fOhYQe9w7M50PBrfCF63plumgrkF5pSdYAQWeD1tIfB1BLSRqnAvkAEL/e+Uf5A7C5
	rlpbmo2me/VsY0AFjmrK4d6F6Zn4KaBr0jp/PEx1yn4OSVRWYMrY0dOCbSnLj5HmBRpEc2/LC05
	g6wgkdIYf2lX/aJZAoaGGXES/gf8tMaRDc9wsaOd3a9YIAxYCum3jTitv/BpCHdVfGJd0zgaPx1
	OTmvaYWFR3IbGL0Q==
X-Received: by 2002:a05:6a20:6a09:b0:3c3:90de:60e2 with SMTP id adf61e73a8af0-3c67e0779a5mr5154868637.65.1785086079895;
        Sun, 26 Jul 2026 10:14:39 -0700 (PDT)
Received: from Linux.bbrouter ([115.96.218.218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d6ba579c3sm17823450c88.8.2026.07.26.10.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 10:14:39 -0700 (PDT)
From: Ishaan Dandekar <ishaan.dandekar@gmail.com>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	nikhilsolanke5@gmail.com,
	Alan Stern <stern@rowland.harvard.edu>,
	Michal Pecio <michal.pecio@gmail.com>,
	stable@vger.kernel.org,
	Ishaan Dandekar <ishaan.dandekar@gmail.com>
Subject: [PATCH v2 1/2] usbcore: Add quirk for 255-bytes initial config read
Date: Sun, 26 Jul 2026 22:44:22 +0530
Message-Id: <20260726171423.42850-2-ishaan.dandekar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260726171423.42850-1-ishaan.dandekar@gmail.com>
References: <20260726171423.42850-1-ishaan.dandekar@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nikhil Solanke <nikhilsolanke5@gmail.com>

Certain third-party USB game controllers exposing (or spoofing) an Xbox
360-compatible interface (VID:PID 045e:028e) fail to enumerate under Linux.
The device disconnects from the bus without responding to the initial
GET_DESCRIPTOR(CONFIGURATION) request, and the kernel logs 'unable to read
config index 0 descriptor/start: -71'.

The device then falls back to a secondary Android HID mode (with a
different VID:PID), losing XInput functionality including rumble support.
The failure reproduces across multiple machines, host controller types, and
kernel versions including current mainline and LTS. The device enumerates
correctly and remains in XInput mode under Windows. Notably, the device
enumerates correctly in Android mode when the same 9-byte request
is issued for that mode's configuration descriptor, confirming the firmware
bug is specific to the XInput mode.

usbmon traces from Linux and Wireshark/USBPcap traces from Windows are
identical up to the point of failure, with no visible protocol-level
difference explaining the divergence. The root cause was identified when
Michal Pecio discovered via a QEMU bus-level capture that Windows does not
use wLength=9 for the initial config descriptor request; it uses
wLength=255. Alan Stern subsequently confirmed this with a bus
analyzer on a different USB 2.0 device, and Michal verified the behavior
goes back to Windows 95 OSR2.1.

So, add a new quirk flag USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE which causes
usb_get_configuration() to issue a 255 byte sized configuration request
instead of USB_DT_CONFIG_SIZE (9) for the initial
GET_DESCRIPTOR(CONFIGURATION) request, mimicking long-standing Windows
behavior.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Suggested-by: Michal Pecio <michal.pecio@gmail.com>
Closes: https://lore.kernel.org/linux-usb/CAFgddh+JWdT4LLwMc5qjM8q_pBu-fRo2qADR5ovAKoGHWMQrRw@mail.gmail.com/
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Nikhil Solanke <nikhilsolanke5@gmail.com>
Signed-off-by: Ishaan Dandekar <ishaan.dandekar@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         | 10 +++++
 drivers/usb/core/config.c                     | 39 +++++++++++++++----
 drivers/usb/core/quirks.c                     |  4 ++
 include/linux/usb/quirks.h                    |  3 ++
 4 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8..14121458a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8169,6 +8169,16 @@ Kernel parameters
 				q = USB_QUIRK_FORCE_ONE_CONFIG (Device
 					claims zero configurations,
 					forcing to 1);
+				r = USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE (Device
+					fails during initialization when asked for
+					9-bytes configuration descriptor request.
+					Ask for 255-bytes request instead to mirror
+					Windows' behavior. This quirk is originally
+					meant to fix some quirky gamepads that refuse
+					to connect in their XInput mode. But it can
+					also potentially fix issues with other USB
+					devices that work on Windows but not on
+					Linux);
 			Example: quirks=0781:5580:bk,0a5c:5834:gij
 
 	usbhid.mousepoll=
diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 45e20c6d7..442c15f92 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -912,6 +912,17 @@ int usb_get_configuration(struct usb_device *dev)
 	unsigned char *bigbuffer;
 	struct usb_config_descriptor *desc;
 	int result;
+	size_t usb_config_req_size;
+
+	/*
+	 * Devices with quirky firmware will stall or reset when the initial
+	 * config descriptor request uses wLength=9. If the quirk is set, use
+	 * 255 instead, mirroring the behavior of Windows.
+	 */
+	if (dev->quirks & USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE)
+		usb_config_req_size = 255;
+	else
+		usb_config_req_size = USB_DT_CONFIG_SIZE;
 
 	if (ncfg > USB_MAXCONFIG) {
 		dev_notice(ddev, "too many configurations: %d, "
@@ -938,15 +949,19 @@ int usb_get_configuration(struct usb_device *dev)
 	if (!dev->rawdescriptors)
 		return -ENOMEM;
 
-	desc = kmalloc(USB_DT_CONFIG_SIZE, GFP_KERNEL);
+	desc = kmalloc(usb_config_req_size, GFP_KERNEL);
 	if (!desc)
 		return -ENOMEM;
 
 	for (cfgno = 0; cfgno < ncfg; cfgno++) {
-		/* We grab just the first descriptor so we know how long
-		 * the whole configuration is */
+		/*
+		 * Normally we request only the configuration descriptor header
+		 * so we can determine the total configuration length. For
+		 * devices with USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE set, try to
+		 * grab the full descriptor set instead.
+		 */
 		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
-		    desc, USB_DT_CONFIG_SIZE);
+		    desc, usb_config_req_size);
 		if (result < 0) {
 			dev_err(ddev, "unable to read config index %d "
 			    "descriptor/%s: %d\n", cfgno, "start", result);
@@ -956,9 +971,8 @@ int usb_get_configuration(struct usb_device *dev)
 			dev->descriptor.bNumConfigurations = cfgno;
 			break;
 		} else if (result < 4) {
-			dev_err(ddev, "config index %d descriptor too short "
-			    "(expected %i, got %i)\n", cfgno,
-			    USB_DT_CONFIG_SIZE, result);
+			dev_err(ddev, "config index %d descriptor too short (asked for %zu, got %i, need at least %i)\n",
+			    cfgno, usb_config_req_size, result, 4);
 			result = -EINVAL;
 			goto err;
 		}
@@ -972,6 +986,16 @@ int usb_get_configuration(struct usb_device *dev)
 			goto err;
 		}
 
+		/*
+		 * If the device returns the full configuration descriptor set,
+		 * skip the second read. Otherwise, send a second request
+		 * asking for the full set.
+		 */
+		if (result >= length) {
+			memcpy(bigbuffer, desc, length);
+			goto store_and_parse;
+		}
+
 		if (dev->quirks & USB_QUIRK_DELAY_INIT)
 			msleep(200);
 
@@ -989,6 +1013,7 @@ int usb_get_configuration(struct usb_device *dev)
 			length = result;
 		}
 
+store_and_parse:
 		dev->rawdescriptors[cfgno] = bigbuffer;
 
 		result = usb_parse_configuration(dev, cfgno,
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 87ee2d938..f5a60ccf2 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -142,6 +142,10 @@ static int quirks_param_set(const char *value, const struct kernel_param *kp)
 				break;
 			case 'q':
 				flags |= USB_QUIRK_FORCE_ONE_CONFIG;
+				break;
+			case 'r':
+				flags |= USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE;
+				break;
 			/* Ignore unrecognized flag characters */
 			}
 		}
diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
index b3cc7beab..a4043b33c 100644
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -81,4 +81,7 @@
 /* Device claims zero configurations, forcing to 1 */
 #define USB_QUIRK_FORCE_ONE_CONFIG		BIT(18)
 
+/* Use a 255 bytes config descriptor request mirroring windows behavior */
+#define USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE	BIT(19)
+
 #endif /* __LINUX_USB_QUIRKS_H */
-- 
2.34.1

