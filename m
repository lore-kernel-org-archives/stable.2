Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313855;
	b=Vnt7f3Kw/nV/wi+u5V28FFlvxAsJT9GMA4omSnCPLUbiHC4pCtSSt6JMJhoBnOEO0UEp
	 w3JJ5vJsGicOh+PzDzx6StSgXGoM99OXxVzOJnvCJnaTPyHeNrcEEyC0d9KCoN0CdUyv0
	 yr8dXRabJc+y0SlcRLtpti5teDIUpSQnreoB+d0lf4Xu5j+ghv2PBg3OE07jGuN3oTdhI
	 tqHSHiYHUC6BAUwfWu4nqNS4dzm2WEBd00tysbd+FLt78hGgpDLZYbOK7DUJnN8Dl/0M2
	 I9H+va56zyf+DrEY4Vu6ArReIVuFMrajvr+8ilmXNLFgUmaWQWYvh5FtHqXvdgegRmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313855;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0vimwi1pgTxZrozV3Blnx7g7QDT44ojWpTT5wwrrimY=;
	b=kWD+lsEGcG4MmphR4+1NM8QJyvvgMCjTF2Pegu9crcIpe9It/cU+HAB8HYKT7wTqBc6y
	 kdAan4QGE9QoG1fMZ39P/tsjVmJCJZC1Qh5ffRICMaNfmYKOaRASNKVN/T+FTV3zL2Gs8
	 gf1tMfmrzwFp0G0tHcwAgfghdapZcjvyVjJHsYG8A8shc2jpIQodpjn5RGBK48grziZvi
	 /eMA3uLOY7yxqyi+frvb0AcPmx3EaBWVo14Gn+lRCUQhmv9hqUKEIP13gLTu/SKNq1Ren
	 3gGY/wcpmz+p2czq34Z+trTYrVYRA3evD+GZZgfrNM3ARDgmjZwh+K89mcghRpUYQnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hhnptt2r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06D7606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hhnptt2r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235A71F0089F;
	Tue, 10 Nov 2026 12:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313854;
	bh=0vimwi1pgTxZrozV3Blnx7g7QDT44ojWpTT5wwrrimY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hhnptt2rxxaEvQtTf4FB7py0tYfKpDzis6AfrzzyDm4ad055oJ6TJqeNvwKGXh3KS
	 6ni7SDSC6u3euzM1EKnyTwGZaYdIoQR0Ni4H7al+uEKzZFUR/GGOHzu1b1UX8mu5zT
	 QD3Sjv5djd2AAQvERx2bgSIXbll5NaDspeLeoT/nLm9mdmOQ/fOtZPbanCUihVNeJi
	 mbshFf6Zi3KuOyHICTIntCCMesppYifZuh0916MB8+w2PRXO+neDFOag13GuVtxhij
	 SU8vXH5RvpFSbx6TwCK5STCpDopkj8W17Lp34QtH57cuO6ssm0THcvcFoVkhIfqFCn
	 w2/OqAeKYXGzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nikhil Solanke <nikhilsolanke5@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Michal Pecio <michal.pecio@gmail.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] usb: core: Add quirk for 255-bytes initial config read
Date: Tue, 10 Nov 2026 07:30:50 -0500
Message-ID: <20261110123027.1222319-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052058-failed-6.12-40224df29729@kernel.org>
References: <20261107052058-failed-6.12-40224df29729@kernel.org>
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
index 886095f45290e..82149bce3ddef 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7260,6 +7260,11 @@
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
index 43f1419d66175..1dbff53984588 100644
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

