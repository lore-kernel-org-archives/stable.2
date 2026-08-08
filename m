Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB3B2E401
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786174688; cv=none; b=ptJ0zLUe+E7NtCMI6URqcXDo4nuLh1Y8jlDZq+pSSXh0aZX3XVXmPoFmhtTDosQY1VL0DzzN4qWUHQ9M3W3gdiGMWmCz7EQK09Vn768IoH3payM2ng9CRRBOPc/HhZW3GTjiTZ6a76ak2TBQ4SaY+6/V65g42sR3rnu3ITwE2v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786174688; c=relaxed/simple;
	bh=a18SA0kQmpnDruLfcZasBwPsx02z9yaF3DFh6MG3i8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j43r6xqNQPMpgDaCFwflzPQOn/E2GrErguqpsEcZ+8t7JdMthuoetwdSwA6qGf6vGvFGb9LsCots0qRZhFge3jHJ3rbZnqv/azX2FKB32MQoR6+nhz15IfHaWiCmI1JN9vuoY4HLNCoVqWaxHfeaSKkDFoOGqbW3QqV8Ao1Zjnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDcQKnUN; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDcQKnUN"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cbe827e3cb4so242085a12.3
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 00:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786174685; x=1786779485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QZ3y0avheyoaouXFIVz5Hu8HDtYYb6j86ujlX80DrU4=;
        b=lDcQKnUN530XaW+ieNATqN9EGjJXnDU6tQD8q70fDH9nyU8pAUHFGmHsTBrTPcTNho
         WYYlsBN34SnFHtuOrKqRySHK6jwNQzL3RrBwi7FarSgDQElFC13QnbIR2GsTlR6yGyrf
         8VwOgQoqIQVjVzQnUVAJQHLS1/GY6tU4HAtR/YUotzhYreRpF/bVJco19McXG9KQPLWE
         0ujwXuONAcuK25/tI+ROH/jVzgZsuLDHA/wdKZhWb6JL+7yX57mqjQ6F6VDCogdUKMMx
         4axFQwaamzfYaKmpF0si4nIQEJnAPJbXfyPCrAy3Yc5O/AkaqelJYtzf01fjXT2Y8kuh
         /5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786174685; x=1786779485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QZ3y0avheyoaouXFIVz5Hu8HDtYYb6j86ujlX80DrU4=;
        b=pPeJBD/42HyNPdpX92Fau8HjhnSHKZCUlnyNT4kBoimcel5B/xQMMH4STnCFbiI6vc
         ATrxU4x5iyAb9Ok4rWfI+1VrqTXRUL6/3yCtDTueZgFGdLFCE0VbPO1n8Hro7fbnWmwA
         J2GgR0lxFFWqXU/rezVNvzerXC9XkUiy8W7ummlZXKLSwznykSLmPd8xYNbyI9AyzbVq
         ofuPQ9ESPQO2d3BSO6fjhZ8KkDD9mxJpUAWkzZRWX6UMY8W+Uwz+dArcv47Sa4j54YBD
         W60NJ0azwlLL6iBd5ejzNvGBjLhU88XOLA6aRJ9OEiAHmkFqvbmLrX8KYHSw15fg5D1a
         ZPYw==
X-Forwarded-Encrypted: i=1; AHgh+RqZ/yz3W5KS4ruCFJrrG/VXdI+OwuC84JWAsOhSBZ8lL8f2wwUEzYyxtOLodW/5e+8yNihzIHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnTXA3DPIdrAjhjELH2FNlKzuiANgEQXMuGuP786ZKscyE9DaI
	0IbFLC+SrCRY8uhoWGfCZLgrQl3QU9et/6rY+53xNKXQJinh1IDhYBlD
X-Gm-Gg: AR+sD115xr/TvtcHSETMxG54+1OkV9Q8+5DSBFsx6xonUfzLDwHofYgPoq8fs77keL8
	Ohj7hKARQXXGrFCJOG/Oj9txbVZymw27IL7dYW5chxh9jbwzxBB/H2BHHWw8wrKPYShetsJEtY/
	4CfPReuvkod5BFt/0PbC8GB8/05QuL3LPFusIQxXY3ME9uOTZALWZJ/f+VS2YceeKioyENYjq9x
	ONLAFiQ0+aO24caZ7jVP4vK4/2xJWD+4xvaKZD5wDyjht+SbSVZ4ETnIjXU21pap0vT4XGPRWuw
	+LNSsJ2vtaN6u7kdxv+yfvVM/gOv2u5XKJPmiUVOcd6gG6u5jR3X5lfhhtI1Y+EykYghIRFymWB
	NGf4sx7iqIh2Co/xsZJKJiQKJG3YrtC4PgrdLImJOHOw3g2uBrav1VPbwlHIHNAWQVVIkA3KIfp
	aDcxYno6PS/Yn5KZzdbN315ebGzCyd/oUnqq2Vn6WjQu78KWIjFWafMrn+qA==
X-Received: by 2002:a05:6a00:1ca2:b0:847:8ccc:d7c6 with SMTP id d2e1a72fcca58-84f2e0278d5mr31776713b3a.31.1786174685244;
        Sat, 08 Aug 2026 00:38:05 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a58dce5sm1891208b3a.58.2026.08.08.00.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 00:38:04 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Daniel Thompson <danielt@kernel.org>,
	openbmc@lists.ozlabs.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] hwrng: npcm: fix usage_count leak when autosuspend_delay is negative
Date: Sat,  8 Aug 2026 15:37:48 +0800
Message-ID: <20260808073748.2649808-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

npcm_rng_probe() calls pm_runtime_use_autosuspend(), but neither the
probe failure path nor npcm_rng_remove() calls the matching
pm_runtime_dont_use_autosuspend() before disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() calls to both the
probe failure and remove paths before disabling runtime PM.

This issue was found by manual code inspection.

Fixes: c98429297d8b ("hwrng: npcm - add NPCM RNG driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/char/hw_random/npcm-rng.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/hw_random/npcm-rng.c b/drivers/char/hw_random/npcm-rng.c
index 40d6e29dea03..43f96abee753 100644
--- a/drivers/char/hw_random/npcm-rng.c
+++ b/drivers/char/hw_random/npcm-rng.c
@@ -118,6 +118,7 @@ static int npcm_rng_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register rng device: %d\n",
 			ret);
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_set_suspended(&pdev->dev);
 		return ret;
@@ -131,6 +132,7 @@ static void npcm_rng_remove(struct platform_device *pdev)
 	struct npcm_rng *priv = platform_get_drvdata(pdev);
 
 	devm_hwrng_unregister(&pdev->dev, &priv->rng);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 }
-- 
2.43.0

