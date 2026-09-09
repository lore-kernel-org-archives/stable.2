Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2AC41A8F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980486; cv=none; b=VCncPk3qN/DsUOvi/yjh+S0al0t8xs/koDKPD7saqeBkwrGNcIzXTZr9ubDqPi8QMsXTj2ilbfGl/z9DTaGNRyelnMHmt+2IR5EcOgGy12QBsvfPXtwdBW8ZMKxvfSUmBjIsPhrY8HPDEG7DDYMYdJx103RwAzAZoq44tKsvpho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980486; c=relaxed/simple;
	bh=cNH1ahMNCjYsZqs+0X4zCW0mAttDul7xHLGIbrZ57LA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VT0mDwnXii9VDoz2GrjRPLoAOPvZS4KWluhgodRAvMu7IgAcJWbP+XjtyCwRaTOKd4a4k+ubiJSANKxvEs1WjTE9vjX3PUUV0erBzX6aISFSlKtiAiJxfq3T3w63ndJzXrh74KFdZe+qBXP7iz5t4zx8drVVRTNoOgjHJSSIR78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5guH8gk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5guH8gk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C801F00898;
	Wed,  9 Sep 2026 19:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980484;
	bh=OyEH2eN/d5fMg146P31WmEB7i0thwilUzrzra80Ur2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l5guH8gkc7WVwnJNUHwZYztsGfGE72F/DLP1LvTSB/Lx3ruatiDM9Kq4vydhjX89K
	 reKKYYfr2qecE0UzFp2vHO0gz+jBVgVzVRRNtWe0Qw6vHTnJQAsDqGek9ChKwPjLNe
	 eJFWn5ZE/WcH2c59SWPeAIts6apblyDwComel7mmXMHePK2kAzhM6p9ciEUGf3NV47
	 zOXkH+oU9cUF9zadycr13jWE3iROiKCdd/uK/nWyFUmmatH3cgc2+dhzX5shZQIugs
	 Bxspz0c9T+Q2KzjECFmYP/A2ninct/3qn/I/q3NjH1nMJWf0QZbOWyCNfz2ig7cCFD
	 KvfoSe59m7JbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] mfd: sm501: Convert to platform remove callback returning void
Date: Wed,  9 Sep 2026 15:01:20 -0400
Message-ID: <20260909190121.3510965-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909190121.3510965-1-sashal@kernel.org>
References: <2026090351-runway-afraid-7fc2@gregkh>
 <20260909190121.3510965-1-sashal@kernel.org>
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

