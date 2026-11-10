Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314208;
	b=vk7y2/wOwi4UAyyxWmzfz1xCu/1ouqYs91H7EHRroTjkssES0KGYuIHr25AzOocMRcQ8
	 yhRpj4Z+79MNSzyhNENws/dNJGExC2T5AgdI2wU1S+hbX3MQZ+ksFH2tRfplrf7DCZMPv
	 0GmY1mLHl6Ncl6Te59oj1BXWEFUjvMNSP8fpPr0lfOCDSn8Xhl+tf88rYKzbk0ohcK1UO
	 k2a7OxADbUKxuOTkkXQpjpyI2iEoM5QjR+ZRmxI5O/+SxJ8E+JmLfWUFQxgxY+J5Dr42k
	 aq7eQkCCoM5v1WgTi41S5OmAHhwF32CxVk+2aYLS8h9qS7o9fP3pR1M4lU9OiG/Adkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314208;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iDmvNu/rSDkI1oIEAKb9R+krLNKJ6C/ET3oP2FjeFX0=;
	b=n70lns10t5SQjGNjgK4efYIC+LbEkeAHVR88d8cOjvU3/5kjOnuFVy6rWX0R00fRkbZF
	 6CicWPDGhetLVgd8jwiegh5OY6UTkrY0hGB/13FEkrFuxseVwVFNrTcmkQq84XaKDPwNF
	 c44QGQW+KZdF+ns7TxMvwRlMn/WH71OfLP/evlUZr4YLg4dyuiiu5Jt55HaZ37+gDhbzj
	 Nrhy2QOe9pna52EMOMUPKhCGdkWul8+sYNDkzSDvR3dNVHf3zZI4iD38B95B5sKw9VRDt
	 Cza57RfPMyn5cCPcTDnp5TIQsaJ0vefiOhBhflwKGzYYy83Bt4ZdDqTp00DZjJgPP8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aruT4YoK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C41606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aruT4YoK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9557D1F0089F;
	Tue, 10 Nov 2026 12:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314208;
	bh=iDmvNu/rSDkI1oIEAKb9R+krLNKJ6C/ET3oP2FjeFX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aruT4YoKfSmMulx9uUwgx/uY+I9nKpNoJH5G47zvvlr5VXhH3aM3PjmxNBvLKOY6I
	 W7PF8U1W924PsCU5LV3uFJgU1vTy4hIrVSnvZhjanatTrnD9LRErFaksrAIGAGeQYw
	 6/VaDf7QG+cjQJkg/LSo+HzY+4vcIHXoNtaHmx+0oe9HR11O/p+sa6C9vX9pPCSCu+
	 SLFHLjg0fPOxmKLwq9pyQX/B/RlbQ7kza5majCmOB4aXw3nWqbOKoSSdYiriePyh6+
	 9qt61n34zu75rXMDYD3MNZC+6Jlne+4WK32hg8KE2rBGaD4sS+4oFSOK0/oziRuVba
	 YUDeSpqMuLezA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nikhil Solanke <nikhilsolanke5@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Michal Pecio <michal.pecio@gmail.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] usb: core: Add quirk for 255-bytes initial config read
Date: Tue, 10 Nov 2026 07:36:45 -0500
Message-ID: <20261110123625.1288453-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053324-failed-6.6-40224df29729@kernel.org>
References: <20261107053324-failed-6.6-40224df29729@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nikhil Solanke <nikhilsolanke5@gmail.com>

[ Upstream commit 152f174a13618bec1f842d2deb69245cb2ace51f ]

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
Cc: stable <stable@kernel.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Nikhil Solanke <nikhilsolanke5@gmail.com>
Link: https://patch.msgid.link/20260728195158.65162-2-nikhilsolanke5@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 40224df29729 ("USB: quirks: add USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE for GameSir G7 SE")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++
 drivers/usb/core/config.c                     | 32 ++++++++++++++-----
 drivers/usb/core/quirks.c                     |  4 +++
 include/linux/usb/quirks.h                    |  3 ++
 4 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fdbc2749fbb37..50e988c8995fc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6904,6 +6904,11 @@
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
index 7713526680d74..d9f874d776323 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -891,6 +891,18 @@ int usb_get_configuration(struct usb_device *dev)
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
@@ -917,15 +929,13 @@ int usb_get_configuration(struct usb_device *dev)
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
@@ -935,16 +945,14 @@ int usb_get_configuration(struct usb_device *dev)
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
 		length = max((int) le16_to_cpu(desc->wTotalLength),
 		    USB_DT_CONFIG_SIZE);
 
-		/* Now that we know the length, get the whole thing */
 		bigbuffer = kmalloc(length, GFP_KERNEL);
 		if (!bigbuffer) {
 			result = -ENOMEM;
@@ -954,6 +962,13 @@ int usb_get_configuration(struct usb_device *dev)
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
@@ -968,6 +983,7 @@ int usb_get_configuration(struct usb_device *dev)
 			length = result;
 		}
 
+store_and_parse:
 		dev->rawdescriptors[cfgno] = bigbuffer;
 
 		result = usb_parse_configuration(dev, cfgno,
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 6ed3805994055..23d5c30332ffb 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -143,6 +143,10 @@ static int quirks_param_set(const char *value, const struct kernel_param *kp)
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
index b3cc7beab4a3c..a4043b33c2c2a 100644
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
2.53.0

