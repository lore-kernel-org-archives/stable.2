Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EAE30C174
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728504; cv=none; b=idjQoq8FDnPKlbA92uxlYE9cv5qv82EInmUIDxSUM3hcAgetdUEz41abB5Q7RYIMHUpnhepc3z6yoPt+r1IXBucC+YtFO/lS8+URqzvsSWgXNO7epP0LTuvJCrL4bOhCxH6jciwyxCOhk2rYzRFRArZxIphbjlR0mP9BsYfZy1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728504; c=relaxed/simple;
	bh=3fWMVZQErX6oEmHDJAyyEnViviiLLSR5ao6XLWoCPNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEpfi+cW5baYbMUiwwSJerM7GSooDHLtAeIlBGsNxBAVVf3mqH2iQ/BD5QvJjgatB3428nGUH3QkFt4isKqjmJHnYHyBYn4n/Sxc4R4LUiBm8bzYdLRXIS64XNeUed6jlJtwH314HXXtqJX6TCWABZI+Y03gQY8KVeFJ+BOtZeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StsoczgJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StsoczgJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9661F00A3A;
	Wed, 22 Jul 2026 13:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784728501;
	bh=1ZWPceBptCndSN8EOkY0uWB2EriXg0Uw4UePpLhWJtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=StsoczgJwwNGsqx2D1nZ7TGvbxWvYg4CVhm7a8hjPQKv6nGPZZIFs/vLjjFn3R//8
	 rBfSVcD82fxZshAcQtCkRRShWHQrhDKElcm1OByxF0HJNQcRLDB6olXPVaN7wmJbNU
	 vKtApwHUqVPBmEkDCVG7jDyGSbGuia+GWe1d8WBMSBIODVt46w92WbTU+IKW2fBlEN
	 9ao6eSpl2auvCvQhVfmds9pEb21VEi+Gi0sa68NYP5FcqEhyJspXXM4XZ3yGblcIw+
	 ruFu0iLcQpqWTHCJrtVmGdUewr7+SKCnLcS4PTy2bm7M6W2SxNS+0U0pT5BIf7QWl5
	 kVSroOfxRj3Wg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Devinder Khroad <dkhroad@logitech.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/7] media: uvcvideo: Add quirk for Logitech Rally Bar
Date: Wed, 22 Jul 2026 09:54:53 -0400
Message-ID: <20260722135457.1366301-3-sashal@kernel.org>
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
index c93a292e041975..8605c3e298cb2a 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
+#include <linux/usb/quirks.h>
 #include <linux/videodev2.h>
 #include <linux/vmalloc.h>
 #include <linux/wait.h>
@@ -2296,6 +2297,9 @@ static int uvc_probe(struct usb_interface *intf,
 		goto error;
 	}
 
+	if (dev->quirks & UVC_QUIRK_NO_RESET_RESUME)
+		udev->quirks &= ~USB_QUIRK_RESET_RESUME;
+
 	uvc_dbg(dev, PROBE, "UVC device initialized\n");
 	usb_enable_autosuspend(udev);
 	return 0;
@@ -2640,6 +2644,33 @@ static const struct usb_device_id uvc_ids[] = {
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
index 9eb749961bbd65..dfd1ec2e992a29 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -77,6 +77,7 @@
 #define UVC_QUIRK_FORCE_Y8		0x00000800
 #define UVC_QUIRK_FORCE_BPP		0x00001000
 #define UVC_QUIRK_WAKE_AUTOSUSPEND	0x00002000
+#define UVC_QUIRK_NO_RESET_RESUME	0x00004000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001
-- 
2.53.0

