Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243295;
	b=k5FTFj5rLIf25zC1K/1ThDvd5CjsdaIiNqnnDFZagDZ/PKdAOqBKp8w+hY8COUwmvZVo
	 TO3dmB6JdpN2/t+qzRstVhbig+zkDDiNrrbPPn5zEb6eEfvqyPOsbOStWtAIaye6xuGSp
	 RCW2dgmvdj1lq3q/NDeo2n0neizI87HzW8lcjPFW/Gx6vSnelCIPDG+q0fMNGvtJkQLsk
	 E4RIhl8+HcpodAvV/ucfxauN0VakfzrOpNQLttwJdbWpwDDBIKFKvKQfUTdoBTjhTEumX
	 b5IgPFFZpFtHEQ9JlRY8CnigkxIazCe2Qs356cbY7DBbdyRCUFGuIsm8XZQD6abGa4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U9eKSeOiPBkIzHaDOmcQY71cDVtvEiro7/nFYhBiBF4=;
	b=xSxfyyWm/tlyWvV/psP39anNYpfaIv4vxzvBd4O2ONt7K90mmovgJO9Ycf+2ROZ8f0eA
	 kZGmCYc9DsUWKOp/QyfVq0+nH2/lOouKCGFbaBxen381rMgV9dw0d3ptpuZp6VpRS/4Pb
	 hksthycvpvD54mXLwkFd27a8IICCXaiXCDsTngvvswNvjLVflkMGVKaS8lR8mrByESfrn
	 CT5vHx0jm+jLC7iuxhbnEozs7OfP0oCFvkJBs7CM8m6RDu01HRZOrM+iP8ZCHA+Nd+Gcf
	 fMQn7Geo/o0yzsH8VCgY6n22yF3r1rOri9meAY5IAImpCcPDeUl2ZIGcME4wqV9tZHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=c0mc7Cco;
	arc=none smtp.remote-ip=209.85.167.43
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31D060A5BD5
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 16:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B31D060A5BD5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=c0mc7Cco
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5c08539c827so753740e87.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 08:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794243293; x=1794848093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U9eKSeOiPBkIzHaDOmcQY71cDVtvEiro7/nFYhBiBF4=;
        b=c0mc7Cco36rwoOHAAaMa+4GXaKbcjajz5kTMAV6LdDL1zYsi2+9w6hr67t8ez8EHDp
         XDopT8434ZTVRSJ0JTO9M/PO32n84PNlfqp93jf0i20xTuoPCtkPBLEPQ5L6bywNaxgV
         Ga1vLB+AOJZscwS+tqBh2s+VevxwIf9wADiaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243293; x=1794848093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U9eKSeOiPBkIzHaDOmcQY71cDVtvEiro7/nFYhBiBF4=;
        b=FCtdVFLJvTO2TvxcbJeMNnhnItSByNBS1P6gvR2ES5oRQ4hHtRJbfuQz2cXzis1Q0i
         NAYy1nzOhvZFWuqAg/5C8TnpyMYz/LMA3jymE2r0jayRKOf09eTgywpCzV0bDp2BUL5D
         lTNEFVdSIBkAyi1jaAVo0cdVL1/g38703T21LcB/XP/D+aTM8lU3v/Oev3BloLNmZirM
         gjs32Uq+ALbmLengFBALB+loMgFF2KDtCDO23b8WbV51TkfY+YYZGS28kUPo9EYy8D8h
         0BmZ1lazfqJrMMRzTEMLy/xKVrYKyFTIBqN9cIic5sGSfHYodaqE9tIqGRXtZJ3DMoAD
         YJCA==
X-Gm-Message-State: APuU4Z8XDfgd5a7Ui0yFHqWRp79CviPfJfUQeHYdgUsSOHRYsiKlVYXd
	fB16c3n4vaoTat4UAgwR4gs6sG/hIhjT56tNeOcNcWVYqD9gWWO2O0rXmStu9yXfbEUd078rWdK
	XmmYO6H9C
X-Gm-Gg: AYBFou3Sr8OCfp84qVrkMAcH+DhNa2rMdMQGFTrHP3dlrN+Mzzc2z3fGwie+Bn75ziz
	ByfKjYAtE03Bc+8666YOy1CT8HBWH3msWRC6wLr45Ml0y6Uv8jp0wrFEGlVn/pXghb6+y6OWqt9
	xRiejpjaJuvRr2bP1F9G5zZA+BJfSVsgGW3iVkGDUsCYpk3FkVtqx7pnWrtJzd6eW/nZJ8pFFtv
	uVL21H3lT7dVWy+LKVd//QB+d04Cavcpd6F5Q9sx4sFP0bo6zVRFLSEHgPkZnjSu7s+q1c5UTuo
	4oNW8AbGHnjdRczuKtgYp/z8dYQWB0vtMmbip9pQOk8LHkKPfW2rPPxAOWhabUTVCUOCzgPyrzs
	WAE7HSfgiNI3AnkSVhXQ8HoVDem1ZnHEEXxPFlIJlVY3OJL9gBn8lrDjxG2icKAzctXqAY/UEbK
	+A9wMwxndcmtY4HebQGEiZPPq82hZY3lyFfSUz+O4F9HSYXrU21TEKw3k5O6RiFUGx24y5KSULI
	MeK426qTZuooxrGkk0zPPKWIT77rfFTXVjhfYva+tIQqBswm+IZpukSnfjSeSdtXxmwnd2lfpgC
	LC4dFICKCds8as2hGzlZwW+TRjen1H5QZtk6Xz8vUruA9wYgd/eGNOpvL9o+bDTx/5i+l7aN3Gy
	eQS++vz/OOjRWZ+4=
X-Received: by 2002:a05:6512:1104:b0:5bf:f40e:b54 with SMTP id 2adb3069b0e04-5c14ef92b87mr1343053e87.56.1794243292844;
        Mon, 09 Nov 2026 08:54:52 -0800 (PST)
Received: from ribalda.c.googlers.com.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c14b810328sm968842e87.48.2026.11.09.08.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:54:52 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 5.15.y 1/3] media: uvcvideo: Disable autosuspend for Insta360 Link
Date: Mon,  9 Nov 2026 16:54:45 +0000
Message-ID: <20261109165447.1179922-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261107060123-failed-5.15-65444446f0c5@kernel.org>
References: <20261107060123-failed-5.15-65444446f0c5@kernel.org>
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
index 1cd68501fdc5..f35c8d0ae0da 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2562,8 +2562,11 @@ static int uvc_probe(struct usb_interface *intf,
 		goto error;
 	}
 
+	if (!(dev->quirks & UVC_QUIRK_DISABLE_AUTOSUSPEND))
+		usb_enable_autosuspend(udev);
+
 	uvc_dbg(dev, PROBE, "UVC device initialized\n");
-	usb_enable_autosuspend(udev);
+
 	return 0;
 
 error:
@@ -3257,6 +3260,15 @@ static const struct usb_device_id uvc_ids[] = {
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

