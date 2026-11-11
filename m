Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384066;
	b=c84cQ7fPedK19eDhvixU4dIRcFXjLTdO2+hwZjOJ2mn7ZYT6/W/3AkcycqwreHcNp9+g
	 7KjBD4Ivt67Zc6M7VNQm3WU7kXEQWj9eDgXsu2gLhdwkPY6AWCecoCYCeD+CeGSlpxNji
	 3RifFevhjch2w3geTzjZbpNonpu2XA66SnWXa0dOGNFgwP+ETpukuGYARSvl9TBUc6mg+
	 5Cxm/U9EkxLrlhMZPtHocik+nww0VI+VR6dRLcsgT50TnS7tu3mMmqigLqX2PjfCMQUbW
	 2wd5NlUboKg1h7tt8CtN0XBIi0EDA7JFJ2VG43DnLI4CnT2zi9Y9syC+7ncfrRpN70w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384066;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9WSVJ61nhx3RMHTsIb8Aw/oTKylSYOlPi8S6mi2Thr4=;
	b=G19MRV9L/Q7ZXoifQgtC8EYvdK/PN+8gAiIsUNA7PP1GS8NJ/C+af3HxdCMyh0+JpPNE
	 /aL1iLHkW1AXsRROqxQTlFAFwjvWsxeTy+i4bIH8BtJFY0BqsF0HNYXkSv9d+Drg0Khmj
	 xgrevgb/7k2opWZPuWUdcFJZikk7XwnAgFVA2hILw2wYWJWgp2YjwYiNoGXCpTJSXODns
	 y9P+Ggmpy8weSbGRxEn/RXLINiGw+o55Rk0h0smS3wzFSTPeBwA4CLIz5X7j9oZoiWXmZ
	 ggNr2o0Fhw0xS5P7unVZDiAuh0NsZdZmdCOIDcmcp3G2KueGPx3AHspucecP8GbaM7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DUhD/iu5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0727F606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUhD/iu5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AAC1F00A07;
	Wed, 11 Nov 2026 08:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794384065;
	bh=9WSVJ61nhx3RMHTsIb8Aw/oTKylSYOlPi8S6mi2Thr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DUhD/iu5YzBqLsG28Zdte/G/4ntrZfjwGcz//WKSJxkb1nA4so7NWtbJ1diemLKgY
	 32/iZh46JnCyRVGXVQ2Qsu10VePJWUrNKVyv5eUHXPEgy9Yezn0hoK6kcpdIFR0fuA
	 zSntYirvIiPQcd8lJ/DFv45dmlDPrrReljxOPXLctxfkbXNtp2UNuoXBK9p+bJR0Pb
	 jBbJvZG8b1jTdhDhTV3mB7ATUq6iKZ2VM8DXmUd/O4Kn17XQnIaF8b0BfMYhSq0T5a
	 PJiH6emBMaM9f9t8mL7DTv/YwCLCo8Gz6uKADiIR9pugKCEBlMioBEaFkEUdW7pLW8
	 MwW2vIPX+df2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guiting Shen <aarongt.shen@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] ASoC: tlv320aic32x4: Fix the divide by zero
Date: Wed, 11 Nov 2026 03:01:01 -0500
Message-ID: <20261111080057.1408504-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111080057.1408504-1-sashal@kernel.org>
References: <20261107061052-failed-5.15-8cf9607d2d85@kernel.org>
 <20261111080057.1408504-1-sashal@kernel.org>
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

From: Guiting Shen <aarongt.shen@gmail.com>

[ Upstream commit 11e756cc85fac43e2025306ad6aea80114cc7e98 ]

The value of register(NDAC,MDAC,NADC,MADC,BCLKN) maybe zero lead to
divide by zero in clk_aic32x4_div_recalc_rate().And the rate should be
divide by 128 if the value was zero in this function according to the
datasheet.

Add the macro AIC32X4_DIV_MAX to present the 128 and return 0 if failing
to read the value of register.

Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
Link: https://lore.kernel.org/r/20230813125520.11067-1-aarongt.shen@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 8cf9607d2d85 ("ASoC: tlv320aic32x4: Prevent division by zero in divider callbacks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4-clk.c | 16 +++++++++++-----
 sound/soc/codecs/tlv320aic32x4.h     |  5 +++--
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-clk.c b/sound/soc/codecs/tlv320aic32x4-clk.c
index 96979243d3a6a..4ade06e5f5cd3 100644
--- a/sound/soc/codecs/tlv320aic32x4-clk.c
+++ b/sound/soc/codecs/tlv320aic32x4-clk.c
@@ -319,7 +319,7 @@ static int clk_aic32x4_div_set_rate(struct clk_hw *hw, unsigned long rate,
 	u8 divisor;
 
 	divisor = DIV_ROUND_UP(parent_rate, rate);
-	if (divisor > 128)
+	if (divisor > AIC32X4_DIV_MAX)
 		return -EINVAL;
 
 	return regmap_update_bits(div->regmap, div->reg,
@@ -332,7 +332,7 @@ static int clk_aic32x4_div_determine_rate(struct clk_hw *hw,
 	unsigned long divisor;
 
 	divisor = DIV_ROUND_UP(req->best_parent_rate, req->rate);
-	if (divisor > 128)
+	if (divisor > AIC32X4_DIV_MAX)
 		return -EINVAL;
 
 	req->rate = DIV_ROUND_UP(req->best_parent_rate, divisor);
@@ -343,12 +343,18 @@ static unsigned long clk_aic32x4_div_recalc_rate(struct clk_hw *hw,
 						unsigned long parent_rate)
 {
 	struct clk_aic32x4 *div = to_clk_aic32x4(hw);
-
 	unsigned int val;
+	int err;
+
+	err = regmap_read(div->regmap, div->reg, &val);
+	if (err)
+		return 0;
 
-	regmap_read(div->regmap, div->reg, &val);
+	val &= AIC32X4_DIV_MASK;
+	if (!val)
+		val = AIC32X4_DIV_MAX;
 
-	return DIV_ROUND_UP(parent_rate, val & AIC32X4_DIV_MASK);
+	return DIV_ROUND_UP(parent_rate, val);
 }
 
 static const struct clk_ops aic32x4_div_ops = {
diff --git a/sound/soc/codecs/tlv320aic32x4.h b/sound/soc/codecs/tlv320aic32x4.h
index e9fd2e55d6c3b..7a89ac4d5f574 100644
--- a/sound/soc/codecs/tlv320aic32x4.h
+++ b/sound/soc/codecs/tlv320aic32x4.h
@@ -223,8 +223,9 @@ int aic32x4_register_clocks(struct device *dev, const char *mclk_name);
 #define AIC32X4_REFPOWERUP_120MS	0x07
 
 /* Common mask and enable for all of the dividers */
-#define AIC32X4_DIVEN           BIT(7)
-#define AIC32X4_DIV_MASK        GENMASK(6, 0)
+#define AIC32X4_DIVEN			BIT(7)
+#define AIC32X4_DIV_MASK		GENMASK(6, 0)
+#define AIC32X4_DIV_MAX			128
 
 /* Clock Limits */
 #define AIC32X4_MAX_DOSR_FREQ		6200000
-- 
2.53.0

