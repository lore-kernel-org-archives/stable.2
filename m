Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313303;
	b=bplqL5rK3rS2pIUxgt5bb5W4J9Tjk7qv7T9KvbyNVc1c60HCJ6P2PjxORhYau2RoYbDp
	 GO5OdALbKrkdA7U00AlMNpzukyOM2vARLUY9EcHxxCN2+QLOOvpEVrEelIIgegjR6i+BM
	 SC1ONWh2bhNFwM7EXCB5tsWnBoWeBEXw+wu0I+ImMB4o+E/WU6uld/5MD1L2ARmXtsapV
	 BeG5d1PdTfsX0q18/HA796uSdvcQimm0BFpY8ksWQfpeir5L4LkFmOExNVV45retN/LRI
	 TJMAALgG2+XoLdZmnIy9o+LuZ7Coc8cC9qPJlD3Q58spMaf8D4LpaB+f/WYNSTIIiYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313303;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0KPPhYnrpAv8MiWpG1EDQv1RWw4nWMRNpPnLkdzM+Zg=;
	b=OSDAAJdnihY0Ny3GTwNQTHohUjWM2TOYvV/ZKwsQ+H81YtDQgvf+vfhn8++bXuED848Q
	 bUwRCMfz55FxmHA8favy/pPnS1HX4tQYVSi9f5CdEC0RU5aN7Tu5y8O9U+qVeZ+qRO1QN
	 8u02Wm2Wxj7sUZDeXJ7WR+lPI9crptpQGyDkeB6L6x3tnSx0YUpFwCObc5U32vGK7PU9o
	 Cny2tuL9bb10ynpNIUYjlK873F5FuV06Djk2QhHgaz+6kAcrfP0gt1H9FYm1cx/2EDPPY
	 kqQrSRh9qjKyzV8/05SlF1A8Txn6QhN4SamC2tBz9hILd4dgjH3QGTjYieBImWc7+Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eCgUuo7R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC09606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eCgUuo7R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05251F0089F;
	Tue, 10 Nov 2026 12:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313302;
	bh=0KPPhYnrpAv8MiWpG1EDQv1RWw4nWMRNpPnLkdzM+Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eCgUuo7RIHlRlRFJhJRA645NYQzG2j3KGhGoR5aZpwbSZWlVJSw9Lm8ytUXb9hIHj
	 hYr+sBchJrh2u/d0wsAPcF1F/3aYzhMRnytoSjfQ/t5exl9QxlcFl8hjmwEywbZeZt
	 YhI/ioF8KG61oLjb6PKXWjgMA+peE+FKv3VZsi8rSm4Smw0SNT81t0s+/SCY0YJP70
	 iXLcsF0Dh45P9V4/chPjSB1Vw5pILTzV8GpxUxi5XTxEm+aUpN8X2/kQ68LuVMvnxP
	 dTn88m8GEcjSYTQVxmVFJjA4vofMYlsOPqcmRXIqHSACYMK266vntmiKlrOKI264AP
	 +gNtiOTjaA9RA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] ASoC: codecs: wcd9335: Simplify with dev_err_probe
Date: Tue, 10 Nov 2026 07:21:39 -0500
Message-ID: <20261110122135.1110460-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054310-failed-6.1-082723fee626@kernel.org>
References: <20261107054310-failed-6.1-082723fee626@kernel.org>
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
index e810951f78600..4d7b9a8470fd2 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -5118,20 +5118,17 @@ static int wcd9335_irq_init(struct wcd9335_codec *wcd)
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
@@ -5197,17 +5194,15 @@ static int wcd9335_slim_status(struct slim_device *sdev,
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

