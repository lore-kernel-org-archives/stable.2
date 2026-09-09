Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18760489897
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951550; cv=none; b=ZsyulL7KgvUmwFNGS1oUA0Dps33RC9kjzFv+COsMG0sXZ9XSG8JK2Yd6cn7EotkC6b+dKJGjdvPf/wv52ISkSHjLmW2sz7tfd66kFBFzmWsDtazdUaG5Hhg8cBQTX3LOkmt8CMyX9scYc16bYcWoKO6PelwRSEODvSjEESYdJjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951550; c=relaxed/simple;
	bh=9eN0MKujh7RQmCRvvalKmyEVEHqK6zGNfEOEdMy7VYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nhiYzkAwehodjCUI7InF/3z1E7eQDjLejNNyDaTgjmpO6iOg3gQZ+SfV9BwKIZJAVG73EI6KE5R0BjYiSOD8BmD5EQF0UkRgGWLuPsHM1pFLzxdxUCNo+lVuPFnz0hUmOsMcmLjISAWASZFyG09JL6R37Giu72Qb6uBMphwwa9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmXAzFzI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmXAzFzI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0BD1F00A3F;
	Wed,  9 Sep 2026 10:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951545;
	bh=z6JagPZpzVrHA7qtGdkAmFyfRdPg8qvcE97bbmAAypU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nmXAzFzIRcP1rIYUMPImdJtPjVTSMYyZnWSBsN9NxwNHXK+ykT2zf9P9ULML/SMyW
	 POS2cUm7/S0JX3mMjZUtTa85kNMoOwio2TUWb6fBbSetcmPRqyR/3s59Fk1uXb7W1b
	 jPha1CBSXLHCrvHNbIehsR3LrAUCUlyZmCejRDFjp11bK+gNLhbfkuGA4mNGhL11RX
	 blLN846l5prgYA5h5HOqsyRIVtuLVhxyhSm6+20Hxwre3kplQd+2l3PRpgWLD0/hRo
	 ZhpuC24RODNs7MfC1cgkCmHhvMT9P760TGJi5BIMt3M1dk0pJDAqKrz35prG8Kfjca
	 wdWnwrCn/Q7Ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] power: supply: lp8788-charger: Convert to platform remove callback returning void
Date: Wed,  9 Sep 2026 06:59:01 -0400
Message-ID: <20260909105903.1646806-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090352-shoptalk-president-e8c6@gregkh>
References: <2026090352-shoptalk-president-e8c6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 7810ba3c5110ce66652ec6bd2abb92da5d726c3b ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.
To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() is renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20230918133700.1254499-17-u.kleine-koenig@pengutronix.de
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: 831c29a12d56 ("power: supply: lp8788-charger: fix use-after-free on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/lp8788-charger.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
index 56c57529c2287..3cf8cec8cca6b 100644
--- a/drivers/power/supply/lp8788-charger.c
+++ b/drivers/power/supply/lp8788-charger.c
@@ -715,20 +715,18 @@ static int lp8788_charger_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int lp8788_charger_remove(struct platform_device *pdev)
+static void lp8788_charger_remove(struct platform_device *pdev)
 {
 	struct lp8788_charger *pchg = platform_get_drvdata(pdev);
 
 	flush_work(&pchg->charger_work);
 	lp8788_irq_unregister(pdev, pchg);
 	lp8788_psy_unregister(pchg);
-
-	return 0;
 }
 
 static struct platform_driver lp8788_charger_driver = {
 	.probe = lp8788_charger_probe,
-	.remove = lp8788_charger_remove,
+	.remove_new = lp8788_charger_remove,
 	.driver = {
 		.name = LP8788_DEV_CHARGER,
 	},
-- 
2.53.0

