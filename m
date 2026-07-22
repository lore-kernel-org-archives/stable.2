Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D501352025
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728503; cv=none; b=E0PJQET0in2sJC35L49u0zLT+qku6yjHeTnRr6VL8r6CMlZCRQ9ZSNqCaGMi0hveUEHSt55bgb2wo5/PP4aKys9kNjYkZUFtosv8fHbmfRsUxmAWb2ZACtYRDQ5PBlVyqtPzoUMjsPSbOXdYCX8r6gOVdUT3jN+JA/fDUiHI8SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728503; c=relaxed/simple;
	bh=cyB3MZgbuYFCU3YatydX39TvivqddKKBqtCbeiUDgh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMK63G953BHaV809WbzeLXBAnlO2RilnAPeS4zCd53WKC/KHeciSUgaHRKouc5xBYO6MzHxNDQlqmdvMUmnR1LbuKtxuk534V7oWuqC/w1SLOr74exK53DaYwFAvyQCZ4eg+y5qRWbyg0dcGaKJbMlbXXzLkWylR2LciF3eH/yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8Fw40YT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8Fw40YT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45411F00A3E;
	Wed, 22 Jul 2026 13:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784728502;
	bh=qsoi3J+cWBgu7KbwQFGOrwZ9vHJ2fZYR+scKQfwkWvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k8Fw40YTFolG/gpSNvX/7ItXXMH2gUpxtAwYfd/A0gminTacUX5S61aLMhhl/YLw/
	 +y3MRDruQRbFjFYXCGK7zA380KiIcz8COIL2kaVUWh7OpjGznb3CJNo+c6ou/CTyA7
	 W/QNLs8fe6FPeiDSNJCqbcPxaR+OTKr/teG1sKDI1resJ3Qb39HJ+oj2rR2VNczebj
	 a7CH4l9huewysPEDqXikzyKP8IzpxNRYRziCnA6Q6eEW6aMvbfVo+7oA/gDR+hUgqv
	 t1fHMFJhTvuk6iFW2EYHYLdB7rZDQGGironUifj3/w9yw3ryjhmrYGRi9iZsACWTcL
	 lUrJydY3gCttw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/7] media: uvcvideo: Disable autosuspend for Insta360 Link
Date: Wed, 22 Jul 2026 09:54:54 -0400
Message-ID: <20260722135457.1366301-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722135457.1366301-1-sashal@kernel.org>
References: <2026072041-maverick-blooper-4a13@gregkh>
 <20260722135457.1366301-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ricardo Ribalda <ribalda@chromium.org>

[ Upstream commit 3de6df64f92d8633eb51a5e957ffc43ebdb2156e ]

When the device suspends, it keeps power-cycling.

The user notices it because the LED constanct oscillate between
blue (ready) and no LED (off).

<6>[95202.128542] usb 3-3-port4: attempt power cycle
<6>[95206.070120] usb 3-3.4: new high-speed USB device number 49 using xhci_hcd
<6>[95206.212027] usb 3-3.4: New USB device found, idVendor=2e1a, idProduct=4c01, bcdDevice= 2.00
<6>[95206.212044] usb 3-3.4: New USB device strings: Mfr=1, Product=2, SerialNumber=<Serial: 1>
<6>[95206.212050] usb 3-3.4: Product: Insta360 Link
<6>[95206.212075] usb 3-3.4: Manufacturer: Amba
<7>[95206.214862] usb 3-3.4: GPIO lookup for consumer privacy
<7>[95206.214866] usb 3-3.4: using lookup tables for GPIO lookup
<7>[95206.214869] usb 3-3.4: No GPIO consumer privacy found
<6>[95206.214871] usb 3-3.4: Found UVC 1.10 device Insta360 Link (2e1a:4c01)
<3>[95206.217113] usb 3-3.4: Failed to query (GET_INFO) UVC control 14 on unit 1: -32 (exp. 1).
<3>[95206.217733] usb 3-3.4: Failed to query (GET_INFO) UVC control 16 on unit 1: -32 (exp. 1).
<4>[95206.223544] usb 3-3.4: Warning! Unlikely big volume range (=32767), cval->res is probably wrong.
<4>[95206.223554] usb 3-3.4: [9] FU [Mic Capture Volume] ch = 1, val = -32768/-1/1
<6>[95210.698990] usb 3-3.4: USB disconnect, device number 49
<6>[95211.963090] usb 3-3.4: new high-speed USB device number 50 using xhci_hcd
<6>[95212.657061] usb 3-3.4: new full-speed USB device number 51 using xhci_hcd
<3>[95212.783119] usb 3-3.4: device descriptor read/64, error -32
<3>[95213.015076] usb 3-3.4: device descriptor read/64, error -32
<6>[95213.120358] usb 3-3-port4: attempt power cycle

Bus 001 Device 009: ID 2e1a:4c01 Amba Insta360 Link
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x2e1a
  idProduct          0x4c01
  bcdDevice            2.00
  iManufacturer           1 Amba
  iProduct                2 Insta360 Link
  iSerial                 0
  bNumConfigurations      1

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20221101-instal-v1-0-d13d1331c4b5@chromium.org
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Stable-dep-of: f078966ca1fb ("media: uvcvideo: Fix sequence number when no EOF")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 14 +++++++++++++-
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 8605c3e298cb2a..5a7c784fe603b8 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2300,8 +2300,11 @@ static int uvc_probe(struct usb_interface *intf,
 	if (dev->quirks & UVC_QUIRK_NO_RESET_RESUME)
 		udev->quirks &= ~USB_QUIRK_RESET_RESUME;
 
+	if (!(dev->quirks & UVC_QUIRK_DISABLE_AUTOSUSPEND))
+		usb_enable_autosuspend(udev);
+
 	uvc_dbg(dev, PROBE, "UVC device initialized\n");
-	usb_enable_autosuspend(udev);
+
 	return 0;
 
 error:
@@ -3109,6 +3112,15 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= UVC_PC_PROTOCOL_15,
 	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_uvc11 },
+	/* Insta360 Link */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x2e1a,
+	  .idProduct		= 0x4c01,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_DISABLE_AUTOSUSPEND) },
 	/* Sonix Technology USB 2.0 Camera */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index dfd1ec2e992a29..e8deecce7cd9ad 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -78,6 +78,7 @@
 #define UVC_QUIRK_FORCE_BPP		0x00001000
 #define UVC_QUIRK_WAKE_AUTOSUSPEND	0x00002000
 #define UVC_QUIRK_NO_RESET_RESUME	0x00004000
+#define UVC_QUIRK_DISABLE_AUTOSUSPEND	0x00008000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001
-- 
2.53.0

