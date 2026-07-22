Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0529D349CC1
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728502; cv=none; b=TcRbDvPnfiRHO5by7kPOT9gu4xUj2jiwzKu38fLoJYpWrhstmuzkEgevt1CydOajV04719BzyG2NK/PXmQc1mXbEtwNd/RFcXFUruuLESwEKG/hiFQzMlihxZ4gbCrRdVc+ZLoJLXyGwLmeFfaPP81yOrOnCNhvRWUnum+mmUqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728502; c=relaxed/simple;
	bh=JQnABrOmiwwf/NyYIbOIm0UG/WHFqOU31qzYFD312E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQlZQeYfXV4/OTfvrJJ53OgaXAoMuaBBrDsnLJ5o1kyEBwOaQB2/j1B+aMV1zw/f/89lIGrmrRJjEJjVprXIHoPvlinLQyYVwHxFuWaVkzmw2zp3Tgp6I4XO+E2OM/+fKq7/IVJNEHZI6Jt0JPU3npuPA8CP3RcIYsEjyy6YasI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNrPyQPh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNrPyQPh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A381F00A3D;
	Wed, 22 Jul 2026 13:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784728500;
	bh=80jTLMU0jM56RORCwpdZJ2Y80XDULROLx+kkdcR/+78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SNrPyQPhOw2UsWFTEVKVbSqJzzNuCMi/NP/KAjbZ6wamQTLpayTJTgC+FI+lEHxD/
	 6UCeim5LbSOZtGT4wf8NVk0pt1ictHOgPPusjeKCDady1rLbfXdLTLIcRRIOm2r5RR
	 u94zF40anc3nSROvIxwvInLMOpVslLYbl/erevJV5wB3C5QB762b29biuIQq3UYFqA
	 fHwC9YEl2DwdeGFdAz4gQ1oKRxpv2Bm1zhtFrLWH8R1Dt3XAvqDSjLgzNcvC2KAdyL
	 sehObVgMlkJY+S4ANW3ruKmjrTkpzAQ9lAzwmW2OQymZT+D8WnYN6jhkoJyt9uMp8E
	 mptVTIgIatypw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Yunke Cao <yunkec@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/7] media: uvcvideo: Fix power line control for SunplusIT camera
Date: Wed, 22 Jul 2026 09:54:52 -0400
Message-ID: <20260722135457.1366301-2-sashal@kernel.org>
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

[ Upstream commit 6180056b0e0c097dad5d1569dcd661eaf509ea43 ]

The device does not implement the power line frequency control
correctly. It is a UVC 1.5 device, but implements the control as a UVC
1.1 device.

Add the corresponding control mapping override.

Bus 003 Device 002: ID 2b7e:b752 SunplusIT Inc HD Camera
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.01
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x2b7e
  idProduct          0xb752
  bcdDevice            0.04
  iManufacturer           1 SunplusIT Inc
  iProduct                2 HD Camera
  iSerial                 3 01.00.00
  bNumConfigurations      1

Cc: Yunke Cao <yunkec@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Stable-dep-of: f078966ca1fb ("media: uvcvideo: Fix sequence number when no EOF")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c   |  2 +-
 drivers/media/usb/uvc/uvc_driver.c | 16 ++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 466f947ef440d8..fa1f8303fa3d98 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -737,7 +737,7 @@ const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
 				  V4L2_CID_POWER_LINE_FREQUENCY_50HZ),
 };
 
-static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
+const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
 	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
 	.entity		= UVC_GUID_UVC_PROCESSING,
 	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index a1c6ae97a2b930..c93a292e041975 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2454,6 +2454,13 @@ static const struct uvc_device_info uvc_ctrl_power_line_limited = {
 	},
 };
 
+static const struct uvc_device_info uvc_ctrl_power_line_uvc11 = {
+	.mappings = (const struct uvc_control_mapping *[]) {
+		&uvc_ctrl_power_line_mapping_uvc11,
+		NULL, /* Sentinel */
+	},
+};
+
 static const struct uvc_device_info uvc_quirk_probe_minmax = {
 	.quirks = UVC_QUIRK_PROBE_MINMAX,
 };
@@ -3062,6 +3069,15 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_FORCE_BPP) },
+	/* SunplusIT Inc HD Camera */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x2b7e,
+	  .idProduct		= 0xb752,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= UVC_PC_PROTOCOL_15,
+	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_uvc11 },
 	/* Sonix Technology USB 2.0 Camera */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index a7182305390b44..9eb749961bbd65 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -737,6 +737,7 @@ void uvc_status_stop(struct uvc_device *dev);
 
 /* Controls */
 extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited;
+extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11;
 extern const struct v4l2_subscribed_event_ops uvc_ctrl_sub_ev_ops;
 
 int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
-- 
2.53.0

