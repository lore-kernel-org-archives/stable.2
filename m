Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E781630DEB2
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 06:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786430100; cv=none; b=IGyBMvZ4nNl3PAwLYrMRA6VWFliDRkX4mWQPSoiUQ37/gr4liejn5oCQOHCMFXhA/Vq4POy4eEjpcGUcLo7UHbvqR1wjX2zYwMUcBeN5k6IEuS4+GgruijKpsMRvg+lxC6PUchdwknhYS8WWypr3MhY95P/o4HVCEqY1fgCs6Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786430100; c=relaxed/simple;
	bh=/IPDx1Pz5QgHGpnA1FZ7e9RvOdTXuUppSFRWbC86Gk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f2oFRRg7J/fx30e5+pctMyWEX46Ja+Fwb/1IdQtXt0SXDeTYdS0jmPIrrFMWyyuY6drc47r1HJlBooFeqTzCrynQRto5hdnt1TRhwVE6mihqjlgOyaKmc0uTF7/l/ahPkf5rTmoDQQ6frSTgFYZrQ0VErUP/D8SmEvR7+qXdNoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZnsqbAf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZnsqbAf"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cad8076b01so5368145ad.2
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 23:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786430098; x=1787034898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rs1yPzUnIco2rjC6CFhLVWVyr0WMS18/eTcbCTT31s8=;
        b=hZnsqbAfdlKEFqEWO34CFnk2uOv752mXcLPq/0L63f9zp2Gsh+dN6pRQrORlTzWSZh
         IsB4INsw3R7wTz/YW7dtZf84YUPTGCBnaWczlxxFk0elDQhAyoqPBK5LURIGXuLdlGUN
         7FbvUBSmzN7FRYR1m4wdP1GFqWffJkrazGO6CvBJEnpDY/BmjAnpa1vebRop2W2RBdnP
         BIs8gi5yuIBCBS1NFqFEVvtx4pQag1VeRGjZnP5mcswEDge6OHu1wR/VIKyi88q3Yr7j
         3MDnuO7rYFeacg2TSo7A2VLuKt06rV5eqJZRuiKARRf/PXafCg5bjy6SC9sFUoZEab2D
         dCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786430098; x=1787034898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rs1yPzUnIco2rjC6CFhLVWVyr0WMS18/eTcbCTT31s8=;
        b=jM6T0rTLxzBUomBuRdyX6FDtnbmB6xJVQyZNHmL41jlraKdTeTv3NDk9dMNNQSTNAM
         yVBpfulnDLyCcDUeNn6JEdk5l13jyB9pn4AqIpxnhlmLVlqFWZ8lRrKGyeiYAXSuBe7O
         LSgF6DjwRy5shQLhfCbt7pG/1Qfwcw5xB8T4W6x31fAfwpsPzh+W5k4DGwmrp/qSBoIB
         UqsgaVYGkOh1F4TIFA6lTKsBUynb+znp1ayOmZs/d19GEvWvqjJvfT6p3oFYeJ0H+/HQ
         0v2QUIipMyRtGbXZ7deQ64ePaBRHrAv5CT5DveErB91aS13gNOp5ikFj0QGR1mJ1Jlim
         rV7w==
X-Gm-Message-State: AOJu0Yye6I+55hSfcTqslf9rixFUWd4jkVcoIGg1sCPxs0Ng1l59kPsR
	r50x2COmoWVX8+rRfjJTJdRYELrD+ckqMZizKF47T5pMSF0Zcm7NAheL
X-Gm-Gg: AR+sD11eRki50xyDGf7sViDyZkDWv7Jdz5TYIZiMqzc5gI0L9AvrWk+YpkYqKbMZ1er
	c3URnC4xyI7jfcqdCaC78y71g68HBY8TP0op6z1bcFoeA2Pef1/frEeDJ5a4iqHCCYqqpuWBTEh
	3YYq5+3s1Qm/cIvXnZfux46GJKlRNm5WVyfVhyv5X9HQ8b52ZZOuu6rAZjjTcX9GLH/ElqdJE+6
	aRVb4U8zjAHYE2xF0TFYFQAHO0k4tlxK+1p8f/T4TfNQZ85Hit5Mdh/WCT7rVP5k6HWY6DJ0UOh
	QJ1G0ERNfcD0Ei8J3RNZZDStpaYvfz9uxdgJssoecgaYdU6UR3Mnd0iJ3xwpQD6g7ADVQE8MHmI
	lmuFEVUY5oqc9/w20NNKs/P7oGSwpaC18H1X9m9z2n7bBKIWqner+VMoA7mLE0RhO7qvuqOeb2w
	Yf7zW78T11zlRwhgZP0jDclQERNzUZEbEJIDt2aQIO3GqpATjitEg=
X-Received: by 2002:a17:902:da87:b0:2c6:a772:7e43 with SMTP id d9443c01a7336-2d31798510cmr11974795ad.18.1786430097998;
        Mon, 10 Aug 2026 23:34:57 -0700 (PDT)
Received: from lgs.. ([101.36.106.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d315ef11e8sm2383365ad.1.2026.08.10.23.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 23:34:57 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Daniel Thompson <danielt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] hwrng: stm32: fix usage_count leak when autosuspend_delay is negative
Date: Tue, 11 Aug 2026 14:34:42 +0800
Message-ID: <20260811063442.3058074-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stm32_rng_probe() calls pm_runtime_use_autosuspend(), but runtime PM is
enabled with pm_runtime_enable() and the matching
pm_runtime_dont_use_autosuspend() is not called on driver teardown.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

Use devm_pm_runtime_enable() so that pm_runtime_dont_use_autosuspend()
and pm_runtime_disable() are automatically called on probe failure and
driver teardown. With runtime PM cleanup handled by devres,
stm32_rng_remove() is no longer needed.

This issue was found by manual code inspection.

Fixes: c6a97c42e399 ("hwrng: stm32 - add support for STM32 HW RNG")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Replace pm_runtime_enable() with devm_pm_runtime_enable() to handle
    runtime PM cleanup through devres.
  - Remove stm32_rng_remove() and the manual cleanup on the probe failure
    path.

 drivers/char/hw_random/stm32-rng.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index 9a8c00586ab0..f5bfe54c01dc 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -368,11 +368,6 @@ static int stm32_rng_init(struct hwrng *rng)
 	return 0;
 }
 
-static void stm32_rng_remove(struct platform_device *ofdev)
-{
-	pm_runtime_disable(&ofdev->dev);
-}
-
 static int __maybe_unused stm32_rng_runtime_suspend(struct device *dev)
 {
 	struct stm32_rng_private *priv = dev_get_drvdata(dev);
@@ -590,7 +585,9 @@ static int stm32_rng_probe(struct platform_device *ofdev)
 
 	pm_runtime_set_autosuspend_delay(dev, 100);
 	pm_runtime_use_autosuspend(dev);
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
 
 	return devm_hwrng_register(dev, &priv->rng);
 }
@@ -602,7 +599,6 @@ static struct platform_driver stm32_rng_driver = {
 		.of_match_table = stm32_rng_match,
 	},
 	.probe = stm32_rng_probe,
-	.remove = stm32_rng_remove,
 };
 
 module_platform_driver(stm32_rng_driver);
-- 
2.43.0

