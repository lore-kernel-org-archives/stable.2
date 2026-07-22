Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD61A411F94
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741393; cv=none; b=CudxgfBEA553blZUmZ0qgE/vyQ/zTcSsx3ng/jPHyBlA0TaXNfnpUcXiTZlYQe9RFpcvSZ1reW4e06QkCqUSGe307DL5KwuVLNkxnsoXMNSUSwlNFbgQeOOg4vO3+OYSHfkSWIcRfJW+qLlAs407Q/FXdE+VAedQsI9b6bUb4VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741393; c=relaxed/simple;
	bh=U5rX83jW11Io7p7bs+VUhshAPuAmQj9YIDHcJzfNdfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2BU0ClUSgUxxPxe4nuUeiQvoZCsa/PRkH/3Kflt3mogztmfyyGMjf72vpTJbnUUCZQOeo7wy2yi0EWMuVq/I5hKjIoWMOtyZ+w3q8H74uyjGqpK75XWTcHoK3gk3jf6o88pp8cBhiCeuYvpZ9TN8S3V3UuyROF4JMiZz/MxDp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoHnwZoK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoHnwZoK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CFE1F00A3D;
	Wed, 22 Jul 2026 17:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784741391;
	bh=8qWbfIWKlSwrsL52SvT/CXj5nA5pE5EdtcwW7tbcREM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SoHnwZoKfvqG1fRzDdekgTr9YTVWISm2dAWMfKKqUzh7wS72hSs8jUyec/ohYMe0v
	 FkwcrrIL3VJoaRDhKYvopolxyTUOPSINb2DZ1O/SrzsKVAC2L+mPJkfdFmChIaoqVe
	 Xatu69KBc2j31f3mSq/3Ih7JEkA5y1b9/DpygcvZavABa6KQoxTZ/6EZtb9UMOjzip
	 bYoonIHYF/Z0bH7grizer/xJ85c+0JWWUUCMUDUNa3PyzLS7hfQn8tqZEl7iU5B3yl
	 dhHmTwC+luH28cTSRjUHuBendyG/6ZwrkMtfz2LWljhBkHJR5fLmjjbu6IywJjhQwP
	 UgiDMcxZEB/zQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Devinder Khroad <dkhroad@logitech.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/6] media: uvcvideo: Add quirk for Logitech Rally Bar
Date: Wed, 22 Jul 2026 13:29:44 -0400
Message-ID: <20260722172948.2068213-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722172948.2068213-1-sashal@kernel.org>
References: <2026072042-handgun-nature-b630@gregkh>
 <20260722172948.2068213-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ricardo Ribalda <ribalda@chromium.org>

[ Upstream commit 07731053d11f7647d5d8bc23caac997a4d562dfe ]

Logitech Rally Bar devices, despite behaving as UVC cameras, have a
different power management system that the other cameras from Logitech.

USB_QUIRK_RESET_RESUME is applied to all the UVC cameras from Logitech
at the usb core. Unfortunately, USB_QUIRK_RESET_RESUME causes undesired
USB disconnects in the Rally Bar that make them completely unusable.

There is an open discussion about if we should fix this in the core or
add a quirk in the UVC driver. In order to enable this hardware, let's
land this patch first, and we can revert it later if there is a
different conclusion.

Fixes: e387ef5c47dd ("usb: Add USB_QUIRK_RESET_RESUME for all Logitech UVC webcams")
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Devinder Khroad <dkhroad@logitech.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Link: https://lore.kernel.org/r/20240404-rallybar-v6-1-6d67bb6b69af@chromium.org
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Stable-dep-of: f078966ca1fb ("media: uvcvideo: Fix sequence number when no EOF")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 31 ++++++++++++++++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 2 files changed, 32 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index c2adc6854c5400..95029372ca66e1 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
+#include <linux/usb/quirks.h>
 #include <linux/videodev2.h>
 #include <linux/vmalloc.h>
 #include <linux/wait.h>
@@ -2373,6 +2374,9 @@ static int uvc_probe(struct usb_interface *intf,
 			"supported.\n", ret);
 	}
 
+	if (dev->quirks & UVC_QUIRK_NO_RESET_RESUME)
+		udev->quirks &= ~USB_QUIRK_RESET_RESUME;
+
 	uvc_trace(UVC_TRACE_PROBE, "UVC device initialized.\n");
 	usb_enable_autosuspend(udev);
 	return 0;
@@ -2675,6 +2679,33 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_RESTORE_CTRLS_ON_INIT) },
+	/* Logitech Rally Bar Huddle */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x046d,
+	  .idProduct		= 0x087c,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_NO_RESET_RESUME) },
+	/* Logitech Rally Bar */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x046d,
+	  .idProduct		= 0x089b,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_NO_RESET_RESUME) },
+	/* Logitech Rally Bar Mini */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x046d,
+	  .idProduct		= 0x08d3,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_NO_RESET_RESUME) },
 	/* Chicony CNF7129 (Asus EEE 100HE) */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index a83995276170b0..8aa1c3a67f0f2e 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -204,6 +204,7 @@
 #define UVC_QUIRK_FORCE_Y8		0x00000800
 #define UVC_QUIRK_FORCE_BPP		0x00001000
 #define UVC_QUIRK_WAKE_AUTOSUSPEND	0x00002000
+#define UVC_QUIRK_NO_RESET_RESUME	0x00004000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001
-- 
2.53.0

