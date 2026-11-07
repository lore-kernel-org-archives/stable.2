Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049854;
	b=nUhC1wk+F9rrTgDoiFoEkatU2lRBEwLmBmWpAueo00Ug3Vo8LQqyfNB72V7ORR2C7jNZ
	 iUq3ODU6Zv8tjSgPHZxfdcCvaiajxhJPo6qA0kyGZy07WTwyronwEtzxFPpw2hplnid7u
	 l2Ikzh2te9YiZLfpotORE37PT4tBvZlbaEJfXDRZVjcv76GW74FWj5SKgdG5Pqs2RbN0h
	 d30EHQfKbnXMqVmMeeCgHH/qhNUrH8FmT4I42yWZrKLpaU2+3S5mxJ4804VnP9fCZIS1D
	 t4ovrYDPzZTaudKOk+fS1LkBuIeTSOZM/PjlODTVOm2CJCJyay8gCHUYOz8wNcGsA7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049854;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gs0zyDaq9JYEthyqoUx5R9tn0WAQw/aphy9K5WC6dGg=;
	b=JGFoNbPatDmPONXuxu7H821LznEb507QIpk19T+vq3AhkZd8zCk1h+/jwZTP7HwJBQym
	 2TvBetmHga8nuwooj8cnB6K85ksU0ATjfx/qgMWN1IRDnkw8rep7LnR/sLA7eyi6LYoCX
	 IozNBlVaNcgXVQ1A6QDVDIQiyxjX2T55sskf8wyxl/0uzDeUiJSTKgxjOjqUTi0Sq5Muu
	 +/DixnpDFvFwqMsbRvZLjVNyNCpPnQHL6WQoTWL2PYB0TYNdNVMZuuSGds7bKh50ceJ7d
	 LBTTpBbScp6LCev8jKN0lWCHWdSoLhBlQ38a+N5oAUcFBNohmdLTuZfXC0ToVZjK6kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kYHC8no1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F956606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kYHC8no1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4A91F0089F;
	Sat,  7 Nov 2026 11:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049854;
	bh=gs0zyDaq9JYEthyqoUx5R9tn0WAQw/aphy9K5WC6dGg=;
	h=From:To:Cc:Subject:Date;
	b=kYHC8no1cdtqo552yyeDFk7KRSciz5jpnqlwzvYPXsGeSttd0hQD578x1PcSKZK72
	 mcmIaNEqh7QDXoS9AaUhau6Jy58HVgGVq/RhIycAzqlodE7Y1OuQOwivPx2XLwYvl2
	 tj5bO6cIbi15ivAQV4+h0xGrGydHuOmazm1dj14C4p9MayMfDOM79hCHT0HmwP4Yfe
	 nNnHYFrQPTcuyjWl/0wSH0ZO4nHUviBxMVrlP+knuZ1qMKdFDncFQ7EDSf4cqBtkZG
	 a1leBbx36w8xp7AE0T1jHKCu5G/pT018LY5w1a5iNd93tIR1GfwEtKJ5RvsSSLAAqL
	 jlMwtbZcEkL+A==
From: Sasha Levin <sashal@kernel.org>
To: a.kazinsky@ideco.ru,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: tlv320aic32x4: Prevent division by zero in divider callbacks" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:10:52 -0500
Message-ID: <20261107061052-failed-5.15-8cf9607d2d85@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8cf9607d2d855629260fc78e6b54ea7a98525708
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061052-failed-5.15-8cf9607d2d85@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8cf9607d2d855629260fc78e6b54ea7a98525708 Mon Sep 17 00:00:00 2001
From: Alex Kazinsky <a.kazinsky@ideco.ru>
Date: Fri, 23 Oct 2026 17:08:52 +0400
Subject: [PATCH] ASoC: tlv320aic32x4: Prevent division by zero in divider
 callbacks

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
---
 sound/soc/codecs/tlv320aic32x4-clk.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-clk.c b/sound/soc/codecs/tlv320aic32x4-clk.c
index ad15ce9c60791..27d186c72315e 100644
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




