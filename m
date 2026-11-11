Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384066;
	b=EESOPFqOgv3hy+hJj95V5S0++k+6lFGeQcZbFuMw9auinvPubWMM0SwydpYO+/awK/5+
	 4HZZ6xjeNytl01qG9F9XVg/34elhP/g1VtgIpJliCZ89tvjmSyPfGBMbBsRCsJR9IysBW
	 IykszmmIGb2BYqpesLpeqXwo6za+Q9tSGwSUrQFOYzL6wxP30imFJgQn8PVxpHLvr+ozG
	 8A/YogJM0RjTR7ZV1f78m5k2MVVg9ArvaYEl+DGbM+jcDnIBKfCJbJ7GjccyShSFNmo+V
	 x1bPOoaqPYCNIHTiknAQTvcpIfJW8kqaLCxajSqAQ6tHNhvTxVf2KehdmTbfO8DomEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384066;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KOvBvh7XB+NPKfJDX19aJT1f93eJwnAtLRYHxrUv6UA=;
	b=41a0++dTIX/p5kktuafzxufsZepMyEq3N8VxQe5DkVj7uWdBIm6ZleF7KWIMvwtDXk1L
	 NS6nn5PURIgrSJz4y79gwP6ynLxNnpyPpjKfWMbqOVqo2Fz+/kEruV1Dj4DepMeu8J7hA
	 0xEV2lMRssKODgAucpC7rmvhZ9k1sn9VzhnmtA8XTW2drUUEAybcHsYlT0Ku+HcpREi6Z
	 01lYe+sYgcClHcLp+kA9z1lyViSArrq0ZcLdBaTcZDOi6XFShq2U7HQeIxrSe+SiXdfVq
	 n5X3ep263PbH7hAFKKNfkwWEFe2Bnkm4wqQUIBgFe6OeDIwQAcCnjRQZ8FO7G1mbHyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8hAu3ny;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DBE606A331
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8hAu3ny
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248651F00A05;
	Wed, 11 Nov 2026 08:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794384066;
	bh=KOvBvh7XB+NPKfJDX19aJT1f93eJwnAtLRYHxrUv6UA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z8hAu3nyYbu4vHM9EcrF8fR6XGbbKZH8F+EWfpfbb5rqx+FcaSILbXTJ1prFk3nmC
	 eLNzxT97AXJqiPwiTNj4ZFOmG2ETdvQ7448DNwQhE4auwpTih2mdfvS7r1T+AkoO9v
	 xsCK+1jDU8zs3QV9OFHC89j1bI8f3oKJ6NDvEmVjfyBobylVp62dtNVWc7Y0WwPd1b
	 fkF5aZ/TtENSj221OEIKpDbG+T+ZBueh6hEMDgg3qY5btkg+7fGcHBp4Fn6bwZV69G
	 iBCO4vGy5e0Z46B/g6EbtjavxJatdFhZEoWY7JIA2tT3Lh1iIbXPrtVMa6IvpD+u+t
	 XalY/edOVEVYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Kazinsky <a.kazinsky@ideco.ru>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] ASoC: tlv320aic32x4: Prevent division by zero in divider callbacks
Date: Wed, 11 Nov 2026 03:01:02 -0500
Message-ID: <20261111080057.1408504-3-sashal@kernel.org>
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

From: Alex Kazinsky <a.kazinsky@ideco.ru>

[ Upstream commit 8cf9607d2d855629260fc78e6b54ea7a98525708 ]

A zero rate requested through clk_set_rate() or clk_round_rate() reaches
clk_aic32x4_div_determine_rate() when the minimum rate is zero. Clamping
the requested rate to the allowed range leaves it unchanged, causing
division by zero when calculating the divisor.

A zero parent rate can also cause division by zero in determine_rate().
For example, if reading a parent divider's register fails,
clk_aic32x4_div_recalc_rate() returns zero, which the clock framework
caches as the parent's rate. A subsequent rate request for a child
divider receives this value in best_parent_rate. With a nonzero requested
rate, the calculated divisor is zero. It passes the existing upper-bound
check and causes division by zero in the resulting rate calculation.

The set_rate callback can receive a zero rate when an ancestor's rate
changes. clk_calc_subtree() calculates descendant rates through
recalc_rate() without calling their determine_rate callbacks. If reading
a descendant divider's register fails, clk_aic32x4_div_recalc_rate()
returns zero. This becomes the descendant's new_rate, which
clk_change_rate() passes to clk_aic32x4_div_set_rate(), causing division
by zero.

Reject zero rates in both callbacks and reject a zero divisor in
clk_aic32x4_div_determine_rate().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: a51b50062091 ("ASoC: tlv320aic32x4: Model DAC/ADC dividers in CCF")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Kazinsky <a.kazinsky@ideco.ru>
Link: https://patch.msgid.link/20261023130854.93639-1-a.kazinsky@ideco.ru
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4-clk.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-clk.c b/sound/soc/codecs/tlv320aic32x4-clk.c
index 4ade06e5f5cd3..c8ba32b810af9 100644
--- a/sound/soc/codecs/tlv320aic32x4-clk.c
+++ b/sound/soc/codecs/tlv320aic32x4-clk.c
@@ -318,6 +318,9 @@ static int clk_aic32x4_div_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_aic32x4 *div = to_clk_aic32x4(hw);
 	u8 divisor;
 
+	if (!rate)
+		return -EINVAL;
+
 	divisor = DIV_ROUND_UP(parent_rate, rate);
 	if (divisor > AIC32X4_DIV_MAX)
 		return -EINVAL;
@@ -331,8 +334,11 @@ static int clk_aic32x4_div_determine_rate(struct clk_hw *hw,
 {
 	unsigned long divisor;
 
+	if (!req->rate)
+		return -EINVAL;
+
 	divisor = DIV_ROUND_UP(req->best_parent_rate, req->rate);
-	if (divisor > AIC32X4_DIV_MAX)
+	if (!divisor || divisor > AIC32X4_DIV_MAX)
 		return -EINVAL;
 
 	req->rate = DIV_ROUND_UP(req->best_parent_rate, divisor);
-- 
2.53.0

