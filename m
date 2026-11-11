Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384372;
	b=FJX3vURodsciaf13kaEThbkPiyL6WBi1ywr8aLjYT6FmkKIpIp8TYG9kUtwOsPU4hKt4
	 r+e0hD5hCknyHwCpc95OAg59A0DfdRnJqBwiU1BRTKFaF5eov9SWSatkeneJuW/K9FBXR
	 16cyN4xE+16XlQrfC+e5aRWzJzgwdJPFw4oGvn6rGW7Qt6c5+47DsIn4l4GUTj1/MBIFO
	 kHKU9TCg7VEebjAi99Ogqb+fV8Yk13t6SG7wupgcJHpea8TFt34ppyfif1aiakoDUp28n
	 0SRSXA4SziHg892YHJVTl8R+IZtFMytkXzBAyoB8SEowr2YIeuhrbqxQnZZM8y9EI2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384372;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KOvBvh7XB+NPKfJDX19aJT1f93eJwnAtLRYHxrUv6UA=;
	b=fuD0BLAevkXR2btK6/QwQj2cZlYLnsDmXLEYSfdx5A/o9+O4X5vdvOChA4i2Mehy7KOD
	 Cyuk7DFUtew5b25eftkSUTPo/1/JS8s6SFvpArHxmncCAvL9YMadLAm296wwthj90P3uI
	 LtmUz/LXin03IAnQjapwnOMcie+smEE3OkpI4fwxw6741QZqQTSZ9m3YxWErwSgNI2K82
	 UnuLUUs8eUoYcV9cch8zayVSMOq2GDKRLrBqrx2on0Bz3B4FSEz+i3HW1nfwsDIyTzoZK
	 VTlVkVKNO3RsAeqTbsFnvspAxcTqxbB7pxdvvOe+du1Px9KtEB9zEd9eF//daiZvmTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J3hiQ0JG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD610606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J3hiQ0JG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0D91F00A05;
	Wed, 11 Nov 2026 08:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794384372;
	bh=KOvBvh7XB+NPKfJDX19aJT1f93eJwnAtLRYHxrUv6UA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J3hiQ0JGFvukWXFNh4Gz3GJi7MDmXi4aCDlkIAK9sjxZqqgqsWa0ATOD7n6b6ayLO
	 HXF9NJR56GfJ7pEgp9dBqd8NhdbVbmvelMGkIXRjE0bFvBvyKCP4082xPXrROPxtYy
	 ++vLMozPYtsB0gN9dpA2lGZ83Hu4+bK3Tp5OOr17MDMBpRanOE72jLLXjcyS5Gp5KA
	 paM1pYzi3NZoGfyTkCvrbioGDSi82+Vg9g3TMnzZnMxG4L0hV+etDyv4xp+msDfYp3
	 TMvNLjreH7E4kvXPYRjXp2G9UgTdQZ4FHJMvAWOhNMG9ql+I4RZodrsgqED0wpRTFQ
	 ndncMQR8WwFRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Kazinsky <a.kazinsky@ideco.ru>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] ASoC: tlv320aic32x4: Prevent division by zero in divider callbacks
Date: Wed, 11 Nov 2026 03:06:08 -0500
Message-ID: <20261111080414.1413480-3-sashal@kernel.org>
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

