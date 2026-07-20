Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0D3431E41
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559743; cv=none; b=rX1Kph+aK4w2Yb8zOnhCAMH1jK0PjTUApyovVGrGzrJgjay/jHB6bdTKLO3M2p4ITlLv+MXfw3/jIV1Ygcny+85C+NCTmcbCEk/ni61NXnT0g5EprYwgjEgp+UGNfC9rv0PhmIf8TXKMbEXVOWw2uhWpbdi/suqo5h4cyvCoVBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559743; c=relaxed/simple;
	bh=XwPbFTu9JAB+d4q0Y0232uh5Az6TfXyRG/ODEkksTYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jMk8BoCcH7Wqbv9ge1fvcLIFeUAKGNG9U2/qvGNtgcKbdr0QHNKliGLbRJT9pozE+QdWbYRgfKTDRikRBdBwBYUpdxjemw5D1bAdrY1Xb3CUcE2zT02ki33XfQJkQQ7FmAYn4ddh+7OVgwSWwP7u06KJtv5UVhJczwC3oNwIeyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhxf86Bq; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhxf86Bq"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6685001353fso1917628d50.1
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784559740; x=1785164540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IjM/fiNHXukaVX1tQFmZGILCBKefbnIPCadRHFhRW54=;
        b=dhxf86BqILkDHtMBsoYg+/EVlkbGTuIT4ogCLwY6EQJeE2Yj5LsGRX9ub3fYi0SXj4
         gnbbnB750XBFyR4D1NFLglQJpbv0EUZetqqfb0t8Cba5jOf22NHqM/wL3jCggWNMpKh4
         LixziN4kPzsCL5JBukB5keyvDd95ItotqSmGh/m2njn8Gk2Mb7ysmUJVnn0KkK7s0aai
         dDByDfdxmWDMtBeZ24hphF/roBu3HJN0dVO6k5Zcs4s5YPQaTr0p6rAAbWCuUvXGg9tc
         djHQGlzwmjVlHwwlT/wA3SdRAOpmfk7P8IMucKpWktkvNplW3T9LmomMFKoi3SfWz4Ox
         lXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784559740; x=1785164540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IjM/fiNHXukaVX1tQFmZGILCBKefbnIPCadRHFhRW54=;
        b=ZElvlKAsi1PlbcNA0F5uDuB/eu2bYo1E13+sE+FFAOm+q8XMwCdjZVwnyCfq8TYQEt
         6WyTeH0t4fs8o/yFQ3Ec7RzFiz3QjC3KoxlIDGs1Hn74rnGwQnFwI6j/Bfzhj8kr4w9h
         Y+8rglwTnPuVVscI86OQOQPCOJO/x0bx9v/HEYWRcrwg7hLRK3PKYvRvUjee0xUx/ELA
         AQuWczjuFK28/bfpcUjOC665YRoMy/hWGZtCzrQeCR9fqJVFdl1pJOpTL5gotijqt38N
         5h97D2A0b/X/4PE0n90jOJ95hi8eUuXRzS4XFvPTR5L74ghJKdaJ4/A5HAiVcezc5tIe
         zGmA==
X-Forwarded-Encrypted: i=1; AHgh+Rocjdgd1vPLn3I0haG0eSKuZrAdID5E4nBnZmcqPk58smy1HkxFtQOprOsL9y3HYNQbstOhc8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbVnPqabF01hQBuCf1Cf6TaxvYy1XAXBrJCHKBIq+AU3LW8rog
	vryXomyqC+HLoL3S7FP41EudM/rZSTifGx2/iDdx5GKlJLT/ZefkTsLROsUg0yL47kA=
X-Gm-Gg: AR+sD12gOFHamdJS3RXWF6h1FB/52Jm2NFQq8PoPjXMjWSxhvtPsrHgr8eHqn8kP8Iw
	RCVEcA8D+fCyjXjVV7f4lRPI83dBim1ijT0baAZYz5YXmznOVn+m5mIfnZXBYUUhItfWr/pG8pZ
	gQyx5dp32oK4m449GuFgbRyxndyp6F0cRBH1gef1tc0mjzkpm3FiLTPYYocdHG5XU7eONL5XTQn
	OzFa0PTYNY9FUBCyQkAtRosxGcleZYs9olZh9xWj4qmgXMTSTSdnyiIkY457/Cr8pYqEfu5gEGg
	pk7nSOPEF6FpmJzCK/Vxq9r4jaNzFfkrH+lHKxlaQsV/A+8+hlTx6EAY8TUwZDMXWuTkwLnZcq1
	IQ4rlcy+rDxRzWd+HudcceVosp9a//GEA0vmCAX/h79xOUwS1iKa4bbhbr9jEN+m6TFLMWNL9Va
	cDpMAWw4u5mFcAlT+7QsLPvrcGhL6aElY7uSy7d2CXqOCHTHea8Izu3XOnXpie55YVSjxfLJn8j
	iwZKlD80YtwdglVZtTQYvBLJ4PqjVE=
X-Received: by 2002:a05:690e:160e:b0:667:ba5f:e32e with SMTP id 956f58d0204a3-6683bb2ea20mr2834510d50.14.1784559739663;
        Mon, 20 Jul 2026 08:02:19 -0700 (PDT)
Received: from cachyos-x8664.home.forked.io (c-69-243-124-105.hsd1.md.comcast.net. [69.243.124.105])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9077856002esm94966706d6.11.2026.07.20.08.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 08:02:18 -0700 (PDT)
From: Charles Daoust <charles.daoust@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Charles D'Aoust <charles.daoust@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: core: add USB_QUIRK_CONFIG_DESC_READ_255 for Razer BlackShark V3 Pro
Date: Mon, 20 Jul 2026 11:01:26 -0400
Message-ID: <20260720150207.1963786-1-charles.daoust@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Charles D'Aoust <charles.daoust@gmail.com>

The Razer BlackShark V3 Pro wireless headset dongle (1532:0577)
fingerprints its host during the first enumeration after power-on: if
the first GET_DESCRIPTOR(CONFIGURATION) request asks for 255 bytes, as
Windows does, the dongle enables its vendor HID command channel; if it
sees the 9-byte header-only read that Linux issues, it disables that
channel for the rest of the power session.  Audio still works in that
state, but battery reporting and all vendor commands are silently
ignored, and nothing short of removing power recovers the device:
resets, re-enumerations and byte-exact replays of complete Windows
control sessions were all verified not to help.

Both read lengths are spec-compliant (the device truncates the reply
to wLength); the firmware was evidently only validated against the
larger request.  The kernel already accommodates this class of
firmware assumption during enumeration: hub_port_init() reads the
device descriptor with a 64-byte request because that is what Windows
does and what many devices expect.

Add USB_QUIRK_CONFIG_DESC_READ_255, which makes usb_get_configuration()
request 255 bytes for the initial configuration descriptor read rather
than USB_DT_CONFIG_SIZE, apply it to 1532:0577, and expose it as
runtime quirk letter 'r'.  Devices without the quirk are unaffected.

The trigger was isolated by single-variable bisection on otherwise
unmodified kernels: with only the widened initial read, the dongle's
vendor channel comes up enabled on a cold plug with no interface
drivers bound (bare enumeration only); without it, it never does.

Cc: stable@vger.kernel.org
Signed-off-by: Charles D'Aoust <charles.daoust@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 drivers/usb/core/config.c                       | 13 ++++++++++---
 drivers/usb/core/quirks.c                       |  6 ++++++
 include/linux/usb/quirks.h                      |  3 +++
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8..1bd138ba6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8169,6 +8169,9 @@ Kernel parameters
 				q = USB_QUIRK_FORCE_ONE_CONFIG (Device
 					claims zero configurations,
 					forcing to 1);
+				r = USB_QUIRK_CONFIG_DESC_READ_255 (initial
+					configuration descriptor read must
+					request 255 bytes, as Windows does);
 			Example: quirks=0781:5580:bk,0a5c:5834:gij
 
 	usbhid.mousepoll=
diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index cd3231d21..c7e21cc76 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -908,7 +908,7 @@ int usb_get_configuration(struct usb_device *dev)
 {
 	struct device *ddev = &dev->dev;
 	int ncfg = dev->descriptor.bNumConfigurations;
-	unsigned int cfgno, length;
+	unsigned int cfgno, length, first_read_len;
 	unsigned char *bigbuffer;
 	struct usb_config_descriptor *desc;
 	int result;
@@ -938,7 +938,14 @@ int usb_get_configuration(struct usb_device *dev)
 	if (!dev->rawdescriptors)
 		return -ENOMEM;
 
-	desc = kmalloc(USB_DT_CONFIG_SIZE, GFP_KERNEL);
+	/*
+	 * Some devices (see USB_QUIRK_CONFIG_DESC_READ_255) malfunction unless
+	 * the initial configuration descriptor read requests 255 bytes, as
+	 * Windows does.  Only the header is consumed here either way.
+	 */
+	first_read_len = (dev->quirks & USB_QUIRK_CONFIG_DESC_READ_255) ?
+			 255 : USB_DT_CONFIG_SIZE;
+	desc = kmalloc(first_read_len, GFP_KERNEL);
 	if (!desc)
 		return -ENOMEM;
 
@@ -946,7 +953,7 @@ int usb_get_configuration(struct usb_device *dev)
 		/* We grab just the first descriptor so we know how long
 		 * the whole configuration is */
 		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
-		    desc, USB_DT_CONFIG_SIZE);
+		    desc, first_read_len);
 		if (result < 0) {
 			dev_err(ddev, "unable to read config index %d "
 			    "descriptor/%s: %d\n", cfgno, "start", result);
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 87ee2d938..c8f71b825 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -142,6 +142,9 @@ static int quirks_param_set(const char *value, const struct kernel_param *kp)
 				break;
 			case 'q':
 				flags |= USB_QUIRK_FORCE_ONE_CONFIG;
+				break;
+			case 'r':
+				flags |= USB_QUIRK_CONFIG_DESC_READ_255;
 			/* Ignore unrecognized flag characters */
 			}
 		}
@@ -496,6 +499,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* Razer - Razer Blade Keyboard */
 	{ USB_DEVICE(0x1532, 0x0116), .driver_info =
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
+	/* Razer - Razer BlackShark V3 Pro wireless headset dongle */
+	{ USB_DEVICE(0x1532, 0x0577), .driver_info =
+			USB_QUIRK_CONFIG_DESC_READ_255 },
 	/* Razer - Razer Kiyo Pro Webcam */
 	{ USB_DEVICE(0x1532, 0x0e05), .driver_info = USB_QUIRK_NO_LPM },
 
diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
index b3cc7beab..02de5ed48 100644
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -81,4 +81,7 @@
 /* Device claims zero configurations, forcing to 1 */
 #define USB_QUIRK_FORCE_ONE_CONFIG		BIT(18)
 
+/* initial configuration descriptor read must request 255 bytes (Windows) */
+#define USB_QUIRK_CONFIG_DESC_READ_255		BIT(19)
+
 #endif /* __LINUX_USB_QUIRKS_H */
-- 
2.55.0

