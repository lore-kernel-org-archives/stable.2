Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242396;
	b=GFJLM2V7uTHc0aEFld4qiTmeH0MGzLgLZeAaFUmYbRXvVMUFynWGzQrS0eQp/TO2MJvx
	 Zbvqnmgqj8x+Pz/gtov+E3F8o5CiqRriNOY2famqdkcPktWsg4MWpEHR1xRHaOArKYg8d
	 1/B9+36pYKQT/emukctV0HnfCZ2oKizApdCmMFTgVmoMMvOYjFP7CUtJnhtoqq7/snyWV
	 zvFSMtGoD2ziMaiGKH1SXRgjuHcOeBnjUJc6lhVOvUvJgTLHHlGc7Obybz20vIamaE0EZ
	 gXlKrEmExWDsBO2NNt39qcDrZ3Qwx8/K+XD4cGDLseph8wbdWKDb9U8agcITCP+2enQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gGJn4iaZ0WBQe4YHT990NnI4RNi/+gemxBi05zl2a+4=;
	b=KQ3FySCHbEf2/dbd5c6NWrRpZjCObPD0EWZaU68mIFQAouTXrndSUJ3Kh9lPiTvbABK5
	 Md7Cy/Vy9efzcvaLFMHAN3enPXZQAGPg9a9sF+8qcuf2Dlrwd/Ul+zShl4fH51IDAEGyK
	 A/55fTBjOz5JD5d/rS/z0LiDkJX3iKWsosGQNDBwwZHV+Gh9A0aYUZXqyx9blwvborKig
	 KXWRN9Dvk02gJLHf8ilgfg2In03XWezyqRu/542Yfsi8p4D/J8OkByvC/a3kryl9+XDTG
	 0h4pz4CfifnUmwgJaBO2rd9Z6RiAmePJtvOgqnDLdvzz9bsXwMFRQNOcFP7APEliLOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=EIgFDQyz;
	arc=none smtp.remote-ip=209.85.208.175
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7223D606AAD6
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 16:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7223D606AAD6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=EIgFDQyz
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3aced9804e8so9191631fa.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 08:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794242395; x=1794847195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gGJn4iaZ0WBQe4YHT990NnI4RNi/+gemxBi05zl2a+4=;
        b=EIgFDQyzYqGjSvMykeQuQ8qM1Osaay4VwKv168kE93YzNVi11GAKroBt3wPQTwXPHJ
         QCapCqfG0nbDFFljmsjlUCL+TBlr75f2DduT8Jel3iHV6emNzj/aGOSAYsX9chlTEvQL
         8SbLRVNOOt8NVIT0wJZkID1rxnZlnWbJEHE68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794242395; x=1794847195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gGJn4iaZ0WBQe4YHT990NnI4RNi/+gemxBi05zl2a+4=;
        b=UxtwG7sTclz2rUtXeo8ENpLOxJ+8XSfz8SA8qr61tnokXnbbKWD0V0eFYcC0b05iyQ
         pn3LzYGVz8CShlnR/uPeSpkNdyOTQ2CzJrw27KzM6g4v/PU8xhc2zPbof8g1lzs3JnyM
         1nJNiWtR9Qd61a2tXxAlxMcwVuaFshF9y81bES6Tyd2fpGmhqV5Rdy601q5MTtqzVj5g
         07ryLtS/Q9nGEZMdv6j5FcJ+Aolfn/5b9lVg0spb4XSq5x9cO4wKp/pL6ZGKoyYY4Nx/
         qMy6E36ClZOMEvenT+bhJrGn1kJbRrUpptGo/Yzx/qjGE5CLT0ctYNCAZoVMJ37AeHty
         UBrw==
X-Gm-Message-State: APuU4Z++cADcfsF3CPrWeSi52P8CdPaFNUay6vQR7OGIrAvyUys/B9+v
	hkAgUeheZYR0oDJkI6kGfH5ssp+onVGq/chLPeANtYsdZt22ifU1wN6W/hD2rEey/5vNjgQqYYe
	eBHu9ZUhw
X-Gm-Gg: AYBFou1+uamm9ddERMYmoa7cCc8Xkza6IF2B7G+YjdNpFVaWHLgwQYzv2ypOX4lC2w3
	yp+ul/Yk8fjFIU8XVxpx44ZKAVPQcYzOkWzXr1GPuDdMAknmg1DS40bN0duRNPng/i3C9Ytufgk
	5oAdzk7zwUylyRVDM4s2j45dpDYkx12mVs+Qq33CrN9BBMyxfopc14JjAgATh6sWdUaKOlKcC7B
	Fe22pbPfhCMHTunSrDcWvb2vib3obP/NPizyynXUQMk8OKt/KecyXHawsVMVyJnLZr1bP36XwuO
	pYKO05KhgZ1OSQ4WpSMmsDc0TEnNLBPoq0cfr6Ih8j+tr94k+BqxCKA+JMikNlx1YuD2r9KxoN3
	Fehyb5S2wZ/h4NpGJTocBEFX4QYOGZvH90olfMLEpE3IujxawLELlmYjzcPFEMvrdDH2gfdhBv6
	/DgbYZVuQcMhkBcZR+pb2eoYJiLE/0LB2qYz6zlDt3DY6jJMwYBWj/S4MhW8SSUmEUV4TpLlqfl
	X1+K/6ciV4ojODObAHPFFQV0/4W8rBbv74SYUypPHZ389ncZnbjRdgTELX7/2XPbtPPrBec/beB
	pK1o4xNzW1OATl9EqRPRQefwG6WpAdGY4vGSpbw84oAikLqbHMy/i5gDj9C0lKmDOzxZrRzih8T
	U0Lwq/5dbhmxMCEs=
X-Received: by 2002:a05:6512:3407:b0:5bf:dc47:e4c5 with SMTP id 2adb3069b0e04-5c14c015696mr1604828e87.28.1794242394720;
        Mon, 09 Nov 2026 08:39:54 -0800 (PST)
Received: from ribalda.c.googlers.com.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c14b82384fsm980162e87.72.2026.11.09.08.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:39:54 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Doncho Minkov <donchominkov@gmail.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v2 5.10.y 3/4] media: uvcvideo: Force UVC version to 1.0a for 1bcf:0b40
Date: Mon,  9 Nov 2026 16:39:40 +0000
Message-ID: <20261109163941.1114322-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109163941.1114322-1-ribalda@chromium.org>
References: <20261107061805-failed-5.10-65444446f0c5@kernel.org>
 <20261109163941.1114322-1-ribalda@chromium.org>
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

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The Shenzhen Aoni Electronic Co.,Ltd 2K FHD camera reports a UVC 1.10
version, but implements UVC 1.0a as shown by the UVC probe control being
26 bytes long. Force the UVC version for that device.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reported-by: Doncho Minkov <donchominkov@gmail.com>
Tested-by: Doncho Minkov <donchominkov@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
(cherry picked from commit b400b6f28af040d55b4eb397ea7b8ece368c6b12)
---
 drivers/media/usb/uvc/uvc_driver.c | 17 +++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 663f07f9ca01..d070711b4f2d 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2342,6 +2342,12 @@ static int uvc_probe(struct usb_interface *intf,
 			"linux-uvc-devel mailing list.\n");
 	}
 
+	if (dev->info->uvc_version) {
+		dev->uvc_version = dev->info->uvc_version;
+		uvc_printk(KERN_INFO, "Forcing UVC version to %u.%02x\n",
+			   dev->uvc_version >> 8, dev->uvc_version & 0xff);
+	}
+
 	/* Register the V4L2 device. */
 	if (v4l2_device_register(&intf->dev, &dev->vdev) < 0)
 		goto error;
@@ -3023,6 +3029,17 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= (kernel_ulong_t)&uvc_quirk_probe_minmax },
+	/* Shenzhen Aoni Electronic Co.,Ltd 2K FHD camera */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x1bcf,
+	  .idProduct		= 0x0b40,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= (kernel_ulong_t)&(const struct uvc_device_info){
+		.uvc_version = 0x010a,
+	  } },
 	/* SiGma Micro USB Web Camera */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 4a1ff08453d7..184ff2c10560 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -654,6 +654,7 @@ static inline u32 uvc_urb_index(const struct uvc_urb *uvc_urb)
 struct uvc_device_info {
 	u32	quirks;
 	u32	meta_format;
+	u16	uvc_version;
 };
 
 struct uvc_device {
-- 
2.56.0.506.g506a7eabc5-goog

