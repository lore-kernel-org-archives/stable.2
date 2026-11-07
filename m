Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048826;
	b=2xruogywwEhbPiUlzPkxpUvGQOuvBAwjm0vFF1RUASFgoqxNCi0PYPvDlRiW3PwRU9/N
	 UKdUTTKP2ewq/R5SGdQWG7hpCS5uzEQp93xGJM3lR+QHCGwrASrsEk3ilH1zrxUx7qXxB
	 5U4FEsd7mgMg+M2+FeMxTYdKRMn7BUmlecl4QGqoAOjqmNoqFK4xEIhrsB0iZLN0BhoKJ
	 M/ri8yH1XL2si8Kdi9Ml+imh4Vn9ARJpLX12IvbchcI5Y5Uw9rJw7u+lgYbFb21GrmnQv
	 8bJQTJy+JlZdR8EyTD08932I5BVR0vKU8WH87qjwjS9FDv4Nvkd/nVMcJevuJSsSq3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048826;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=m1BjkXgxHsIY/UG9LI9O0ot6vzKJcpNYxLpSRQcRdDg=;
	b=q9a4TPrj+H6bz1u3ml9OBAxuewUrc6YfDUmn1wSg+fj/dz5x7S9wpPH2qmLQ/v5IS/2q
	 +pXTq4eOOts9/wz3OOZOGQqAn6LW0ozx+OGWvXk8Y8yq/IxXUPaq+DluIWsK7fw7zl/s3
	 7z4ENQO3X1ITkGMREVGlbLiewInkpMJ2M5fuNhqcn9osn8PeqawwekjrrmZKu1PF5pivO
	 RFBM2qBdnhKWnjGyvfKe9tl1zBrjKiAhShZXM4CQSyAdZiZ8d27V5OtugwTFul/jabBk+
	 VYuFy5JB30IQfVm5/ssolhwd5irfNR95CQWF5iUISA0+nYI6myRfzo/nb4VCuEg8gQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZyt4iP4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4E1606A337
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZyt4iP4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A431F008A1;
	Sat,  7 Nov 2026 10:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048825;
	bh=m1BjkXgxHsIY/UG9LI9O0ot6vzKJcpNYxLpSRQcRdDg=;
	h=From:To:Cc:Subject:Date;
	b=JZyt4iP4KZjvCjA7GVrIJyvcYmM4EEd63hqi9N2px8mwIIq2O4SI1dDgTw8ohwytz
	 vAgBKRaLE20vZ1QuglfWZ2BaJbDBH7SNWLnbHdPAXMvEmM9bLkidyi1mi1sMl4QRiE
	 MEELGxrF8redsiJ5xHvFiY2heaA7/19YwkI2q35eOhs3UxEJbL2TCuwo1RSlnGd0aV
	 6P1X4RYi5yqpolfpwuJZE1rLNfflzQE6ALeLXnYkDBMUsmVupfU5O/+EvM/CYbRmoA
	 OQVilcNGR4Mr10D18XjSgndE0daDboi17gzoveIxhTGD+bU5/KEL09qNeT/jpBOzUE
	 4l4sV73FzcR0g==
From: Sasha Levin <sashal@kernel.org>
To: a.kazinsky@ideco.ru,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: tlv320aic32x4: Prevent division by zero in divider callbacks" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:53:44 -0500
Message-ID: <20261107055343-failed-6.1-8cf9607d2d85@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8cf9607d2d855629260fc78e6b54ea7a98525708
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055343-failed-6.1-8cf9607d2d85@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




