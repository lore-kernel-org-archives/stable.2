Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314001;
	b=mKAE3uleIxDpGVV1Axj9KWfSTLYGoBj7Xj4MQs5jeAPuNWBJ6/WylTPraJGoGOuA/AmA
	 /go3ishUW+gCg3zSkjHy1M+a0qHHFRVda71BKvDFhQ+22jZCgYzvfmFbLwoiOxN4rPn+G
	 BoJWLzq9mY5ZbWYDzjKB07TUgpKxbyOxvXjksTpLeD0CORXCnutJLtbf90F3S5IOZm3am
	 gLkrK8OKgjN3mF4hvEgiEeXjQcDTJqoP4biOtNBrQOOK9beey2QAo+OEeeNYwV0/BbBEQ
	 ohaQIQ5/oGS6qazCdwz+rS/WcbiYZXKP6sk4I8r4X8ewZ26FyUN/a7cgFr1y9zxn+Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314001;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=73VPcsdW7PGLPLIML0zK7ODRuWeAEY2x3bgCYkBhPNk=;
	b=kwTpwuHVo/1uJUllHvQO1TbawoX7H4jJDlshsjh74I3PLPq9eXsGUgjrGJ46J8NE+OCn
	 X6014IvtkArThuJ2+u7/jduGyYtRWl2PKYhwEOBmGlvXZFGInUcoeYeYRKrnIyf4+Vz8R
	 Ff5wvjPZwD2odft5DHM8eBOel8NT6sRrfwwoHpb+R0M/XUMYwi0AyF1DyWvEYNF/77B15
	 BBiGCTdgsIhxQn+Q/hzRXZg/j9MKtur7dPFNNfNTlD8Ea01fJ/azc5aIqIT3E8KL0pNaQ
	 VB1GL7EhItewjBYIVqj6FiphkhGuibh0y0e+QN3yzLT45aybb9ShD2Gl3T8/u3N3HeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FR84F9lx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3CA606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FR84F9lx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76BC1F008A2;
	Tue, 10 Nov 2026 12:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314000;
	bh=73VPcsdW7PGLPLIML0zK7ODRuWeAEY2x3bgCYkBhPNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FR84F9lxg8z3iJdD9Dkp/LdsrtrRiZpjvF1lal79TitmZ6jx422EIJWALWZMFcKVn
	 0BAA/OANl4S2rl9Oj9N1eHzvx8wFCIIXSu85GohXQ+NmlGxYNxm+B6DLvHH+bigVm9
	 3HfmX5jgwvAPJH7dKGH9c9JOlkQoPYfoTQ/aGoKr4ildXPPPNsIQtzfZvo/g3c8aPF
	 zBLIFYr2wVwPEc4hs5mdzUp//6okSr6ru3BpNLlJD3R6kWxe8TjYPDdKjy6HhZoP9b
	 GDgx02X4/X2CFEMRXReEllCQDheAvbRrNwm3VHc0g22CNwux9UEalApkOp0LqgOiHY
	 6dE1ZMknsbjFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] ASoC: codecs: wcd9335: Simplify with dev_err_probe
Date: Tue, 10 Nov 2026 07:33:17 -0500
Message-ID: <20261110123310.1277074-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061722-failed-5.10-082723fee626@kernel.org>
References: <20261107061722-failed-5.10-082723fee626@kernel.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 67380533d450000699848e292d20ec18d0321f0e ]

Code can be a bit simpler with dev_err_probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230417141453.919158-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 082723fee626 ("ASoC: codecs: wcd9335: Fix SLIM interface device leak in wcd9335_slim_status()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wcd9335.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 003b9086a6173..1f4a3407effd9 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -5130,20 +5130,17 @@ static int wcd9335_irq_init(struct wcd9335_codec *wcd)
 	 * INTR2 is a subset of first interrupt sources MAD, VBAT, and SVA
 	 */
 	wcd->intr1 = of_irq_get_byname(wcd->dev->of_node, "intr1");
-	if (wcd->intr1 < 0) {
-		if (wcd->intr1 != -EPROBE_DEFER)
-			dev_err(wcd->dev, "Unable to configure IRQ\n");
-
-		return wcd->intr1;
-	}
+	if (wcd->intr1 < 0)
+		return dev_err_probe(wcd->dev, wcd->intr1,
+				     "Unable to configure IRQ\n");
 
 	ret = devm_regmap_add_irq_chip(wcd->dev, wcd->regmap, wcd->intr1,
 				 IRQF_TRIGGER_HIGH, 0,
 				 &wcd9335_regmap_irq1_chip, &wcd->irq_data);
 	if (ret)
-		dev_err(wcd->dev, "Failed to register IRQ chip: %d\n", ret);
+		return dev_err_probe(wcd->dev, ret, "Failed to register IRQ chip\n");
 
-	return ret;
+	return 0;
 }
 
 static int wcd9335_slim_probe(struct slim_device *slim)
@@ -5211,17 +5208,15 @@ static int wcd9335_slim_status(struct slim_device *sdev,
 	slim_get_logical_addr(wcd->slim_ifc_dev);
 
 	wcd->regmap = regmap_init_slimbus(sdev, &wcd9335_regmap_config);
-	if (IS_ERR(wcd->regmap)) {
-		dev_err(dev, "Failed to allocate slim register map\n");
-		return PTR_ERR(wcd->regmap);
-	}
+	if (IS_ERR(wcd->regmap))
+		return dev_err_probe(dev, PTR_ERR(wcd->regmap),
+				     "Failed to allocate slim register map\n");
 
 	wcd->if_regmap = regmap_init_slimbus(wcd->slim_ifc_dev,
 						  &wcd9335_ifc_regmap_config);
-	if (IS_ERR(wcd->if_regmap)) {
-		dev_err(dev, "Failed to allocate ifc register map\n");
-		return PTR_ERR(wcd->if_regmap);
-	}
+	if (IS_ERR(wcd->if_regmap))
+		return dev_err_probe(dev, PTR_ERR(wcd->if_regmap),
+				     "Failed to allocate ifc register map\n");
 
 	ret = wcd9335_bring_up(wcd);
 	if (ret) {
-- 
2.53.0

