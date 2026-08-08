Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C1A2C21F4
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786173936; cv=none; b=JWLa4tNcrPxh//P2b6AmkwLxn17m/+6tauM8h+MHskbHLvcSTv3DJJNQmHi960s128LLY/CAY+MjPCMBZDHNVp2CSQjL6nk/3gWuKKoFheUvXVxVnXl4vUzLrFpz9JZLLg8+3FStPi8/PIuFkuXM1nC4J6CVo9FXA40bXcgnfO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786173936; c=relaxed/simple;
	bh=G1BNkX7MmoPkXUOj12zHxbfv+qVUKXjsfvBuX8CZIpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YCqFtqephf+YVJ21PXEyNsDjBjyCaPV2QR838evsgYsg4YrT44AyTUlnbyr8ViZi+ijSiGUlrvoBnap+4wY2Yd1firc1nq3zhN0KwiowkV4AzB2N6uIrmgqyzFOTZXxHIqkoTbw3OQX/77OF5LyODXbGdMJtyCyr6Qwqsw3fthk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIoltbUI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIoltbUI"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2caea3f742bso5434025ad.0
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 00:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786173934; x=1786778734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CwYH+YDI8SAmi2VA+WwpQ0qieT+uWBICR9XfrxWBjvg=;
        b=VIoltbUIxZBN2xbH631/e9CVOlKJ50RupYU+JGJbnleLCmxbxoL/59T/N7UScnjGoZ
         kpIe4ao4VPWLhlXpERnEnuzcnptBrvjQAPwTSUrXK2Snqi4rs08HMPXQK6hGDAhjtet7
         lYLcHH12MXVWsxWy0ghQ1DabicaC3TwSnqdxVY2xVAfNR/QgQt/O1445eg2E65CqIUKq
         VFkWtro+g2DnxcNLURf6+tjF8MBJdfXb4Mi3+nqAkZNO2Q9rfnt2c7e1H+sxIiaMSdya
         4w1w7OfAQZlBX4St+tuPCfvBMKTQpwqgQKiwkOocn6MSpPzJE0G4EML8+HSZcwCsNuRH
         uV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786173934; x=1786778734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CwYH+YDI8SAmi2VA+WwpQ0qieT+uWBICR9XfrxWBjvg=;
        b=beg5ODLihZS0CVrVyFW826ctfYlHEkrn4jhHwuZImgormpeBOcixeK5sQG08c4WLjc
         VPdaUPYaZ88xJ/7xlZTQDyp61SXjO0sisatVn9rB7VfrWp6Pt90miJbCHEt8n9uTTJws
         /BuMglHJPFVO05dP9dMYgi4uaHF5fRDiCqxl7b72LCLWoQC1J/hBGf/6+nuuu9OaYR3C
         MCdHDVOikQedV9JRnlz/A1M/KCALdqPKqxoJ3N4QKimN4T2Pu2MQcPpoDIk10HF6EvDk
         hSvGWQOosNS/VcIPItogkPwfjJibI0NcJcMGcjo5AxaKVbEwAcmWKddfKKD1pNx9yHmL
         PiIg==
X-Forwarded-Encrypted: i=1; AHgh+RpnZcJ5dz4CVnwdH2ALdwpAcdoMNcuoODgo3cNkJHUX/vQJxVCGX3x9kCgNz5gaW/kgeY80Kl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqQkD+3Yr3j4zRTfbbqoe77zg+aYkBeFqhOKn7ZOf0VA5M/J7U
	WI2RrMyCRl1hJnGe7NGJTSAZmqfqK42peBvk4Fva+bjazEZwNqsvJyWi
X-Gm-Gg: AR+sD12ZmlmJ6pihqs7LV4yTyPqjBM+vYDqByZ+grlY1b7itNmUZQ7NABDaVJlrOguo
	A7q/K8aeE9U6qT5Fb3ZAoNc+z1F536GrTgxSjdrewtd+8BIVy+yLB84W9z8OLlTHAL7ZKxh+MXs
	w/J3askzHx3hx/7uGcS2ddoAg/NKiQEGSW9UeSgdUWGR3bl22so/c4WKABgfB0SUUy1BXBFnqSY
	EmkhqerWyZgoKvDZ3P+y1G/vnwkoJDLf919GbaHSBLKmbLs7aOJSH7zevc9TCk38YHRriPUL47R
	1Zj/eEbClcd9jxXHePJwWDiQsfioMgbxCn7SBGFiOyyVM8+5KNp08xM9+9/Wgv9Hq+vpMBL+Tgu
	SxKaEpw3Da1ML7HS/khquaP751QCwFCdBteJr9eTNiZY0VjEmhb5IVAK8+QZXcoC0nzDLowEPB+
	4GG4mL5ssZ9ykpzK7560HRPBEWoI70MUWagOfjQdptZk9IbczMIA==
X-Received: by 2002:a17:902:ccd1:b0:2d1:1a28:10d with SMTP id d9443c01a7336-2d11a280465mr159732205ad.18.1786173934103;
        Sat, 08 Aug 2026 00:25:34 -0700 (PDT)
Received: from lgs.. ([118.193.33.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14ccadef6sm16578155ad.11.2026.08.08.00.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 00:25:33 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jia Jie Ho <jiajie.ho@starfivetech.com>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jenny Zhang <jenny.zhang@starfivetech.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] hwrng: starfive: fix runtime PM autosuspend cleanup
Date: Sat,  8 Aug 2026 15:25:16 +0800
Message-ID: <20260808072516.2640658-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

starfive_trng_probe() calls pm_runtime_use_autosuspend(), but runtime
PM is enabled with pm_runtime_enable() without a corresponding
pm_runtime_dont_use_autosuspend() during driver teardown.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without undoing the autosuspend setting during
teardown, this reference can remain unbalanced.

Use devm_pm_runtime_enable() so that runtime PM and the autosuspend
setting are automatically cleaned up on probe failure and device
removal. Remove the explicit pm_runtime_disable() from the hwrng
registration failure path since the managed cleanup handles it.

This issue was found by manual code inspection.

Fixes: c388f458bc34 ("hwrng: starfive - Add TRNG driver for StarFive SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/char/hw_random/jh7110-trng.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/jh7110-trng.c b/drivers/char/hw_random/jh7110-trng.c
index 4712c3c530e4..34b2ec3e13b3 100644
--- a/drivers/char/hw_random/jh7110-trng.c
+++ b/drivers/char/hw_random/jh7110-trng.c
@@ -336,12 +336,18 @@ static int starfive_trng_probe(struct platform_device *pdev)
 
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 100);
-	pm_runtime_enable(&pdev->dev);
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret) {
+		reset_control_assert(trng->rst);
+		clk_disable_unprepare(trng->ahb);
+		clk_disable_unprepare(trng->hclk);
+
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to enable runtime PM\n");
+	}
 
 	ret = devm_hwrng_register(&pdev->dev, &trng->rng);
 	if (ret) {
-		pm_runtime_disable(&pdev->dev);
-
 		reset_control_assert(trng->rst);
 		clk_disable_unprepare(trng->ahb);
 		clk_disable_unprepare(trng->hclk);
-- 
2.43.0

