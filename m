Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64EE330B07
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 02:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785291505; cv=none; b=teesnH5bQIwffW77GvcJj7xBJeClGvFVnj+Vj7Hf9KHSm2eQ2RhSWpG5QUmFpj4Ec/l+e4HErZQHseYCcWGZV4qeela0bY+rvlOeorrKCaqttUdgLYYhnI7ZUCBoMjzazuimavRJyrOVbuug9iSwLoL9AMAwpsNomRVNYe4aPK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785291505; c=relaxed/simple;
	bh=6nkqDqAXcPS/8X6gEANTW4rGF9CCvG8ceg1mzWZa0xA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LNr2iH9OpybPWGmwKkJcpIvzwUxI6vgEWcjcBSFeHHYi31vJLWn0VYtsxdiK4CKZmE/W1gPD8eypMszauuVNImR+x6N1PRc4JQfPxvOEPqBSM04wWlqaeJoJP3sE+Yy8iSc9T0xeWfLRRY2+zpUyrkZS9/zwbQcFK5txCeIY/fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqkF2XJK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqkF2XJK"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ceae1ed204so6187595ad.0
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 19:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785291501; x=1785896301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vnsZtjbV5skVSpYiYGDzFiuCt8jnr0IDD5NnHQhZM2A=;
        b=cqkF2XJKZTEbPCOMeXEv9MCr+3xfltSkgrZU+zLzzzumZJ5Eei3SFQXGKOxR+DeTnG
         gmxoVDLfPqXxgyUb5+xfHqOpnWZoHEe8TL+YSb2smpqnBvhy/XH2vEL9x1pFISmh9MH3
         5s3rREz5nzHd1WOSHdajzLRKuISJC/ugzWJmGR/6iYD38ak9Z28ZTqigTy8GpLSnBusH
         rd8U2d1cDVtsGIJMSR9ItLfLc3cswW/tcbqWJw63c5oYoLf+mAtUC2188s49HkDfaY4S
         Qg+BXOKQqTECouYljLm8r/7Sj2M3wwcI2lsHM/2FKegfKxeMiUNH3gpwoN09dEaFnHOJ
         Pe/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785291501; x=1785896301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vnsZtjbV5skVSpYiYGDzFiuCt8jnr0IDD5NnHQhZM2A=;
        b=mhA4It5bjtEMK1mF1OzNd+ZdyfUhG6k6m5ZiFmXCCUT8lBv0BhEZEQdflSGdVN7wJm
         8CNlDlogZXSTdcHFEOSyNkKPfhcoAsqr1InZZlAG64Qz3s0mumvLInIrM11yxAdy3nEi
         F0B0KUI1gKB8VWMqzbmz8jlIuRiEustwaQcvj0STEJuiAzlYRAkuVtB4HuvgeDxFTh3b
         fSR3WW6gpMl9AlGKHqfA6Hb/8x6ZMHnT7ZzLFz7zmr/U822sa15v8jTn2MjjTdqLBmQr
         Uw3Zp86Bd8Q/XzADuLLWT+rV+2SM3P+WJ6Hdaw/YDcKiSZ+x7gjjuWCMX3wf6oXsgVTK
         48qQ==
X-Forwarded-Encrypted: i=1; AHgh+RoTLkdpb7i9crka7kbCmRw+/nuUb1fbXT49viVnK8kAj8Omb1tkz57UvCBBT3UHxKZ96Iask8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9vHfZoGSBVhnGPEc84zyDkyXTI16yqJ3sloZT62msG9uKmZZv
	pqBwLn2ZNMnnPMy4BGHkWx4n1tLzVnuxBlDL3F5vG+RDvAhdyvfaSQQ=
X-Gm-Gg: AR+sD12p3Iwd+OMJAcjTyilku+XjNC0U4pOXVvWqWCXGmBFYa1iI5D/n8ENtVHbNszC
	NJuBESn/gzfklxcgv2hzuFitb3njRku2oVJRayfmG5eABojob1eH7WeMmsld+VDS/vkgucPuHSw
	IiuZNric1iBWZIcfIEEgqYdCosHHp6XUjugWujuoIRZLINOGLYlGhAVKbkb5gt9+QE3zd/NpT5I
	UBtr8wHX3XOQvpYLN0ZbiJoY6XslKE1plZhBMeHNoNYc+Pv+K5FuOzfQMlSV9EXXRqJq0IBqVAb
	pwtFd5o+oYJlayZxzUfYZ86TUYrH1nouceH+A8WBEJu2v7BKr2U0EBObyU27Uhz5/e/XW1nWhyw
	RMaEcRtUnzdEyybJ8abU/CTUmSP/3xq61YwRBSD1XdGqPqUPse4dk0GKxYC7Ye8sDMcOGY0P3C/
	/LbdaYP7u/4crTAE0JX473XkPKiq+KbWtRucxW6Cxo4Q1dca2mFD+bVzpr2KNOQ/dVGqKaHFwL5
	n2C8o3T/7s0D9lVM3d0xqzG8nzLclYVwx/NjR7EV5aT4F3VxRgFPPkJcr3x+wHIFh8BQzuRNEMj
	ZtwwY7AEGstAbw6AYiiRW5GAqY7Bc2Ksyw==
X-Received: by 2002:a17:902:ef07:b0:2cb:2b84:f431 with SMTP id d9443c01a7336-2d015d607d0mr57360965ad.47.1785291501453;
        Tue, 28 Jul 2026 19:18:21 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c5096asm3778355ad.81.2026.07.28.19.18.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 19:18:20 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] rtc: m41t80: clean up watchdog on registration failure
Date: Wed, 29 Jul 2026 11:18:12 +0900
Message-ID: <20260729021812.49868-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The watchdog miscdevice and reboot notifier are registered before the RTC
device. If RTC device registration fails, probe returns without undoing
either registration. The remove callback is not called after probe
failure, leaving callbacks tied to a device whose driver failed to bind.
Those callbacks continue to dereference the file-global save_client.

Unregister the notifier and miscdevice before returning the RTC
registration error.

Fixes: 10d0c768cc6d ("rtc: m41t80: fix race conditions")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/rtc/rtc-m41t80.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -1008,8 +1008,15 @@ static int m41t80_probe(struct i2c_client *client)
 #endif
 
 	rc = devm_rtc_register_device(m41t80_data->rtc);
-	if (rc)
+	if (rc) {
+#ifdef CONFIG_RTC_DRV_M41T80_WDT
+		if (m41t80_data->features & M41T80_FEATURE_HT) {
+			unregister_reboot_notifier(&wdt_notifier);
+			misc_deregister(&wdt_dev);
+		}
+#endif
 		return rc;
+	}
 
 	return 0;
 }
-- 
2.50.1
