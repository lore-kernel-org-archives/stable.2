Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC21948E0C1
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101277; cv=none; b=fkbqMBi9ah/Yh6LXeUGcOCdC4u06zfzBN4ibT6mXxuJAJLJfuTNhxF7N0yj/ZeovlcHUYC1EYkMR9iQ4Qu1XNAXNd02OluR85oKTyPuulKMtJN4vYDAQdenSlhWg1Xp3e5B9DuqaTrVF+3suiR/OPLvzbKEuHLv3QQUfsUumgTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101277; c=relaxed/simple;
	bh=30FON/ydJ6oUS3B9vlPnBIx363eOH3WPlJzyqM1zND0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLzX5YG5hTPgIfCpIlJyWbHpXyvTTeAONc4Gm0MzuTaYobSSAZfyIfSpwC7Io47VO2SU/A0PspulXHoMZDCqlX5UW1Jf566OIYLI4S07vNreRMzHSOgUg4z5WZ/XvjYR6iI/oq1sz7JErJuj3ByBVbc4316dmBJGekCshLI5CxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ba7Erx55; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba7Erx55"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BDA1F000FF;
	Tue, 22 Sep 2026 18:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101275;
	bh=OpJKSarrKBrDBb7r6I5pDw+E/OnUMF+9drQeXlp6sOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ba7Erx55IOCyyXgiUWfMFUvK1IaZI19fv/6SYrREiMxhudeEEiPfE0CzdnK0Y7l41
	 jpyGNXRkabwd6CDT5MaZijdnVDWSZvlFLLttW5EEYIgqjvPpFRYxFDuepJhpJ5xSox
	 ERMpFFg0NATFz6n5otfqyQBws5AnTFYZ6wOS0ahh+r2AchgOPRkwNjjrSPi3zVcLSE
	 9dCn6PZVl0Qg5aYUZcswuwWcDvBUY3YsPsIryNlw78RneilIN8eUffsW6KUKw+SasU
	 JB9zsNNUHVMFOmCpDBXA2IXPDxXPqKTz2kStctUKObP0MLo6XINSaI8TqVMnVOQX47
	 hSzbefBNYKv0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] watchdog: rtd119x: Use devm_clk_get_enabled() helper
Date: Tue, 22 Sep 2026 14:21:12 -0400
Message-ID: <20260922182113.3568867-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092230-thriving-ungraded-3c65@gregkh>
References: <2026092230-thriving-ungraded-3c65@gregkh>
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

