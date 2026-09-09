Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6017367285
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974077; cv=none; b=tPr5tQANMCwK1KPj50Gl2X186Mq4CBSZVX5N9gPFP7d6U/w2hOA4Q9tYGa/OQGEOgSmmczlftrpv9C/F4fqAj3k5YdDAWJZgCsIUs9aK6VTGj8z3L6u+oVFBlZ5AF5r6ICp7kCGD88WE7861qZsZt9zd8ZtWxgO5+zo5noqJwno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974077; c=relaxed/simple;
	bh=nnbV7BVuxqGMPUvJevFn6yVm/kM/6VK6424zcPRf2RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBfgycwNBLTMSgTL6iTNUbrGl9oI1uApxRym2sV6gam6kl7H5Xu9wNsh4VepWu3tozR9lZQih0D8q2d+/VDxfeE3lhMeC4+AOltwSHG57GNjMFgTDfn3BCE4JOs786pTdWnbeXwwEz+rPVt8HNjqGMZhxfMkCYiNmzqVUsTsPf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwZ2qyNB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwZ2qyNB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FCC1F00898;
	Wed,  9 Sep 2026 17:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788974074;
	bh=CLlBbnAcZjtyPJOYjrP49EURdAydYJfj12HI4pLppoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gwZ2qyNBAsuz1b/eRVlPbDC0vxbvCqlaGwHLfqf5BflQr8zhlm41+tsFvR00UgYTS
	 xImswIpR8O9+yzVRANenyqImq3oUdd2mFdx/EOxnw/DixhtH6lSMCg6aIFt3Pn3WnI
	 6P5P9aHHtzJ5z0cpNJbxEvbxebdLomhMzS8sQT3A4MC/rHF2IfhUhlvm2KxNBLpEEZ
	 e7BouE16/O0p8wPiKE5n6Ogjoz+/xHur+8aBgbOmk8ftnsQtouTOFSP8j1UTtdMlR2
	 rzXTKmzYB9+5uc3GEGebqvwZdPDVc7urLAIoGF5G2y5zkxmNnQEl2xQZMkF+m9V4/w
	 k2tVbF60DdZig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/7] net: ravb: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and pm_ptr()
Date: Wed,  9 Sep 2026 13:14:25 -0400
Message-ID: <20260909171431.3234845-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909171431.3234845-1-sashal@kernel.org>
References: <2026090333-maroon-numerate-89b5@gregkh>
 <20260909171431.3234845-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[ Upstream commit 6ccc22a5afcbac46d55866d72eaba22f43491c00 ]

SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() are deprecated now
and require __maybe_unused protection against unused function warnings.
The usage of pm_ptr() and SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() allows
the compiler to see the functions, thus suppressing the warning. Thus
drop the __maybe_unused markings.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 1cb9663789c5 ("net: ravb: serialize PTP clock teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/ravb_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 84d418b7329ba..c42527d9d7be1 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2996,7 +2996,7 @@ static int ravb_wol_restore(struct net_device *ndev)
 	return disable_irq_wake(priv->emac_irq);
 }
 
-static int __maybe_unused ravb_suspend(struct device *dev)
+static int ravb_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -3018,7 +3018,7 @@ static int __maybe_unused ravb_suspend(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused ravb_resume(struct device *dev)
+static int ravb_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -3077,7 +3077,7 @@ static int __maybe_unused ravb_resume(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused ravb_runtime_nop(struct device *dev)
+static int ravb_runtime_nop(struct device *dev)
 {
 	/* Runtime PM callback shared between ->runtime_suspend()
 	 * and ->runtime_resume(). Simply returns success.
@@ -3090,8 +3090,8 @@ static int __maybe_unused ravb_runtime_nop(struct device *dev)
 }
 
 static const struct dev_pm_ops ravb_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(ravb_suspend, ravb_resume)
-	SET_RUNTIME_PM_OPS(ravb_runtime_nop, ravb_runtime_nop, NULL)
+	SYSTEM_SLEEP_PM_OPS(ravb_suspend, ravb_resume)
+	RUNTIME_PM_OPS(ravb_runtime_nop, ravb_runtime_nop, NULL)
 };
 
 static struct platform_driver ravb_driver = {
@@ -3099,7 +3099,7 @@ static struct platform_driver ravb_driver = {
 	.remove		= ravb_remove,
 	.driver = {
 		.name	= "ravb",
-		.pm	= &ravb_dev_pm_ops,
+		.pm	= pm_ptr(&ravb_dev_pm_ops),
 		.of_match_table = ravb_match_table,
 	},
 };
-- 
2.53.0

