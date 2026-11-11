Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384065;
	b=kvXMIXilurzN5BXGd9+kmuCKzGYiJwwTKDbK1xL1ByRNjfZXlbXoP08gQzEK5+zktCDd
	 /PNwULuLjUUB9TcCfPDxdbsHab+svTL9QAPK6XP54Qpn7VLUTull+8HRysGzsxQg0VZp8
	 DtQ3l7wWsj29PEJ3VKiiesPEB6XIQJUmfEWOkccZf0QZyfzdcwdEVLkCuKCdkYb5LOTCQ
	 CG9DF+n5D4xpXyn58+eDLYMFUNCqwC5/ft1YJv3ZhmG64f9ux/ITf9rjBswuNMw0hDDRg
	 cw4DidSCwxk849dM8uPIH+Gjqf5eEqVcf6rAZ3dgpR3uwb7SNzAm8gu4fazrbyhEt2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384065;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6vuAFoFnpQs85Cz7CirKHqKfuLYtnlc1QpyvQGLwaCc=;
	b=FjHq7n85uqmFf+xLutyVGC30eIl8HyDGyMn9OoDshJFJGl6jNk/o2VzqchXWCK9lJTbT
	 J6yTNsGpixsC3W4PwvlFJ6ex7ioVJzxru9yPrHol8W308NFKsQleJEyNZnMooNi1ulMlH
	 wqZPIf74i19ZIFOV+wK3yGWra9stEft1n19Co+7k3wnkT0OSzHh91Txe5IJ8d6MKBjDLO
	 QyADWXi9ZKCwcmrLJhp61Q/RrSc+9yEvqi4b9hu6v9bDCFKJzbnmQL2jP0aghSWcSZJ2r
	 BaZJef8uQWhN98P94JKMuR/HsFGB2o2o6P33UtEmz+C1/JDVeolqU/22mQjknHDeZtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nuG2kd4+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FFF606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nuG2kd4+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D561F00A05;
	Wed, 11 Nov 2026 08:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794384065;
	bh=6vuAFoFnpQs85Cz7CirKHqKfuLYtnlc1QpyvQGLwaCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nuG2kd4+N+P1u15yBVBpRpIdYoPGbpGYB9N0/1poAzhAynLmuu9Iq9pS3bV6FRX77
	 yMHbK+DKvbfHAa/KCCeMmsgJZO/VDuCjW45HZSIniUvOqP7L4D5fZ/2IwJK1PRHxvf
	 /O4TKGgFgeboKt2SX10IDqO65zEY3zaFFrvK/ALn7rOyhxKEXkh9lVk/f8hB/VHrQz
	 z6BY3IbO/MW7/T+V8k3oy0pvHB/R7YEuppnBtI+YQvIog9vp3Pu6/mpe3EySAS8VAF
	 +5BxoW8ewo32UI5IX00b7JPEfbeI26dYIXrGMohljZzmQBT9LF1SC9Ug2hge43h8yt
	 wQ8GCz0/JF7lg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maxime Ripard <maxime@cerno.tech>,
	Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] ASoC: tlv320aic32x4: div: Switch to determine_rate
Date: Wed, 11 Nov 2026 03:01:00 -0500
Message-ID: <20261111080057.1408504-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061052-failed-5.15-8cf9607d2d85@kernel.org>
References: <20261107061052-failed-5.15-8cf9607d2d85@kernel.org>
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

From: Maxime Ripard <maxime@cerno.tech>

[ Upstream commit 2b6c9b0eee89379fda238d543c5acf098a2ac5a5 ]

The tlv320aic32x4 divider clocks implements a mux with a set_parent
hook, but doesn't provide a determine_rate implementation.

This is a bit odd, since set_parent() is there to, as its name implies,
change the parent of a clock. However, the most likely candidate to
trigger that parent change is a call to clk_set_rate(), with
determine_rate() figuring out which parent is the best suited for a
given rate.

The other trigger would be a call to clk_set_parent(), but it's far less
used, and it doesn't look like there's any obvious user for that clock.

So, the set_parent hook is effectively unused, possibly because of an
oversight. However, it could also be an explicit decision by the
original author to avoid any reparenting but through an explicit call to
clk_set_parent().

The driver does implement round_rate() though, which means that we can
change the rate of the clock, but we will never get to change the
parent.

However, It's hard to tell whether it's been done on purpose or not.

Since we'll start mandating a determine_rate() implementation, let's
convert the round_rate() implementation to a determine_rate(), which
will also make the current behavior explicit. And if it was an
oversight, the clock behaviour can be adjusted later on.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://lore.kernel.org/r/20221018-clk-range-checks-fixes-v4-67-971d5077e7d2@cerno.tech
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Stable-dep-of: 8cf9607d2d85 ("ASoC: tlv320aic32x4: Prevent division by zero in divider callbacks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4-clk.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-clk.c b/sound/soc/codecs/tlv320aic32x4-clk.c
index 2f78e6820c75a..96979243d3a6a 100644
--- a/sound/soc/codecs/tlv320aic32x4-clk.c
+++ b/sound/soc/codecs/tlv320aic32x4-clk.c
@@ -326,16 +326,17 @@ static int clk_aic32x4_div_set_rate(struct clk_hw *hw, unsigned long rate,
 				AIC32X4_DIV_MASK, divisor);
 }
 
-static long clk_aic32x4_div_round_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long *parent_rate)
+static int clk_aic32x4_div_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
 {
 	unsigned long divisor;
 
-	divisor = DIV_ROUND_UP(*parent_rate, rate);
+	divisor = DIV_ROUND_UP(req->best_parent_rate, req->rate);
 	if (divisor > 128)
 		return -EINVAL;
 
-	return DIV_ROUND_UP(*parent_rate, divisor);
+	req->rate = DIV_ROUND_UP(req->best_parent_rate, divisor);
+	return 0;
 }
 
 static unsigned long clk_aic32x4_div_recalc_rate(struct clk_hw *hw,
@@ -354,7 +355,7 @@ static const struct clk_ops aic32x4_div_ops = {
 	.prepare = clk_aic32x4_div_prepare,
 	.unprepare = clk_aic32x4_div_unprepare,
 	.set_rate = clk_aic32x4_div_set_rate,
-	.round_rate = clk_aic32x4_div_round_rate,
+	.determine_rate = clk_aic32x4_div_determine_rate,
 	.recalc_rate = clk_aic32x4_div_recalc_rate,
 };
 
@@ -382,7 +383,7 @@ static const struct clk_ops aic32x4_bdiv_ops = {
 	.set_parent = clk_aic32x4_bdiv_set_parent,
 	.get_parent = clk_aic32x4_bdiv_get_parent,
 	.set_rate = clk_aic32x4_div_set_rate,
-	.round_rate = clk_aic32x4_div_round_rate,
+	.determine_rate = clk_aic32x4_div_determine_rate,
 	.recalc_rate = clk_aic32x4_div_recalc_rate,
 };
 
-- 
2.53.0

