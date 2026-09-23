Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8BE4A9D58
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790163576; cv=none; b=KNnX/1bNF/HXGPS52fxchZ3I8kR60T4N9wgMJT+/yAkKhOVo+GJIQQ8PdJp+Yhg7X0FFYTEUKduGKlCH/nYe2HMntdef60jCmwbwfgzfmF4wiAtr1M8SJ89J1GGlQAJ8eQ7aJuve7fScEjTr5nOkW/FBELptymGckN/F01Ic8eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790163576; c=relaxed/simple;
	bh=sT3f5CSowAx+WsW39V1WrOSwBm0jKQKK9E8vUOutaIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s1mHnw5oE27PN1NTb3NLrjNKjkEoAjkJVGhaIyf9Lq46L6/mTLeLyRkUprDyTRuOieDtkyiOBPiKZNjW8JwmkvZ1RBYu5xwrUBGNSC+YFC1vMurC8RkXVfhOqwloR2/2R84jAcaFSWU/N5wjMQgqSenhXGy8IKKcv7L5tjXaS1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzeNRaYD; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzeNRaYD"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so545338a91.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 04:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790163558; x=1790768358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=byz42tnH1aP31XpuO9qZLa1U10ksdFNPyaGh5na7j6c=;
        b=NzeNRaYDGgTPsP5+R0aHfOkfVd+DW7WDkc3/DOFeI3Ofc5dww2g50qILzu4TfZ4Z0w
         LLiRIAJwemsmzO3DEqki9S6jT/10lnQh25fOqqNMogEKNnLo+/+0KHSO0Q5PcUMoVnp8
         CcRhmkeRLrs3aeED723MoSUGY2aEbB1QszMpmnn+h1h65JpdVGVspTIG5Z5LRM4KXqNs
         3fD8BM+KPcWD2L93Me1OmznTHj3kKORWdvzmINIAN9Fv38GG7PjETDlfGt5n9aijosg4
         8Q2SIr5hVY9UMtdrRWE+Bd7JDMrZGH7JjL0hf519c/DnBnXuN9b64Cy6eoIv/aEJ5pCZ
         i6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790163558; x=1790768358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=byz42tnH1aP31XpuO9qZLa1U10ksdFNPyaGh5na7j6c=;
        b=VyWLDkeH+sRd+68LspJj+C1+qABws4QLIKTQ1mZ56PeimVr7SXq/z+SAS7DnxLtLzI
         okFV0DkFjzZ9o9zuqYSg7+0TgMI0CTVbkJftL9hqr8hfwZadACw7SB4NsDH/LU2ue8rS
         Yv+BA7HxrRXkIUKPSeJLzidQa8GgWJWNfhQtG54FiKxaj236OimO3OfzxtT6SAXqKUtA
         Y9MuK2Yoqknyp+NY7SaQ000odWUsxwLoypTR4snnrTuR/KDzqY4TODsd4GVPKr6CXsAb
         hCBu0eN9GNC055ugtQjd0ivsz5q1W/5gk8N+kZmeZZvPGxrWDturx/vj6rL+zzGbyzR/
         HVeA==
X-Forwarded-Encrypted: i=1; AKwUvBxpQ0vpn99KpS0szrEMWxgdJE6d2dTZn8CVZJ7+hBrWhd2tcbLfSNoAiJJhJWbOz3hMOOX2Efc=@vger.kernel.org
X-Gm-Message-State: AFuF++ltDQgtVIk4Zmbovkdevv57rxlBHO14ShiIIOxFbY0tqd6yQ1/5
	jPDMkRDKap1nwYWXmctmk0dhQ69mjooVql5AMd6yoHKeOgJ/cxuzh7ti
X-Gm-Gg: AYBFou0HlCXh+Pu1lUWcCUEU6zbBia/uQzZ8r6dkdPdrOMhGYFZLsAK1oEmZel5W+M/
	p6t0OUkAwI3Y2tYDlm4UECB9tjWIdSTGMUYqG0EBqMsGmIY1YYC+JqskpHaM+LsdJ6/LaMAP+sw
	5kuxLaQwOuxVFUDcJ1fjcRJ9Lba+8LWg/nbeSk8jzpADq41cCsHgwaYA+tmD55t05f9jLcXF498
	49pCfcpTpJv35h9bMUWSp1Ka9g2L1l8ud1LuGu3M/eWwH3ynnNGZtDGRjkwufpvJzDSSHKeIw0f
	c8soEFzHBWRA7cDyqpmGflAQRFsiUfvD5ACqcw6+sRMWHIEGCpVNv+iH9SaZapNQBd6Rwr4w3l4
	y/9hI9ogGJ+mBEYqwvkLJIhSJAeCd5Ctm3cyT1IEqV0JWKml01UEx0eBi+qEBgFxqvHmCDS99h5
	i+ev+hThTlVyTgogCD2QUvGuDxNxCLinJ5o7HcNPMVzUO7YsaNyfCebT2A9/MHa5cw2+Ve5veiH
	lDHNBklbl3yQ9j6bQ0J
X-Received: by 2002:a17:90a:c886:b0:39d:f08e:e6e7 with SMTP id 98e67ed59e1d1-3a07e5373camr2045004a91.9.1790163553103;
        Wed, 23 Sep 2026 04:39:13 -0700 (PDT)
Received: from cfarm424.jing.rocks (cfarm424.jing.rocks. [2600:3c18:e002:2e11::c424])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07ddaf4easm4654288a91.6.2026.09.23.04.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:39:12 -0700 (PDT)
From: Ridham Khurana <khurana.ridham222@gmail.com>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Srinivas Neeli <srinivas.neeli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-kernel-mentees@lists.linux.dev,
	Ridham Khurana <khurana.ridham222@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] gpio: xilinx: fix runtime PM leak on request error path
Date: Wed, 23 Sep 2026 11:39:02 +0000
Message-ID: <20260923113905.1409290-1-khurana.ridham222@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_get_sync() leaves the usage counter incremented even when it
fails, and xgpio_request() returns the error without dropping it.

gpiolib does not call ->free() when ->request() fails, so xgpio_free(),
which holds the only matching pm_runtime_put(), never runs. The reference
is leaked and the controller can no longer runtime-suspend, so its clock
stays enabled.

Switch to pm_runtime_resume_and_get(), which only increments the usage
counter on success.

Fixes: 26b04774621e ("gpio: gpio-xilinx: Add support for suspend and resume")
Cc: stable@vger.kernel.org
Signed-off-by: Ridham Khurana <khurana.ridham222@gmail.com>
---
Build-tested on arm64 with CONFIG_GPIO_XILINX=m. Not tested on hardware.
 drivers/gpio/gpio-xilinx.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index 532205175827..9406ce85f933 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -271,14 +271,7 @@ static void xgpio_save_regs(struct xgpio_instance *chip)
 
 static int xgpio_request(struct gpio_chip *chip, unsigned int offset)
 {
-	int ret;
-
-	ret = pm_runtime_get_sync(chip->parent);
-	/*
-	 * If the device is already active pm_runtime_get() will return 1 on
-	 * success, but gpio_request still needs to return 0.
-	 */
-	return ret < 0 ? ret : 0;
+	return pm_runtime_resume_and_get(chip->parent);
 }
 
 static void xgpio_free(struct gpio_chip *chip, unsigned int offset)
-- 
2.47.3

