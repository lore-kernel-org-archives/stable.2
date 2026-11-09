Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242392;
	b=e0Q+YtvPN2jkJp/ppZLJIWmDW65NCbhmQKpjV3c09KykMGegpmmBTzz1HGMjmCUCeA37
	 Bs4lrbudMXvfvZtfoeBpR+d2aJ60OCWGYm/Lbp8di9L5eUEeYWVzLy74CLwXg4r2pkFnq
	 eBp6tZl4ERh0JrPwel/+nEvSUzuEWi9X5t+4qgBxZ8mVVu+7cOqZR+WOy472C6cNifEKV
	 fT6vHyhstjYVa4+Ml17uzd0ZcRB+qt3zruLrI+HMyPIzdPufLMKShrLVr87/KX/Cf0ME6
	 JGKDb2it125brwFT2imyi8eCrBqXO7WHTOadGCBCbERTae7dtr1NHMx5pfF9WxIDVCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yAO8N9J4vVCckqsGvnlVoiPdrwD7wTjjRfJkKfj0bng=;
	b=nyKKK7pdsM6VmydA8aPDvnVCyIefcMK/EHt1qPQrpljKcemiiAll3AKKz80eHj93vzcf
	 Vdf4fw71/uwn/1dQVD9GsdV9/ut++lPwhBzrbjWGqqYZh3fJ1Wnm7eBAYIRxXjMgFK6Az
	 1YXjVJqz6EG6/G94bT/FcCBWQ536ytuGAX91DpvnoZsjwaqDg3Ont6XaQcUO8LeIlVgjC
	 5L6gDnSVhUwvToWYZGwaAtOF6AE5fodlgebENh+sBowy2qLIoro2fFqMlB2Y4AFJX/t8U
	 Tc/H4BPzdREhE8juzqdekbQKu5tByzZ2EtiZnnbawL+3BpCtgTXf7z1yLEia1o6mloQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=CbkcUZeI;
	arc=none smtp.remote-ip=209.85.167.46
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AD0606AAC1
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 16:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58AD0606AAC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=CbkcUZeI
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so1068525e87.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 08:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794242390; x=1794847190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yAO8N9J4vVCckqsGvnlVoiPdrwD7wTjjRfJkKfj0bng=;
        b=CbkcUZeIe7dK0OB1NiS4A8Xl2K3348rSKckPiRQY4+86nixYqlft/D+4VZ/t0h2tzQ
         +CvBDzzijn8yzkXOMckXHBRCSTf/N1PKcuYpRIWQSl2Z/ETOen74aeThQITLZy6B8qNR
         JnWF5dO54FUB/DBIhGUkAZi6GrIWflTwhV7Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794242390; x=1794847190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yAO8N9J4vVCckqsGvnlVoiPdrwD7wTjjRfJkKfj0bng=;
        b=C0Xw38ZqVzNY76EAuEYdznIvGQjdRyWWF04P3pgVhEcmGlyBpR5JUznNZxtQ7iiD31
         asrPICnZAZ2gA+goi6FM71YN4HoblXdCmjly7mtJgAUW6xqfKAUz8BTmINPyPWyQXHSw
         fY6vENKj+aGSikI/IwjVNOvD0a3aSzd6erjhMl+T1nn8ij//z5XQiwCU7QhZZxW92ufd
         dpL/cSoOi4jrpQDQkkDX6h1poJEmBeCmlijLP2TKQavM5qXnYeAKwIbQOxPGULUAS6Yn
         MHksFjweU9GJoNpkP5SEeagvXfQIUwQ0g8SPhvNxpFALZN3Zu8/QQTMs+JfmQD5V7VPd
         0itg==
X-Gm-Message-State: APuU4Z9W6sP2YeWAcu2V48xIx53hYiNQdLe1qyYx+BQBdGBA7mTO+o5R
	t/6YLw3zusXy6cOwKnDBY9AcsPGK9n/O9qUk7XTV86zFn0tzAO1+2KlQCP+dciR44B677tS9O7Z
	YoaZ2wiL0
X-Gm-Gg: AYBFou3VgKtZzYK1MgpumuKD55HPOZOhZ/5/WSCgXDP+gxkM+2n6PueLvMNjY1xPhfH
	emBj7pWmHQwSt5taTbI2eiEjeguji8ktHjp59UiA/uJ0Mweu3jGXBLrhTqZ1csdJkamapNUQg5g
	oKtyyf4uQrNklb9eaowjZz20+ZQUcbIqfr9jcreS+4Q/pUDIctPMMmUBrU8OewmhQgDJas2UuR+
	p2uoDC7ErX97rrD3Sl63EYlot8CJzuc3WgWEfl+p6LGuUBfWSeoo5xQLYf1bolCMaFnDc2HFOlZ
	+bYjJ/CPoSLmTOwvgxIH9hh/x2dGqAVtod6Q42BTV81whymHTVngE5gPBVARFWmVfzeWbphHXdO
	NBxOYw49C+a7ykYogQ5nfjZF5RJQ536/KeFl4j9HawrMNGWSYbdITq5hcQ0bwWINsEnwctUAiAb
	rBihcfiDlQgZTvaynU1amhHOJ/ivYgEivpnhG1ur541lJHpZlBFFC9V1Z1JY8qwvL2HUfXa+WrM
	8TSCQVc+7oA8qkXXYQbeyj3zQXpv/bXeP3OZFMNv7zPgPzXcRKtwkQgGEK0jHRBNrf5V0MraYhF
	KcdKec8wRC+/JjWvKuMAwzKS/Vv9SLuuIBIMjJIjbOa8fG9aJTZp8viLyPJQsbi8f6csPfZjYA1
	S9MwTFXnyus8yvClSXh/eNAVcl3kvyW9PjjRc
X-Received: by 2002:a05:6512:2301:b0:5bf:d353:27ee with SMTP id 2adb3069b0e04-5c14c040144mr1434380e87.59.1794242390462;
        Mon, 09 Nov 2026 08:39:50 -0800 (PST)
Received: from ribalda.c.googlers.com.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c14b82384fsm980162e87.72.2026.11.09.08.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:39:48 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 5.10.y 1/4] media: uvcvideo: Disable autosuspend for Insta360 Link
Date: Mon,  9 Nov 2026 16:39:38 +0000
Message-ID: <20261109163941.1114322-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261107061805-failed-5.10-65444446f0c5@kernel.org>
References: <20261107061805-failed-5.10-65444446f0c5@kernel.org>
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
(cherry picked from commit 3de6df64f92d8633eb51a5e957ffc43ebdb2156e)
---
 drivers/media/usb/uvc/uvc_driver.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index c2adc6854c54..e2dab556ec99 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2373,8 +2373,11 @@ static int uvc_probe(struct usb_interface *intf,
 			"supported.\n", ret);
 	}
 
+	if (!(dev->quirks & UVC_QUIRK_DISABLE_AUTOSUSPEND))
+		usb_enable_autosuspend(udev);
+
 	uvc_trace(UVC_TRACE_PROBE, "UVC device initialized.\n");
-	usb_enable_autosuspend(udev);
+
 	return 0;
 
 error:
@@ -3057,6 +3060,15 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_FORCE_BPP) },
+	/* Insta360 Link */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x2e1a,
+	  .idProduct		= 0x4c01,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_DISABLE_AUTOSUSPEND) },
 	/* Intel RealSense D4M */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
-- 
2.56.0.506.g506a7eabc5-goog

