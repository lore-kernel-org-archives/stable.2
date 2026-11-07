Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049044;
	b=z/M5AnHxhFtskp+OoPUmnn+WMANrE7QezI15dzTn6NjnH3UQ4NfLuMxl2xilklekmpRA
	 FztE8IJGVB4PsuVN12P+qbcwOmySyagxd1MbAUBhk86CdKzvQ8456RwnfCfDdbDbZzx/V
	 fNIo/sKpoh6Nq0b23eYCa3u0TeqweeVn0kcBSGTEF2/p7Av57TC6IuNEBbClHT1BlS58o
	 3pquoYRDAXABTsqvfNM7uVP6ZdfOCWWSxXN9Qh3udBZbIP4FeY46IR22G7eIaLzdpUAGs
	 gi63dj5b/IoTExH95LdblozcqqjOQbUiph/jXnT1WSUktyy9UDHnMhMEugTQZNkQIgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049044;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XpTilb67vTFu3kW/X49Sw/PsJm4D2EkRNiIiKiodUVk=;
	b=mdsYFzeAQMcONoRgAN8mokdY8nOen24ys2K1MfhlzFEKtwH+2c5FJOJ9LB4U4mvO9x0e
	 wCZ16eXje09oVFo7ShzNea30bi2BmkmPK3MSzwQA4xyNqWeanK0yUT+VBANJSSsbqeCb7
	 p0tQJZT9xnBo7EE7ou2b5BGf+0IvU9bMjW+KFO5ikb8Rl9c9PWKbAGoTRlN3O+Rq+DTDX
	 dRtQPKwJOG7JCnkOiz83F2AaHbcGiN2ybfx5DtofaKSuNWuVn+JRY6tT5FWDldz6iEjG/
	 fB/qOrSAn3lemj3fZtAjjJuuMpEE9wMbtg/G+jnHPFIYMt828+t/HjOwz28ui5lBt5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KK7CCdqi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE22F606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KK7CCdqi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9DA1F0089F;
	Sat,  7 Nov 2026 10:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049043;
	bh=XpTilb67vTFu3kW/X49Sw/PsJm4D2EkRNiIiKiodUVk=;
	h=From:To:Cc:Subject:Date;
	b=KK7CCdqi80SGxRn4hP43jmdcsHgX8IXiaaGC8N4GtTwfTbNT0Mic4RJBwrCYgxfqt
	 AQj8N3RCv8q2ZWzPwTNIvJEpn+CDbg6J0BwLjOxPer2ZwhpRe9PwXzz8eu6ed15HE/
	 FNQaGfVe9qMvb3yLKLpKaJVnds8mKjo5N/G2fDTilAezLVWVskbNU5OU7Nl1VAIuJ/
	 lBmu3FwUHrocHDPAcIRlsBIgSzaUA2nX2Xvd6l3oFITuSlOIPLS7m0qpd/WFqDzaca
	 1npQY6IOQLrTkqKFOW5NYAwbc8l5UyOjyU1hdM48baX99e7mpouaB3eXoLGdupBqDU
	 GXjdNxY0IL3ww==
From: Sasha Levin <sashal@kernel.org>
To: sean@mess.org,
	martin.blumenstingl@googlemail.com,
	neil.armstrong@linaro.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: meson-ir-tx: Ensure probe error is propagated" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:57:22 -0500
Message-ID: <20261107055721-failed-5.15-2eb8a4cba70f@kernel.org>
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
git cherry-pick -x 2eb8a4cba70f521a8217021e227cfa28ba17724b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055721-failed-5.15-2eb8a4cba70f@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 2eb8a4cba70f521a8217021e227cfa28ba17724b Mon Sep 17 00:00:00 2001
From: Sean Young <sean@mess.org>
Date: Mon, 13 Jul 2026 13:52:43 +0100
Subject: [PATCH] media: meson-ir-tx: Ensure probe error is propagated

devm_clk_get_enabled() may return -EPROBE_DEFER which needs to be
propagated else the probe will not be deferred, it will fail instead.

Fixes: 49be1c78d575 ("media: rc: introduce Meson IR TX driver")
Signed-off-by: Sean Young <sean@mess.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Cc: stable@vger.kernel.org
Reviewed-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/rc/meson-ir-tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/meson-ir-tx.c b/drivers/media/rc/meson-ir-tx.c
index e8e3c1a303279..1ab898069e67f 100644
--- a/drivers/media/rc/meson-ir-tx.c
+++ b/drivers/media/rc/meson-ir-tx.c
@@ -292,7 +292,7 @@ static int meson_irtx_mod_clock_probe(struct meson_irtx *ir,
 
 	clock = devm_clk_get_enabled(ir->dev, "xtal");
 	if (IS_ERR(clock))
-		return -ENODEV;
+		return PTR_ERR(clock);
 
 	ir->clk_rate = clk_get_rate(clock) / 3;
 
@@ -325,7 +325,7 @@ static int meson_irtx_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return -ENODEV;
+		return irq;
 
 	ir->dev = dev;
 	ir->carrier = MIRTX_DEFAULT_CARRIER;
-- 
2.53.0




