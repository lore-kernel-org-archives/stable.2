Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.56.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761046;
	b=ZVOuyAS8RPjG88tKyLXCImexro6+vAT3vs2TTfQFoOl8Q8P7yEhS/u3LZ27A75IjxuoZ
	 WP3a5MbEvnnUUqfyaJyfrKxa+EeRI+QG7DOw4hUNSqEqZKb0+lzPBs/ILezkC/Dii8mHw
	 FZOLME2FnqruGy1APCatHkaz5UNSBxQ/38KxxJ5Ehm0RBQqDsR5vC7R3Cy2v3UP+T6GeK
	 eGvmC4Q60GofNMqEZ4cLFFzjOamUHQxHgVfyDBp0qjgKfnk3QZKgb+nMyMSLooNHA+/16
	 WxQ1Dg4waM38AGOshv8NfjXWXUZL81qWdfZHvtHi9PqAKIhb7BZ44dI/9UwWzZPW9Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761046;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=59Qyk3aglIjIhg/npMzy4QhrcqLa7AMEvlddf8zJtOQ=;
	b=lPpY3qXKY/AkG57tYoCa9d5CFKiGQALtGHOPVjZb+PvSblZ7hqBF87s0o7U6KG++eC6v
	 xj0wS2xqh9vLjSBEWARtEcXjVvRvKJOyvqLualOLrMcwhlR0yqv2M3wS+FE3jHafWozlO
	 4YcEARicI/lehLDYbnJtou3UmBDWfT3DqOB8CGf+ZlYKqykKlECt3MIbkxm71aJT6DO/k
	 ftpT+X2zO2u7+s0OuZROgiqLrBbryZT4yqrYqxmmhqqRVDfmlHWWGLqtTXuzIzIMaSrEc
	 kFRABvPCPwE0w6DSRMuta2bcJ38HmdXjaxBS/dIECoK4RqBBFGYRrCVPbzhTk3eitPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideco.ru;
	spf=pass smtp.mailfrom=ideco.ru;
	dkim=pass header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=TFqeyXW9;
	arc=none smtp.remote-ip=51.250.56.165
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99B5606A31A;
	Fri, 23 Oct 2026 13:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A99B5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideco.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideco.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=TFqeyXW9
Received: from [169.254.254.254] (localhost [127.0.0.1])
	by smtp.ideco.ru (Postfix) with ESMTP id 4BE75231AA;
	Fri, 23 Oct 2026 18:10:35 +0500 (+05)
Received: from fedora (5cfcac1b.dynamic.mv.ru [92.252.172.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.ideco.ru (Postfix) with ESMTPSA id E169B18A2E;
	Fri, 23 Oct 2026 18:09:52 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru E169B18A2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
	t=1792761031; bh=59Qyk3aglIjIhg/npMzy4QhrcqLa7AMEvlddf8zJtOQ=;
	h=From:To:Cc:Subject:Date;
	b=TFqeyXW9dHZ6eOKDKaD4Qj1nIiBzdz+sfOVgSyA+ANKcWOWCfF7obxsYLWhQEYXLl
	 Q6YLaYL9NiV6VNUyyGlmHyEU4eM62iR5ieWIDCVutEE4VhJpST/sqUiCXXV1jowwfo
	 WtaBPbclnURf46sMZ2f40beC75zuU2+cAyBRalbwL5WPlLx2QTRAQnl4EiRjEtqtfT
	 BT3CH5BYI8SiTrPzz17dhIwM1glr7GNCZmUUIiHlx48m4+326Rg7YZnVAtoGToPwhp
	 H9W0XgrY/1U0GpLG55z2P6K0BF4HSxD45HsaylLkWUyIBkpAsaWdROq6dghRct7LY4
	 jJ6AWtF2i+JPQ==
From: Alex Kazinsky <a.kazinsky@ideco.ru>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: Alex Kazinsky <a.kazinsky@ideco.ru>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Sen Wang <sen@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Annaliese McDermond <nh6z@nh6z.net>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: tlv320aic32x4: Prevent division by zero in divider callbacks
Date: Fri, 23 Oct 2026 17:08:52 +0400
Message-ID: <20261023130854.93639-1-a.kazinsky@ideco.ru>
X-Mailer: git-send-email 2.56.0
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
---
 sound/soc/codecs/tlv320aic32x4-clk.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-clk.c b/sound/soc/codecs/tlv320aic32x4-clk.c
index deed61650e09..8fa8e69f1f72 100644
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
2.56.0


