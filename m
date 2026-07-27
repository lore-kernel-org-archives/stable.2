Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89833D8123
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182133; cv=none; b=mCgDYMurK0U4vc53xkQ5YcEgF34cp+F6OPRScLHTaieiy47IYOq6PCCGuVld+vH/7OoEGwlS2zQ4XoL0r9YRTndYM//eF8vyyp8jwaP/R4NBisDCvaUMr7K0mqJ/XjNdoapzOnQ1izjE2p2CaUCjg0EgtTR5VZDh4RdAe5Sq5cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182133; c=relaxed/simple;
	bh=AfVtfPVQw7E6qtXV1Ata9mBOVITuY92MDLgL+hWYNZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbOrJBCcGTJke60cP9e8Rwwse/PAqGdzuDHIW8prrZ74GV2HZ8cqCHxe/qoo41En018ujhlpbMQn1n0NOq+n35GaYDhx/CFB3B3Figy9MV/kQ0fRooiEHy8NGo3AEflWgiQUMnI8/i4e3N3LOxrKOyibUca515KZa31+PzX+ShQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pKNbcBJz; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKNbcBJz"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-848643382fcso3089190b3a.1
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 12:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785182127; x=1785786927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tFl/DVQhUlBRx9yESRcf7Z0LveRZ9ahPl9d1n+zCKZ8=;
        b=pKNbcBJzKZj20Yz2fbOoSB9neQpJiJaQpVc/kxA5R/nQeoHD8hlhxsQSwQC9u3QwXX
         UXp+aMDhQFY9C2J56uegR0+a67gvyy7Xq1Nj/8QsQOwRr9BSnXGN9X8mcWklkpa4Cxmh
         RPxawkJld9OrMmkOCnWxBuaM/RJMf9b9fHvud6+jdDVEB0jiL4Wq51nF7J51/bBb0H+z
         jtmiVD4Qc9N5gdKwkzr5Qg+xUWVQXK5xZWpDLPF49DJjP2BJRlBZK8c3kCldOB98YhFE
         oAuPfdxSz4K//7U+JWXvnFVOIU2Pj6xekeIT9wH/An88UO2oK7d7sJx5ZtBJjc4LzSs0
         Hubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785182127; x=1785786927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tFl/DVQhUlBRx9yESRcf7Z0LveRZ9ahPl9d1n+zCKZ8=;
        b=MzazVj+zLOEtpG8a5zkIVvyiKGsAzf+OaDTe1nV/M1ANedJDJIyiNe7zSfDID9w4S2
         WKkHXNAHRjlmEA+JNLGLk/R1ogRdtZzsEjqCl5Bz2nSIMa6F/cfKIeWHvM9kqUir+y37
         yYDY6UY2Y5tqc5uN+iXnN4e0cLbZA+wSXEfskbM1UCcvNCOMqORioTrFMzlIotLTcfyY
         qq3zTzHPlQDMqEMv5TLRaKvgi0sE39BAnL70KO7igQpSAsuSUftKXPB05XgnfdAHKPoG
         Ui2opjOjvdBVyZ5q9pJRR2T7GHwyVPh9LJ8pR4QaFAc6NcKBTbiLBlSD757q2+kv1HNy
         2LYQ==
X-Forwarded-Encrypted: i=1; AHgh+RpGlGLHplNlqEJf88t2Pn6ww/XzrFCO6XVPugwuBiVMSxSTHWEjcyfUjiRJUnQUWMi9sRs3fEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoxMXvxL802zFurhDqrOIzKYacSluH/pmyzJJ2pGp+jlM3xA0O
	QFfeRMGBg2zCQiAe6xpFTcH00siT9hihbECZzEHY8XWZr1+0LHS+XJ/L
X-Gm-Gg: AR+sD12FqhznOirIG59mE5rcOvD+UzLsM/EVzY34IMSJTlmitJrNqrh8uFo86P3JqsZ
	MtJ05Rv/SnVBtvpMgLt0n7cpPk+pXq799niZcxNzoqjVX1l24ymMjeSYKBliJgb4rnI2SHEZr4M
	PnuRGBWwQm4W8iudAxUzppXtNltZAySq7lmLucReizrOqSuTqu9EFJBnXH/plGs9eM11+l/MaSk
	pz2Y5fVYZqMV3eODSSVSWus5k2rkptXlkdRmbfCTzU5OEeTBVN5MygxH39+8/7ebEYAwdSQK7Pu
	hcCBC8H8NuCFqPqQT8wlYXVlZjNR53eMhYi2CrGZmIo0xqppUwPPfCEn7OIPtcJ2aokjdUh3/JT
	TTPYddFTqc9c+5xUdnrtYIaow99k04tpF3XkPvYGzn7nHdn+OpF+3+asCuoZLhPgxpk1ZIeo8QV
	vzYj8GeMp91AJ0leeJpGxMC4sNfHtvJekMUuRG9+enlzLfguU0wFfRH+7+V5chJFXwmw==
X-Received: by 2002:a05:6a20:1590:b0:3bf:96c6:78a9 with SMTP id adf61e73a8af0-3c6c7b71895mr1111190637.2.1785182127125;
        Mon, 27 Jul 2026 12:55:27 -0700 (PDT)
Received: from localhost ([103.170.252.6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e6461ef84sm18743257c88.14.2026.07.27.12.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 12:55:26 -0700 (PDT)
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
	Nikhil Solanke <nikhilsolanke5@gmail.com>
Subject: [PATCH v4 2/2] usb: hub: Split announce_device() to log device identity before enumeration
Date: Tue, 28 Jul 2026 01:24:34 +0530
Message-ID: <20260727195434.14626-3-nikhilsolanke5@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727195434.14626-1-nikhilsolanke5@gmail.com>
References: <20260727195434.14626-1-nikhilsolanke5@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

announce_device() currently logs the device VID:PID and string
descriptors only after successful enumeration. This means that if
enumeration fails, no identifying information about the device appears
in the kernel log, making it difficult to diagnose failures.

Split announce_device() into announce_device_ids(), which logs the
VID:PID and bcdDevice immediately after the device descriptor is read,
and announce_device_strings(), which logs the product, manufacturer,
and serial number strings after successful enumeration. This ensures
that a device's identity is always visible in the log regardless of
whether enumeration succeeds or fails.

Suggested-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Nikhil Solanke <nikhilsolanke5@gmail.com>
---
 drivers/usb/core/hub.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 5262e11c12cd..d92bf887739d 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2401,7 +2401,7 @@ static void show_string(struct usb_device *udev, char *id, char *string)
 	dev_info(&udev->dev, "%s: %s\n", id, string);
 }
 
-static void announce_device(struct usb_device *udev)
+static void announce_device_ids(struct usb_device *udev)
 {
 	u16 bcdDevice = le16_to_cpu(udev->descriptor.bcdDevice);
 
@@ -2410,6 +2410,10 @@ static void announce_device(struct usb_device *udev)
 		le16_to_cpu(udev->descriptor.idVendor),
 		le16_to_cpu(udev->descriptor.idProduct),
 		bcdDevice >> 8, bcdDevice & 0xff);
+}
+
+static void announce_device_strings(struct usb_device *udev)
+{
 	dev_info(&udev->dev,
 		"New USB device strings: Mfr=%d, Product=%d, SerialNumber=%d\n",
 		udev->descriptor.iManufacturer,
@@ -2420,7 +2424,8 @@ static void announce_device(struct usb_device *udev)
 	show_string(udev, "SerialNumber", udev->serial);
 }
 #else
-static inline void announce_device(struct usb_device *udev) { }
+static inline void announce_device_ids(struct usb_device *udev) { }
+static inline void announce_device_strings(struct usb_device *udev) { }
 #endif
 
 
@@ -2651,6 +2656,9 @@ int usb_new_device(struct usb_device *udev)
 		device_init_wakeup(&udev->dev, 0);
 	}
 
+	/* Announce the device identity */
+	announce_device_ids(udev);
+
 	/* Tell the runtime-PM framework the device is active */
 	pm_runtime_set_active(&udev->dev);
 	pm_runtime_get_noresume(&udev->dev);
@@ -2672,8 +2680,8 @@ int usb_new_device(struct usb_device *udev)
 	udev->dev.devt = MKDEV(USB_DEVICE_MAJOR,
 			(((udev->bus->busnum-1) * 128) + (udev->devnum-1)));
 
-	/* Tell the world! */
-	announce_device(udev);
+	/* Announce the device's product, manufacturer and serial number */
+	announce_device_strings(udev);
 
 	if (udev->serial)
 		add_device_randomness(udev->serial, strlen(udev->serial));
-- 
2.54.0

