Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384372;
	b=1mo+jW2GPB3vzhmvqz0P8ZNZXriQLb4VSA1d90ex3iw4wmpfMiE0EQOAAx0m5aw6fHHL
	 RzDuLsZW0D5HbkHIQNOiFZZz9le6RQErq4yCDNQCTPjq0+hqzEy7jZKI/4tvamC2D7Zp0
	 8TgvITLunjaKc2p0HGQJDBrNQaF/x/ZFPlWP8s67+bb0CsR6fw5IzcytC0zV+/KtZgYCX
	 /+iPaODlBR58HtthKSe+2IyaBP6XlNkLv7ARNo9Lp9kFdnTSXDn15PLZa5mmfG0cTbYsW
	 cw90UAVTCaoPv64WI6sqKxG8Ho8aiCrE38MzzwousRIt8ylPrIkS+acFpitCkE4M5KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384372;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ocmGQIFYGduIXZym5HcD0FXkJSNA/R3xzQhgtuN0xD0=;
	b=ThQs2GfHPi63pYrNu6FowVX+SbE+Ae9ySjBiCjqe7wtX70zNXjt4ZZuSRHhcXBRFI2Vh
	 vQAwgAEs5zmzq+lTNwTQiSPopPJYSwwInPmgD3ZvvQzuq8wpJGuDjrSoW8bebLnNYyK2Z
	 Kt1COGRJMtR2kWe7NuUANsISk5a2vvSdimWxVp1F/J6/hsiREwcDHpVecTPsMZnIAJbmQ
	 rbhn940nfSwL3poc3ty3nCUyvcOHXBcl6cDZ7wG9zJJGNtl2Ox8vVw+GFgFCopYZ0997D
	 EWRRDFniHqRrSCRq8Vb2FbXl+GpBluBwVPeqAcKIIX1eBwCpbzF/jCWBuU8kpxL9vuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bsBXTgJK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12159606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bsBXTgJK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6447B1F00A0E;
	Wed, 11 Nov 2026 08:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794384371;
	bh=ocmGQIFYGduIXZym5HcD0FXkJSNA/R3xzQhgtuN0xD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bsBXTgJKvD4Br1gP0U9gqCEIaj1bi3YwkDGDurO8YLF0GCsjNwm610Nb//YYP8KCS
	 kpI3nwQv61yaCVPoJ7hvEpMmaEvVteWE1cvaft31SIf46/UsY/k1oq6VLidRbBr9TA
	 ENrgxT+j9CL+bj0gXS2oE76b5ii1B3WszgDuuNIa+urH0iYhKP5KCQuekdvfnJSNu8
	 UreONT8vlLntILlBu1yVsmse3wQCaSIryXG76mKaoxdEJdPMH2bAvoEIuWYGZmVRW+
	 OIuKmEWr2pbyGbpuW7mrW2V1ei8n7CFrSLMxE+wYlNFGoLsZ8KI3Cwb/AAbqIeHyGn
	 iTW3q1QG2hwPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guiting Shen <aarongt.shen@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] ASoC: tlv320aic32x4: Fix the divide by zero
Date: Wed, 11 Nov 2026 03:06:07 -0500
Message-ID: <20261111080414.1413480-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111080414.1413480-1-sashal@kernel.org>
References: <20261107062758-failed-5.10-8cf9607d2d85@kernel.org>
 <20261111080414.1413480-1-sashal@kernel.org>
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
index 7550122e9f8a9..8e7e4aec3ef31 100644
--- a/sound/soc/codecs/tlv320aic32x4.h
+++ b/sound/soc/codecs/tlv320aic32x4.h
@@ -213,8 +213,9 @@ int aic32x4_register_clocks(struct device *dev, const char *mclk_name);
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

