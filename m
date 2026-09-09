Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AF4560ADE
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980128; cv=none; b=NPHfuQBibJUtmgHiJ0WXP6Maaq7xXW+0EnlPmsBedmtcysTeGfMn6JyYHa8KoO+aCQuLkBxbYrJ6fHbKmo0RDAxVupJYOrGXmL9KtjuRy3ghVrfwK/5OCMEh0poYZfect7bI7KFCyPsBSr+xBytUeWfVVSoIE7qPaBmSEBaL/R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980128; c=relaxed/simple;
	bh=cNH1ahMNCjYsZqs+0X4zCW0mAttDul7xHLGIbrZ57LA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ywc3RPUiPyTqYlIPbneZn59u/EUrelsZc0B8U3YunJXGcwt2bmdLmo5Ro8dWTrdU4t+EclLIec5pktADx/0uHm3+UwDrgUerC/YHN9gyFXTSV2LYndb2s7xNg2ajyhmftLpx2ljAx3OUj+X+gVe0X6T3Tj8naz26u0Smo0rEhoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlrWe228; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlrWe228"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C701F000FF;
	Wed,  9 Sep 2026 18:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980122;
	bh=OyEH2eN/d5fMg146P31WmEB7i0thwilUzrzra80Ur2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WlrWe228AtfxXSb6GLoogaN5UeJ8T8xQsNfZJnOJx/KzTGJyERkcvS82SrHjRpyS4
	 3WSUUsxQOauZFReHYu31G6pL4GoB4XqzPuWE+AjX2rfkiTbaxxfsSa9dt9kwawRXZr
	 0SQyoz5jTKO9Fo77bcLDDA2YlgUqqmW3VE7cmrUZI4DwV43TTmnR2SIqpgVfeffYE4
	 7Q17GfCF3f+vvnLx7kS5sZmf5mbc0mRGZ+IMHDjrNpiALv8UZgRsI1oT5u12ADxlce
	 jhhj79iJiGHVgAWaD/V/jlIuc3vJ5cuiwe1jGjv55qbP2U93CjazqZGf55XMA0CZem
	 sSqeVr4kSb64Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] mfd: sm501: Convert to platform remove callback returning void
Date: Wed,  9 Sep 2026 14:55:19 -0400
Message-ID: <20260909185520.3489928-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090351-moistness-unmoral-5211@gregkh>
References: <2026090351-moistness-unmoral-5211@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit c20fddf7acfb54d856c34208926701d32c25eb18 ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20231123165627.492259-15-u.kleine-koenig@pengutronix.de
Signed-off-by: Lee Jones <lee@kernel.org>
Stable-dep-of: 83feedd9d83c ("mfd: sm501: Fix potential memory leaks during remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/sm501.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 1865621d62f27..06e796883189e 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1669,7 +1669,7 @@ static void sm501_pci_remove(struct pci_dev *dev)
 	pci_disable_device(dev);
 }
 
-static int sm501_plat_remove(struct platform_device *dev)
+static void sm501_plat_remove(struct platform_device *dev)
 {
 	struct sm501_devdata *sm = platform_get_drvdata(dev);
 
@@ -1677,8 +1677,6 @@ static int sm501_plat_remove(struct platform_device *dev)
 	iounmap(sm->regs);
 
 	release_mem_region(sm->io_res->start, 0x100);
-
-	return 0;
 }
 
 static const struct pci_device_id sm501_pci_tbl[] = {
@@ -1709,7 +1707,7 @@ static struct platform_driver sm501_plat_driver = {
 		.of_match_table = of_sm501_match_tbl,
 	},
 	.probe		= sm501_plat_probe,
-	.remove		= sm501_plat_remove,
+	.remove_new	= sm501_plat_remove,
 	.suspend	= pm_sleep_ptr(sm501_plat_suspend),
 	.resume		= pm_sleep_ptr(sm501_plat_resume),
 };
-- 
2.53.0

