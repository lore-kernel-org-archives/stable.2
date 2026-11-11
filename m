Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794383852;
	b=AeLoDAyUHLjy1ce0uvCz+CoCHxAEL/IszKEQ1m+lR6hGjTtPntXPW0Y4DW+49t5ln0Ny
	 +BRwoTCF33BMWdB4adn9TeR8RgQ4l2PIPH3W/OvkL6jlD7FFK5/jVfbd1rGDNxCtMBS1a
	 pTp+1gP0/i7DUHG7IsWYfNGxPtMZpZ6YOR5W4l22q3DzEQn5FuncwK/Cr/FGa0DDKglkY
	 8h/saHWxsTP7w/bLMZYwkCQIcbQX2Y+UOdsxCre/mxV8Jq35GoBNQ8MlXWN+g93zN1zlZ
	 AVOSmZS4yaVas29xfxihmg5BxXlrlI0hw/i3y6ODDqsWtMB9INK8nNuPu0eKXsDwADg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794383852;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VE9+GZh1XNf+DsQKsbdsXQd5yEqOvbkN15m9L53IdV8=;
	b=w1mDsz5cTz07O2PVrQGZQT8bPoUCAPBNmWxsOSDtFgX1uk/2cWrrkBXHdJAL1JMDhN3N
	 LOaZoSsUOgUhTNJB9+XrfJJF5REZNB+T6HY24ZsAxZ3oVfCfdzzb9oSr7yTnnLYR06uIn
	 3hspRygCzXWWW3CVXPVTw6SVAuNsWYmwjv6Yv59u4uTVAXDkrBiUPvt1juwRVCbZcV4yz
	 AKeB66X1NZuZxNCuk3e6aHgcL//tzZI5ZdGNiWpjqrLqFkPs1zEGkJ+8Eje92gxmreRbJ
	 EzfPwwd1Hhyp1VR3imt/sI0Z26eieoiybB2mvN1ZUKc35ZbKdVxjt3hWtPbyMLOS0Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PgcnYz5R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B179A606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PgcnYz5R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166121F00A06;
	Wed, 11 Nov 2026 07:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794383852;
	bh=VE9+GZh1XNf+DsQKsbdsXQd5yEqOvbkN15m9L53IdV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PgcnYz5RR6TBWxn8V484GZiVKp2Hi82q3ZBXvRBb/rVQaWnuWNpflTNxHcX5y85Jd
	 12dJn0iCFQoLMLf3CeYyrrtGpUI858dbVwFHK3TwYfr9aPjxJKtipZA4eZ6T7k6UAh
	 qULczHe/dLMIygOaU2dtAmiBK84Sqb4MWzihmTlwLiC6VePu66EcIeAU+WgjkbRixX
	 Icj7tH54xmjTN+xtFoRbht+A2z6w41IhnaUXnrVggOz8ZKya+xuJi8GDGt2ZkQhrx6
	 4u4xrDBl1yUws5qrdtvaIsunFhYv0+l8qLfe0b1jACtsrMqflVpNTMfGMb561zEcEJ
	 Eg+GWGJW6FEtg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guiting Shen <aarongt.shen@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] ASoC: tlv320aic32x4: Fix the divide by zero
Date: Wed, 11 Nov 2026 02:57:28 -0500
Message-ID: <20261111075524.1400365-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111075524.1400365-1-sashal@kernel.org>
References: <20261107055343-failed-6.1-8cf9607d2d85@kernel.org>
 <20261111075524.1400365-1-sashal@kernel.org>
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
index 4de5bd9e8cc5f..d6101ce73f80d 100644
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

