Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313663;
	b=Spn917EDLychHOE2VSKI/gT2He7kT8JkQSHK06rpwl+CCA6D27e1wVG1kUoeoYWHYz68
	 sTsINnZODH7cyJwELESdsJpgMrWdtTwczq3IP0evciF5/RRfHNZ6eJ+1+hNVJfE4fb1AH
	 c3Mb0jj2dIE5NTtSRGr+jGEjYAWBU5JVPHAFuZV+in+9442od8YLTezXqJgg3bt/HA+39
	 XYXUTubXpKenSBiZ3WRvl8lecio3iHEBU0aivWy97aHOT84R3mHgMI5XFEI20GrvlARqu
	 +A6NKKEgaSvs0y7nExacLQxEtYk0y3mueTv141mY/XxjJaE7irPQiB2hEq63xAdcklw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313663;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DLXNd+GsLuXv98OnBbwkj0DI81//n5Lysl4qs6dM56U=;
	b=Mz1ZRrEPwJ90Fo/QHOeOdidKjdRqov//kTMQSzZFFfDPaoRR5P9uXbPpFPQarcku7+7/
	 zm1kSFMJ+h/K1OuEpC2upw27fJe6ZlH7xStrpOKMNiHm5RNfzB3M+D72+zjqBdRXIlkDK
	 iSPcKNhtQoqds1iJaqObxYF1YUJ7KZIKu+lzIM5i0wTuiwfI+lkOmkGlS0KK9WX7JLe+o
	 Vu5fRsR1XPtLlBYMgki+9hFFJfTCtclvA2LS98Jj2+vp4o67rGbIOD1VM3plohd5wrFsc
	 dZ/NBqdMCVxIaqEAyricyfaJOw5NXohpObtzDcJc6rSiYeWX6OK6tUQL9YgHSBUDW1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oECG883b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16214606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oECG883b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664851F0089F;
	Tue, 10 Nov 2026 12:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313662;
	bh=DLXNd+GsLuXv98OnBbwkj0DI81//n5Lysl4qs6dM56U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oECG883bat1CwNw4Al+xgk7Yjf7MPjVaJs2TeYDzwQoLbIAD14R3dtrrJe4LOtyTP
	 9s16xXWWZz/UcFhKTOg54co96gy8lK5wzPViDGqj6jiD4sh6MoxMV9EoHEW/p0wFtc
	 PxNaznfqSrjxSIpzLqTJ6MPqGn77e0ZfYOXlasv9tMXO0kQDwqyNNUyqUielvbz2Qq
	 g5/gSfbS5pfHLT8HZyWexuZgwW+XXOmmYlXxm0YUoMZmikxNQRi1QzaDRTU0AwOfPE
	 0JkgQicXhmuC8dCiuGQd1s4GiDwxeVpBkqZRzXWs44fdRVygztfhejD19b2EQ3C4q9
	 mhQrmJ4/fBzrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] ASoC: codecs: wcd9335: Simplify with dev_err_probe
Date: Tue, 10 Nov 2026 07:27:40 -0500
Message-ID: <20261110122732.1208057-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060034-failed-5.15-082723fee626@kernel.org>
References: <20261107060034-failed-5.15-082723fee626@kernel.org>
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
index 4170d8dc3e89f..24c3d1c28a294 100644
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

