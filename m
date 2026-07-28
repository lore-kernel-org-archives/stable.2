Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA01E470EB2
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 19:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268334; cv=none; b=o3+HWTd/i/oSEAwQVGonpGw2YRJT6COfhq+0W4AUv/we2FAKzF3Y7QLGEDfvIrMUfKNdPa8L+xPRD+4SWb5hk9gJBulq+uA5GifwVqSbEGwXLh4QT0MIiNxZh7O8shK3Kx1qnoRdBgU1+D9YgGGnaH3jeP4N6UOsnHUozlg7D+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268334; c=relaxed/simple;
	bh=Nj8Uu4X/8wvVYZY4l0Sd8MNETHKyAv52T2oSotFNfRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CB/mplM2Xx6bhe6RUHACpzytrJLH5bONudhkEIpBOudxN6RG0YTB5U4hkRD0ORU1HRQ3UcOJkOjjiH7nVlCyy8zfl7G8EPyMGkLLm/j9l4xP6TWZypRHTiLDLc1EVxiD6vanLbmCNvxnA/5W41TZo5D8Tayg0bBl0cEiZU+4+6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkd4pSvp; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkd4pSvp"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cfff5f88dbso2892055ad.3
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 12:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785268332; x=1785873132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NLQ5jvybCf/zGwa1IealBNI//5/h9wcvMKi+jtTkRd4=;
        b=gkd4pSvpCaC1gGxUiGgtCx9OHV9ypJ48wjAk6aInZqJYQQ8JC2GU2wx86OoGmfQr6Q
         x/quCLMGvtxOxrgpN2qTEgTi9ff93p0Ffi2pla4OvtDZQmKiJ6+gJuKvNMstXkK/hJ03
         Q2VgS5fHgkdw/OPfDOaBUEZcyBV2nJMlEkHkEFQe+v+q6xHstJkXph8ogunFftvWUFsJ
         03KixhpEGk2o239GT6aZzFnE3dKGeJ6wr2Q6+NLxLSNmnDULQIn27wRoJBgk/l+5iQuU
         hXg/m4weLcLAjf9AawecEPWnzIB7o+cqDyyIwlQej2rdJT7XWo2yyWn5EDVCNPMRln/m
         HCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785268332; x=1785873132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NLQ5jvybCf/zGwa1IealBNI//5/h9wcvMKi+jtTkRd4=;
        b=k+r4tBrDq7+m+6CgpuouiZMIOK+DompK2uW9wyi9Y6VKkPS+osZnfEhtow2O573r5U
         /laWaq//hEsCGW9W//+JA8iF8B5eruLzuFTZ3ucKxz4jQzc7PfNm2iWpS9osalWgE8gN
         D6vJbE/kYy0lGmRn7oHDU/yrOJd2JWnXDfgl3rKqU/7mRRgZlYF31MOa2pQlHCPjuk6E
         MoA1ZQ8oEgw/lKNYAp16Zis5PdW3b4bZe+O/CT/bPaBDyla68mjI02lgO+EdK0LUSjcT
         s+H+s8sY+5tl3uHCZw7Z5EGW34zoH4hzff7tgLL+cilHlciCaaDYjmfL+a5Fnd/RWlPo
         Ltxg==
X-Forwarded-Encrypted: i=1; AHgh+Rq8vavlhSFdfFSBrpr6KGBbgU9yU6fxMSKoc3cE9v85hFPzCNUQBiTcUhQUzmU4fMxtmugHQmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvZSBWMBopW7X+3mHce7uTtkOewBuiWriNhexdQb5Ofr0933vu
	kdLUz4nDz6QGBgZgoxHFja2YZtAc/LM7j7lQLPq+cBR32CQFY2Wimnoa
X-Gm-Gg: AR+sD10cnXYJhlWsUttPPvtV9eFDrd7ALNkrXF1GPjkbE3MacTjlsoq1fZU5qSOvqQr
	wmAvN9jxb6XbND/LEueLTsqN6EyQIlkwhNIBJubWA7Vbk+/7yW4+aNe3QICfVwLWP0ABSDA36uE
	OLCVg0qx95GVOmnx9CbM71ymCgk4GGsw09zXlwwTT9RR1M2Ql/nWGvsZ6PJtmtqcintgpE53I0K
	4oQj8dO6Z6Uu9njQNTz/g+NCHDsYA+U0OoBT4yEQV9HW54VjYJkGQqNaquhlGkPTZ0pp1vMaCZS
	HR3wFdY/r92kOHPTSjZjZDiXLKzRP5eYtDWn0UZ84DTSMcnI55CxynzELFmcq3rAjarnTMypSZh
	bUydSHLme3LMiiQzGjtpGEy9snRaplo4mb0qSupixH9j9EAu3qJCFJRhLOn7+q2QuffRExVutYJ
	ub3zLg8XCp15GJnd8QQNbp2tP2FwyPZe+s0PyUgK4OM7014eYJ9y/AlcGlkvFkusk0pAF6bAxb/
	QySk/W8JkgU+zFmNw9bPUb8ktylnA0aKwJ0gTcse6ywOWboYiGpdA==
X-Received: by 2002:a17:903:2ca:b0:2c6:9f66:d573 with SMTP id d9443c01a7336-2d015acd4c1mr45653945ad.2.1785268332085;
        Tue, 28 Jul 2026 12:52:12 -0700 (PDT)
Received: from localhost ([103.170.252.6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d480c5sm2525348eec.25.2026.07.28.12.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:52:11 -0700 (PDT)
From: Nikhil Solanke <nikhilsolanke5@gmail.com>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stern@rowland.harvard.edu,
	michal.pecio@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	stable@vger.kernel.org,
	linux-doc@vger.kernel.org,
	ishaan.dandekar@gmail.com,
	Nikhil Solanke <nikhilsolanke5@gmail.com>
Subject: [PATCH v5 1/2] usb: core: Add quirk for 255-bytes initial config read
Date: Wed, 29 Jul 2026 01:21:57 +0530
Message-ID: <20260728195158.65162-2-nikhilsolanke5@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728195158.65162-1-nikhilsolanke5@gmail.com>
References: <20260728195158.65162-1-nikhilsolanke5@gmail.com>
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

This patch intentionally does not add any new VID:PID entries using this
quirk. Some affected Xbox 360-compatible controllers spoof Microsoft's
VID:PID, while genuine Microsoft controllers already enumerate correctly
and do not require this quirk. Other affected clone devices use their own
VID:PID pairs and can be added individually as they are identified.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Suggested-by: Michal Pecio <michal.pecio@gmail.com>
Closes: https://lore.kernel.org/linux-usb/CAFgddh+JWdT4LLwMc5qjM8q_pBu-fRo2qADR5ovAKoGHWMQrRw@mail.gmail.com/
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Nikhil Solanke <nikhilsolanke5@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++
 drivers/usb/core/config.c                     | 32 ++++++++++++++-----
 drivers/usb/core/quirks.c                     |  4 +++
 include/linux/usb/quirks.h                    |  3 ++
 4 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..3d35270dddef 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8169,6 +8169,11 @@ Kernel parameters
 				q = USB_QUIRK_FORCE_ONE_CONFIG (Device
 					claims zero configurations,
 					forcing to 1);
+				r = USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE (Device
+					fails during initialization when asked for
+					9-bytes configuration descriptor request.
+					Ask for 255-bytes request instead to mirror
+					Windows' behavior);
 			Example: quirks=0781:5580:bk,0a5c:5834:gij
 
 	usbhid.mousepoll=
diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 45e20c6d76c0..346a2faa9bb8 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -912,6 +912,18 @@ int usb_get_configuration(struct usb_device *dev)
 	unsigned char *bigbuffer;
 	struct usb_config_descriptor *desc;
 	int result;
+	size_t usb_config_req_size;
+
+	/*
+	 * We usually start by grabbing the first 9-bytes descriptor so we know
+	 * how long the whole configuration is. Some devices with quirky
+	 * firmware will fail enumeration, so if the quirk is set, use 255 instead,
+	 * mirroring the behavior of Windows.
+	 */
+	if (dev->quirks & USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE)
+		usb_config_req_size = 255;
+	else
+		usb_config_req_size = USB_DT_CONFIG_SIZE;
 
 	if (ncfg > USB_MAXCONFIG) {
 		dev_notice(ddev, "too many configurations: %d, "
@@ -938,15 +950,13 @@ int usb_get_configuration(struct usb_device *dev)
 	if (!dev->rawdescriptors)
 		return -ENOMEM;
 
-	desc = kmalloc(USB_DT_CONFIG_SIZE, GFP_KERNEL);
+	desc = kmalloc(usb_config_req_size, GFP_KERNEL);
 	if (!desc)
 		return -ENOMEM;
 
 	for (cfgno = 0; cfgno < ncfg; cfgno++) {
-		/* We grab just the first descriptor so we know how long
-		 * the whole configuration is */
 		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
-		    desc, USB_DT_CONFIG_SIZE);
+		    desc, usb_config_req_size);
 		if (result < 0) {
 			dev_err(ddev, "unable to read config index %d "
 			    "descriptor/%s: %d\n", cfgno, "start", result);
@@ -956,16 +966,14 @@ int usb_get_configuration(struct usb_device *dev)
 			dev->descriptor.bNumConfigurations = cfgno;
 			break;
 		} else if (result < 4) {
-			dev_err(ddev, "config index %d descriptor too short "
-			    "(expected %i, got %i)\n", cfgno,
-			    USB_DT_CONFIG_SIZE, result);
+			dev_err(ddev, "config index %d descriptor too short (asked for %zu, got %i)\n",
+			    cfgno, usb_config_req_size, result);
 			result = -EINVAL;
 			goto err;
 		}
 		length = max_t(int, le16_to_cpu(desc->wTotalLength),
 		    USB_DT_CONFIG_SIZE);
 
-		/* Now that we know the length, get the whole thing */
 		bigbuffer = kmalloc(length, GFP_KERNEL);
 		if (!bigbuffer) {
 			result = -ENOMEM;
@@ -975,6 +983,13 @@ int usb_get_configuration(struct usb_device *dev)
 		if (dev->quirks & USB_QUIRK_DELAY_INIT)
 			msleep(200);
 
+		/* Skip the second read if we already got everything */
+		if (result >= length) {
+			memcpy(bigbuffer, desc, length);
+			goto store_and_parse;
+		}
+
+		/* Get the whole thing */
 		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
 		    bigbuffer, length);
 		if (result < 0) {
@@ -989,6 +1004,7 @@ int usb_get_configuration(struct usb_device *dev)
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
2.54.0

