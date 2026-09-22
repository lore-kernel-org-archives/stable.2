Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E951A6838
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101865; cv=none; b=R8JMAc+WghW4L1PGPdcNqgZK9Pk+SEnNWlu+IdIq6ABV14/QioeClLSba2NSoEO6eFDtGwiJhbq/3SHfPUzSc9HImom6l0MZnfqT+ou38JiHy6f3rRRII099zfDXvvKDYrt52q/iMbw6a0txgXR8VjLHU8B5DOnqd+Jm+++fD08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101865; c=relaxed/simple;
	bh=30FON/ydJ6oUS3B9vlPnBIx363eOH3WPlJzyqM1zND0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4l2UdHEZJ320KpowImp3kKLX8zfz6XAnt40/2q3GYLtRF7xARp5IndQNOsoVIx82K1c1WqvDPX7JoNX/NaYN6Z5XVsHu8V6+yW6mCQdDML8s2ouhXHAJ5B6SVth+d+uajrGPyQV+I+idbB2Z0roVlSrm4Rla0C6VOXpFnOYxEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHnijX1c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHnijX1c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13EE1F00893;
	Tue, 22 Sep 2026 18:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101864;
	bh=OpJKSarrKBrDBb7r6I5pDw+E/OnUMF+9drQeXlp6sOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XHnijX1cBg8MZNGBCrWLMJtXW+gWgRaMIQZyTtAWWlmaKMvm8NBMi4F4+oeqbx1mp
	 GpIXj1XovC4mw70TimzXS/LNEcyNYYaBjSUbAEpK8JCFSyZwdR57J2DWce57SAd/Hg
	 mAy8p0W26Lbb/u6AdrkzLfqifwKP2pnEAa49FU9281rdA4iMpHqZMlueTiga6Ig5ZC
	 Aw5mTkKAGcyal+1bn2AlGE1+HWEAlEFKCTT7Klz9+/o7723VLiM+n4Nru1MYsPoO1r
	 BncyPF6IxW8ns11vnHxeWabOIKP9FoyWfbqZKxkkP24uUlFnXnxOGkZB+WjFy7WSJR
	 ADX4dL1jPbaiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] watchdog: rtd119x: Use devm_clk_get_enabled() helper
Date: Tue, 22 Sep 2026 14:31:01 -0400
Message-ID: <20260922183102.3660424-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092230-dipper-mute-1a50@gregkh>
References: <2026092230-dipper-mute-1a50@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 6cc0768ba6f5293a4435612164a2cfbf2edbd025 ]

The devm_clk_get_enabled() helper:
   - calls devm_clk_get()
   - calls clk_prepare_enable() and registers what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the need of a dedicated function used
with devm_add_action_or_reset().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/14b521b821279bc5111dc80b55d0936c5767c737.1672418470.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Stable-dep-of: 5af7d2cbd20f ("watchdog: rtd119x: Avoid division by zero")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/rtd119x_wdt.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/watchdog/rtd119x_wdt.c b/drivers/watchdog/rtd119x_wdt.c
index 834b94ff3f903..95c8d7abce42e 100644
--- a/drivers/watchdog/rtd119x_wdt.c
+++ b/drivers/watchdog/rtd119x_wdt.c
@@ -94,16 +94,10 @@ static const struct of_device_id rtd119x_wdt_dt_ids[] = {
 	 { }
 };
 
-static void rtd119x_clk_disable_unprepare(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
 static int rtd119x_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rtd119x_watchdog_device *data;
-	int ret;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -113,18 +107,10 @@ static int rtd119x_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
 
-	data->clk = devm_clk_get(dev, NULL);
+	data->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(data->clk))
 		return PTR_ERR(data->clk);
 
-	ret = clk_prepare_enable(data->clk);
-	if (ret)
-		return ret;
-	ret = devm_add_action_or_reset(dev, rtd119x_clk_disable_unprepare,
-				       data->clk);
-	if (ret)
-		return ret;
-
 	data->wdt_dev.info = &rtd119x_wdt_info;
 	data->wdt_dev.ops = &rtd119x_wdt_ops;
 	data->wdt_dev.timeout = 120;
-- 
2.53.0

