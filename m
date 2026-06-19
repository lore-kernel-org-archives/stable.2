Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EA633D4F2
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781863207; cv=none; b=C8/eCuKx0dzm7jckKAitXkQQ4PsJAfTGS1cgLOz6J0Eoyg+bj37hRp+MEgOmP9OpjDMCzDuGGLClmF5E1jjN81BsoK7en66UZ4hfVMAzw/qrkIroDDw08J5rHmpc1aiiD2CvkGIilwaBzX9zkJbLHF9AOxQqZ0IsjRuw5xAuA34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781863207; c=relaxed/simple;
	bh=HfmQkOtk9IaM+WPmz7eE7lkMj2hf2wlI6dSjVLexa2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qJSFugq2UNDWNqkVTjaGGncNaWrYR223BXAXBceszpBOOlYYoS9TFr8gKHdsKnTbEVHO/4ZNZUzjvNWAdVLPf3yXZ0wjtVVUvKUn/JSjMGTY57xtUj7FkGsKv/DkK59/KCBujHDOygF/VK2r0WVL1JvvcfhlZIKn77TlChxASek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rTqxvQZ3; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTqxvQZ3"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-842307472d4so847613b3a.0
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 03:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781863201; x=1782468001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8d76X3icq3/Ja/CPqgRT+rRdC5OqM1uOzKiEQhI8PbA=;
        b=rTqxvQZ3BdDoqe3jN23HJOP5iuif+JPdlRrNuhMzi1QkLGv8es08fAX+yTs427RBCX
         Rq9aMhqvBxFKfGxMeflz/996nDop0HjQ/fuugWruwMFIXCJyoysjBQoFn/kEjyPpuj4T
         dGZVYQX5zhtHUcnHaQ8r6p4Q0+DY6/Emg5S6but9cW322mnFYjmjQN0/BxHyuR3Yne6M
         LsrcmnIXFpVALIT5lNaaQEKQK7goFQI/0R9PlmvYon+U0kihW1b+t10fcFp9cQbNqiRV
         YfhkFiCfKIPv3A+J2qY3+VBacuNQhEKpVwNi+p5sv45Mphm3+cBHy423ZHjiqpfVeQ1k
         xphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781863201; x=1782468001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8d76X3icq3/Ja/CPqgRT+rRdC5OqM1uOzKiEQhI8PbA=;
        b=NgM4CB/32cQ0KMNPJPAF97v4h9AFiObDBeJR2g+du0zHJ/LV1MhVMPii0Sge+pv8u/
         CnQNmgwQT0WvXmCBQ3+9d/iSpgiRJ17dZAibicc9p+bnmUhz98JZyA7NuVXap2k7/gbH
         N2DA7cXJIbQSFdW/InfgAXg5ekaJYHF6JH3QAWh0t+8OsQGagyNjiKFoMHQEUU1JSH+H
         ZYkOnKvBDx3lJplklq2QeD6FhYsHEjPm7/pGvym5Bp+BdSQ6zVvggaiGPFqusNvFbg6F
         sFzeXYSguUTjJP5PrxBBK5eY8WZaM+Fao8pOOGiz5wjiFpWXWBl7By7sxptZzcK3Owpn
         NREw==
X-Forwarded-Encrypted: i=1; AFNElJ8Kjz1aSa2q1h5q/ij0Ww/b9g/hhcIW/kOu2dzpzjyGrTUZ6dLRpTNkJo19JxEeRSbUBjixHcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHjYqjKL/+oSl/MKRbQf6RG3r7gWCZs/LccxYGtgHa7HXCUH1a
	DlV8li/MUP/6ja3n8xSuBOUktKfd9Fh46oiYoQ7igeLtXMhtXW6/M1J7
X-Gm-Gg: AfdE7cl7jTLJZuZQl4xQJsdW4LeawPdUfLOABAyRzx43tsstX5L9KAxqZ3220GZVy4x
	WuW7VwBG+/0077TBAlcazvZN+25wNod4pbbQSpfrNXH1usJd26IJenPR0l1eUur3UAfiwU3vhl4
	XvrX9dsdpxJgbqFiG5ipIYc82XcQ6+Pqzmt4zrcJAky4mJ9cC8swJ0zTbDN4OvMYNoxaBlysc/q
	6q4SonDI43PujHaDAQkDlST3PO5oZpbJQUjhg/oKGBxxUgU7/xuASL+9mNiwBZVpwgRkcoDdPaM
	h3a+LK+APuk0i1uIdxmN66wUP4onAn4s338mREopJcOP87BZ162+4mOd+uJk/vo3bL6zrh3pTaR
	qXP9N7YdPg/W75IL+aiiywc/PHHGqz2o1DBZHHINeXkQGAjtfa1qcVen4lkbqwSL5WYMyz8k1MW
	8W9/fq8r28FEX1hQ==
X-Received: by 2002:a05:6a20:6a0f:b0:398:9b42:69f7 with SMTP id adf61e73a8af0-3bb34658412mr2933727637.39.1781863201220;
        Fri, 19 Jun 2026 03:00:01 -0700 (PDT)
Received: from ghost ([2409:40c2:6043:71b1:a047:7236:4a11:a43c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8a84c6e5fbsm2231370a12.7.2026.06.19.02.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 03:00:00 -0700 (PDT)
Received: from ghost.localdomain (localhost [127.0.0.1])
	by ghost (OpenSMTPD) with ESMTP id 2d3f23de;
	Fri, 19 Jun 2026 09:59:55 +0000 (UTC)
From: Nikhil Solanke <nikhilsolanke5@gmail.com>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stern@rowland.harvard.edu,
	michal.pecio@gmail.com,
	stable@vger.kernel.org,
	Nikhil Solanke <nikhilsolanke5@gmail.com>
Subject: [PATCH] usbcore: Add quirk for 255-bytes initial config read
Date: Fri, 19 Jun 2026 15:29:36 +0530
Message-ID: <20260619095936.24080-1-nikhilsolanke5@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
enumerates correctly in Android mode when the same aklsjdasd 9-byte request
is issued for that mode's configuration descriptor, confirming the firmware
bug is specific to the XInput mode.

usbmon traces from Linux and Wireshark/USBPcap traces from Windows are
identical up to the point of failure, with no visible protocol-level
difference explaining the divergence. The root cause was identified when
Michal Pecio discovered via a QEMU bus-level capture that Windows does not
use wLength=9 for the initial config descriptor request; it uses
wLength=255. This is not visible in Windows Wireshark/USBPcap traces
because Windows routes enumeration-phase traffic to sniffers only after
initialization completes. Alan Stern subsequently confirmed this with a bus
analyzer on a different USB 2.0 device, and Michal verified the behavior
goes back to Windows 95 OSR2.1.

So, add a new quirk flag USB_QUIRK_CONFIG_SIZE which causes
usb_get_configuration() to issue a 255 byte sized configuration request
instead of USB_DT_CONFIG_SIZE (9) for the initial
GET_DESCRIPTOR(CONFIGURATION) request, mimicking long-standing Windows
behavior.

Suggested-by: Nikhil Solanke <nikhilsolanke5@gmail.com>
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Suggested-by: Michal Pecio <michal.pecio@gmail.com>
Closes: https://lore.kernel.org/linux-usb/CAFgddh+JWdT4LLwMc5qjM8q_pBu-fRo2qADR5ovAKoGHWMQrRw@mail.gmail.com/
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: <stable@vger.kernel.org>

Signed-off-by: Nikhil Solanke <nikhilsolanke5@gmail.com>
---
 drivers/usb/core/config.c  | 56 +++++++++++++++++++++++++++-----------
 drivers/usb/core/quirks.c  |  3 ++
 include/linux/usb/quirks.h |  4 +++
 3 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 45e20c6d76c0..623425cef085 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -912,6 +912,8 @@ int usb_get_configuration(struct usb_device *dev)
 	unsigned char *bigbuffer;
 	struct usb_config_descriptor *desc;
 	int result;
+	size_t usb_dt_config_size = (dev->quirks & USB_QUIRK_CONFIG_SIZE)
+		? USB_DT_CONFIG_SIZE_QUIRK : USB_DT_CONFIG_SIZE;
 
 	if (ncfg > USB_MAXCONFIG) {
 		dev_notice(ddev, "too many configurations: %d, "
@@ -938,7 +940,8 @@ int usb_get_configuration(struct usb_device *dev)
 	if (!dev->rawdescriptors)
 		return -ENOMEM;
 
-	desc = kmalloc(USB_DT_CONFIG_SIZE, GFP_KERNEL);
+	desc = kmalloc(usb_dt_config_size, GFP_KERNEL);
+
 	if (!desc)
 		return -ENOMEM;
 
@@ -946,7 +949,7 @@ int usb_get_configuration(struct usb_device *dev)
 		/* We grab just the first descriptor so we know how long
 		 * the whole configuration is */
 		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
-		    desc, USB_DT_CONFIG_SIZE);
+		    desc, usb_dt_config_size);
 		if (result < 0) {
 			dev_err(ddev, "unable to read config index %d "
 			    "descriptor/%s: %d\n", cfgno, "start", result);
@@ -957,26 +960,39 @@ int usb_get_configuration(struct usb_device *dev)
 			break;
 		} else if (result < 4) {
 			dev_err(ddev, "config index %d descriptor too short "
-			    "(expected %i, got %i)\n", cfgno,
-			    USB_DT_CONFIG_SIZE, result);
+			    "(expected %zu, got %i)\n", cfgno,
+			    usb_dt_config_size, result);
 			result = -EINVAL;
 			goto err;
 		}
-		length = max_t(int, le16_to_cpu(desc->wTotalLength),
-		    USB_DT_CONFIG_SIZE);
+		/* If the device does returns the full length configuration
+		 * descriptor, skip the second read. Fallback to default
+		 * behavior otherwise.
+		 */
+		if (dev->quirks & USB_QUIRK_CONFIG_SIZE
+				&& result == le16_to_cpu(desc->wTotalLength)
+				&& result < USB_DT_CONFIG_SIZE_QUIRK) {
 
-		/* Now that we know the length, get the whole thing */
-		bigbuffer = kmalloc(length, GFP_KERNEL);
-		if (!bigbuffer) {
-			result = -ENOMEM;
-			goto err;
-		}
+			bigbuffer = (unsigned char *) desc;
+			desc = NULL;
+			length = result;
+		} else {
+			length = max_t(int, le16_to_cpu(desc->wTotalLength),
+			    usb_dt_config_size);
+
+			/* Now that we know the length, get the whole thing */
+			bigbuffer = kmalloc(length, GFP_KERNEL);
+			if (!bigbuffer) {
+				result = -ENOMEM;
+				goto err;
+			}
 
-		if (dev->quirks & USB_QUIRK_DELAY_INIT)
-			msleep(200);
+			if (dev->quirks & USB_QUIRK_DELAY_INIT)
+				msleep(200);
 
-		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
-		    bigbuffer, length);
+			result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
+			    bigbuffer, length);
+		}
 		if (result < 0) {
 			dev_err(ddev, "unable to read config index %d "
 			    "descriptor/%s\n", cfgno, "all");
@@ -1000,6 +1016,14 @@ int usb_get_configuration(struct usb_device *dev)
 	}
 
 err:
+	/* Log failed device's VID:PID pair to make it easy to debug and fix
+	 * enumeration and initialization issues
+	 */
+	if (result < 0) {
+		dev_err(ddev, "Failed to initialize device %04x:%04x due to above errors.",
+		    le16_to_cpu(dev->descriptor.idVendor), le16_to_cpu(dev->descriptor.idProduct));
+	}
+
 	kfree(desc);
 	dev->descriptor.bNumConfigurations = cfgno;
 
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 87810eff974e..92219684a604 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -142,6 +142,9 @@ static int quirks_param_set(const char *value, const struct kernel_param *kp)
 				break;
 			case 'q':
 				flags |= USB_QUIRK_FORCE_ONE_CONFIG;
+				break;
+			case 'r':
+				flags |= USB_QUIRK_CONFIG_SIZE;
 			/* Ignore unrecognized flag characters */
 			}
 		}
diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
index b3cc7beab4a3..f864571da870 100644
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -81,4 +81,8 @@
 /* Device claims zero configurations, forcing to 1 */
 #define USB_QUIRK_FORCE_ONE_CONFIG		BIT(18)
 
+/* Use a 255 byte sized config descriptor request */
+#define USB_QUIRK_CONFIG_SIZE			BIT(19)
+#define USB_DT_CONFIG_SIZE_QUIRK		255
+
 #endif /* __LINUX_USB_QUIRKS_H */
-- 
2.54.0

