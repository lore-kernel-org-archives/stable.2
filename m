Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E26315D40
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784318052; cv=none; b=mM0DEzX/uS+wPV+obuQZMMHQxf2uZldLiF0QhF6VIhz826oMz3p/dmA+c2EJtkoOmDQOWNy3ZkYckFEQsFuWHq2ZAq3CKY2kvq6TZwkiLzrovYOh0XWqbG2vIrk+6Ae9RZppplU/tp3mBqh4BPafWVTv0H7R4jAwK0ukmcJ6LmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784318052; c=relaxed/simple;
	bh=UMNhWfn7lvazagkLejDutmrhlTC/djmEkkcJ3fV5mso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eU4JhoqfA2NzqTHeMbrR0ilP9qbhD+4BpbE+Dl6kS02OPu8CSeRQTjbqK2u1Ia5SzzaTSHccBqkukakJTaCTZiiRN4M1hc1XSA8t3CHZY17LSwbVKxdGHieOLP+nQcXOzSR4hMzrc5nRAq2qKJjBH7gVPYdVkLGjnrjdGKl/uDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtHViB6p; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtHViB6p"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso1658056a91.1
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 12:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784318050; x=1784922850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sXY8b1hZDQ7mURJvEnRYp7HBxIXc1A9y6BqPP38DID4=;
        b=dtHViB6pik6JAGn29fCQbVGD92E/0bHReU72RhSt/0b+BPvG90tN8ToXTdenob7jZm
         olIlW+SfqoSEvNHmR0ErmE61aLQICNoJeD52DqKwEdmLJlWM5NNKiKVJXMH/1L1ocg1G
         mHb3waOQSPKx5AEgM6uA5XTsbIBpkgs75EEFxRwBKLRyLgBlxpyBjFnpOh7zcqUQFO6z
         jJ3F19BIc6jkd77vLzS6DmngjCecYBnzHpIrRjwgxZ3Gq12KBOE57GAS7jyE/ylufpLE
         iCJihZgH7ytqUNrnIEq0uZsXOGR3y+zbhpQZw3QaVXUvp3Dn0dXdEUSpSyr4fbjPN+K5
         jNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784318050; x=1784922850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sXY8b1hZDQ7mURJvEnRYp7HBxIXc1A9y6BqPP38DID4=;
        b=PUCeLvfv963lDXpbM/OluljvIHFMDpVYv3ZRr8Z5+pMh5BPIXhDW0pJuBOdLcWb17t
         6P+6pV2f205u7VKtNuWqE1i8/4T5iVs+jfsczxX3aKegsAfF/9P9faJdYtOsWMo0Hp37
         8g3D5+6JU7ltaBlQIYKjFC397FF26JTrxQCOCdivKT8jJFotWkCEoaAFFEht1GVw62cq
         hARUNuSUvAXrbq1h/ycoJFIrjS/FiIwYAhYzDfV+grVnAtLAPCmzuhM4XJyYBcSDSEFh
         VyOMKRXRztXSh0+1GiT9FM867YvGAe0Xeron1Oe5EIMevhJIvp2xWyRJyp63o5p3dafd
         WUcA==
X-Forwarded-Encrypted: i=1; AHgh+RphBoU3+lxOzt/HOOvgBC8oE4JNPXsqWVTHTiFdbjpz5UwKenLTAw8jk57ZOxxqmKJxgHhpJBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUVRI8RDqA6Q7SdB0DgOPh/qS91SZZ/IVdiQtWYTv2RViQc1lF
	skhjjsCNEZpciLhw/cKi2Wm6zm8neUjibtrgHw+AJ9TS4CSbEMifhG37
X-Gm-Gg: AfdE7clSkNw1saaTK8UKAbwx857g+vv0lL2YR/dErNe3adGucigBXZ9s+IFEgCsJ8p/
	IAejsmUgTks7GtyRwukh5TQG0sdo8Con0VoZzkNtEWzP/UcfIZn7x8lXud5IdBDroHjhqcQHd6t
	YRcsS6bwgqB2QlVssf2CHf8ev1MG5T98k0WXZ32T9FxQ8KEBYDgyiQYyc396aBIizLLJxkx6dWf
	6Mn2s6DxM8y0aSIqTCvkb3iLk9gO9gKn6H1NI3RmOBT4ch94VatjHkCfZIaZnGyiYAWS5jay3b0
	596cJV1HAsNqM3FpJjvGQEYZpeXkmgxb8J6jNcXgEquK1jaB41B+iFHvWKntVA9KbSilScEjnyn
	7U0qaYbhNcIar6Qf3AtpY2LhEM9068WZFljRQzHl0eQHFM7CxlVDUaupEj5RTyYBGWDXCBr/3kn
	6iQxbgL3Rt2Yc6pYWGRO7EbMx9nGVKA0EVrJkLYaeXvdzrp0+zQFHeHeRzGkgPVjJ/3G10gCZiG
	ofASt8h5HGOyA4=
X-Received: by 2002:a17:90b:4c90:b0:38e:1059:f36b with SMTP id 98e67ed59e1d1-38e4b410c20mr3914602a91.10.1784318050351;
        Fri, 17 Jul 2026 12:54:10 -0700 (PDT)
Received: from ghost.localdomain ([103.170.252.7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29c2dcdsm7103119c88.1.2026.07.17.12.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 12:54:09 -0700 (PDT)
Received: from ghost.localdomain (ip6-localhost [::1])
	by ghost.localdomain (OpenSMTPD) with ESMTP id d49a705a;
	Fri, 17 Jul 2026 19:54:00 +0000 (UTC)
From: Nikhil Solanke <nikhilsolanke5@gmail.com>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stern@rowland.harvard.edu,
	michal.pecio@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	stable@vger.kernel.org,
	Nikhil Solanke <nikhilsolanke5@gmail.com>
Subject: [PATCH 1/2] usbcore: Add quirk for 255-bytes initial config read
Date: Sat, 18 Jul 2026 01:23:35 +0530
Message-ID: <20260717195336.98500-2-nikhilsolanke5@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717195336.98500-1-nikhilsolanke5@gmail.com>
References: <20260717195336.98500-1-nikhilsolanke5@gmail.com>
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
---
 .../admin-guide/kernel-parameters.txt         | 10 +++++
 drivers/usb/core/config.c                     | 39 +++++++++++++++----
 drivers/usb/core/quirks.c                     |  4 ++
 include/linux/usb/quirks.h                    |  3 ++
 4 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..14121458a0c0 100644
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
index 45e20c6d76c0..442c15f92ccd 100644
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
index 87ee2d938bc0..f5a60ccf21d3 100644
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
index b3cc7beab4a3..a4043b33c2c2 100644
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
2.55.0

