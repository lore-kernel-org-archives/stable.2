Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889564;
	b=U6hSVMhMMFNrucPjPN3QQUejpTh+7NXTOrBDhu/PPJ5LMAq6U8lYX8ChdiN9uibo66Cd
	 CndCpqP9ipSCP9iKD3C1SCnMzZeku5/bxe1owd2tVCtuAil8rTq6idTt3rkJlhMHIMZE/
	 FcLeA681cUZOqPk519TjhoMUPnwb6qSdcF5W+uHY5TsjGTbkdY6ysM1xMt0UFud9Rxr9e
	 sXyL7WNOWxhQG0Nu2oFrEUGf0Ke+lfpJK+kcIqcwDlRZJXC7NDHMP97YQHZN4RkStVeWQ
	 u2jM1S1+wYawlTWacvsvVXBTPM1gOoQvhstvcCHWXsV4uGWTQ+y5mimJB270d8exq/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889564;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QpIDARN/Vr1KReVbx3nRsZF63S3ezskxf8SAIxOLPM0=;
	b=5pUZ2M4ga1C1XjIBhicvDulzb9bBZVdUaR/l7BVDLFn+9CsAcX5gd6ej7XxmczFEXIxO
	 LVNA9+SIbAEw3kttY6UKBSdnL498gRI3REh95vGORqbF8NpH/RCCkPt8zkCOMnQ51QyfU
	 zZmGqSEBAMrXHLokGbLOCNlGz2Rn7tm/mViiqe7b1My5JW3cMUi8dBK8bPn0Ap7c8GYYC
	 5ENqEEnhepHSbx2uKJXktSao4Hi+bfc45vISBeDiuhZXqnXzRotU6qNyM4VAxEItm3i3h
	 L0+jNZyqushblnSoRiuH691i34UJMjU9WhJGllPRsu6+t9Eam4vT7vWrMRK6bSuUeMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rn6KgDF1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF06606A331;
	Thu,  5 Nov 2026 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rn6KgDF1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B721F0093A;
	Thu,  5 Nov 2026 14:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889563;
	bh=QpIDARN/Vr1KReVbx3nRsZF63S3ezskxf8SAIxOLPM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rn6KgDF1VNfg2Ip70MHdg7ocm/Ze02NeccCVLIxCRgQ3g807ZvWWLv3XL35SvsAPa
	 eu/8v8wpEJZCUiMxVzPNcX5dX2TxgPykEStnA+8bpht/29TxrGXTb3IL2SQv4fk2O6
	 L+gGqGXe5EgcRgP7pLX99xyU/pl1KNOWCq2iEGQeeZEcb7zge6ioxTFdrDfKI1dDg4
	 rTHFxxwpKqRqSoIN0q/SxFPWKSa8y9N9MArGP6P2EGAIyEJ8TpP/5iIzKalM1H+CF9
	 PzsOU/MKy/vxEazPjFPjTDu1YFYYA0vW7oBhZoXfIKshw5ZnSPyUB4882ZQPXvgq4A
	 eCSRCoLJQUXLQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Drew Fustini <dfustini@baylibre.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 4/8] pwm: axi-pwmgen: Enable clocks before accessing hardware registers in probe()
Date: Thu,  5 Nov 2026 14:38:06 +0000
Message-ID: <20261105143847.2559586-5-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261105143847.2559586-1-lee@kernel.org>
References: <20261105143847.2559586-1-lee@kernel.org>
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

axi_pwmgen_probe() calls axi_pwmgen_setup(), which reads and writes MMIO
registers to verify the IP core version and determine the channel count,
before acquiring and enabling axi_clk.  If the bootloader leaves the AXI
peripheral clock gated, accessing the registers causes an unclocked bus
access fault.

Acquire and enable the clocks before calling axi_pwmgen_setup().

Fixes: 41814fe5c782 ("pwm: Add driver for AXI PWM generator")
Closes: https://sashiko.dev/#/bug/linux-bc988dbc-7b12-4785-a164-b6dcab29b86a
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pwm/pwm-axi-pwmgen.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index b40522f01002..7c1b38124787 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -270,16 +270,6 @@ static int axi_pwmgen_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(regmap),
 				     "failed to init register map\n");
 
-	ret = axi_pwmgen_setup(regmap, dev);
-	if (ret < 0)
-		return ret;
-
-	chip = devm_pwmchip_alloc(dev, ret, sizeof(*ddata));
-	if (IS_ERR(chip))
-		return PTR_ERR(chip);
-	ddata = pwmchip_get_drvdata(chip);
-	ddata->regmap = regmap;
-
 	/*
 	 * Using NULL here instead of "axi" for backwards compatibility. There
 	 * are some dtbs that don't give clock-names and have the "ext" clock
@@ -305,6 +295,16 @@ static int axi_pwmgen_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to get exclusive rate\n");
 
+	ret = axi_pwmgen_setup(regmap, dev);
+	if (ret < 0)
+		return ret;
+
+	chip = devm_pwmchip_alloc(dev, ret, sizeof(*ddata));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	ddata = pwmchip_get_drvdata(chip);
+	ddata->regmap = regmap;
+
 	ddata->clk_rate_hz = clk_get_rate(clk);
 	if (!ddata->clk_rate_hz || ddata->clk_rate_hz > NSEC_PER_SEC)
 		return dev_err_probe(dev, -EINVAL,
Cc: Drew Fustini <dfustini@baylibre.com>
-- 
2.56.0.398.g882cbad275-goog

