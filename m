Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9459372071;
	Sun, 27 Sep 2026 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790507486; cv=none; b=g7NP+3EqEi139PgimEv4L/XcnA7yrS6kz55uflwocFk5JDnB3aU6FKSgYAbMRIFtsImw63x7chHDGcBdN8iL+6Pr5ImvyEKOsJs5IKEfTnhGlfgaO6+xYaOySM+Rgx+SpU3T9KYWxr17JVukHhNvNiExxbzLfyQj4KRo22pEHMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790507486; c=relaxed/simple;
	bh=M/1wRLH6//vjXHn8+eNoN9tyf4dwMw8dzjbw6uTgBRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KBPnfKzxcBZL5TL2unhg1YKQC02x/s5qd8jFHpXIran6m6ubnFSlsqm4gDrNF9i0IVZ0BcdYxbk3aKtjKSKrAXd9E4QQKnmcOUEQhOUi79113VFlShyrKZgdsohcZcrr3bswtareDdJzn5sPH01ytWfNGLfFypilXuYTyK2zq6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IMDXX0u0; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IMDXX0u0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=iW
	G5bcWR8Gy/SGkYDcpum8ojyQYtZQend0Il1O1hRvE=; b=IMDXX0u0fZ8OOCAGDH
	62KjOn2IeX2Fb50Jm6Fa19AncfetwtApG8cfJ3A9gODB2dCH4jE9tQqf6RpKQnuY
	Xq3jA0EfyFUhRy3CsXrP8ic+ioekqAoIwNh8E8VOfvOTnIy2+SJS0Xzj4WHPLgLH
	HATGRc5MvVRDE2TKQxyyHoZY0=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3_92P+bhqB9V5BA--.4648S8;
	Sun, 27 Sep 2026 19:10:16 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 6/7] net: ravb: fix resource teardown ordering
Date: Sun, 27 Sep 2026 19:10:03 +0800
Message-Id: <20260927111005.1035089-7-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260927111005.1035089-1-yaojiale02@163.com>
References: <20260927111005.1035089-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_92P+bhqB9V5BA--.4648S8
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF15Cw43XFykCFy3GrWDtwb_yoW5KF1Dp3
	95Ja98Kr1ktr1ktws7tw4kZa4ru3W8Ka4UGFy7Kan3Awnayryqqr1FqFyjqF48JFZ5A3yY
	ga1jyw4xu3WDurJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piD5rcUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhhtp2q4+ZhiOAAA31

ravb_remove() frees the netdev before devres releases the managed IRQs.
The handlers use the netdev as their data pointer, so an interrupt during
that window can access freed memory. Probe error paths have the same
ordering problem.

The remove callback also returns when runtime resume fails. That leaves
the netdev registered while the driver core still releases its managed
resources. A running interface already holds a runtime PM reference, so
the extra get cannot invoke a failing resume. A resume failure therefore
occurs while the interface is down and ndo_stop() will not be called.

Place the IRQ resources in a dedicated devres group and release it before
freeing the netdev. Continue unregistering and freeing software resources
when runtime resume fails, but skip the unmatched runtime PM put.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Fixes: 48f894ab07c4 ("net: ravb: Add runtime PM support")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index ea1c7e536791..a25f5ac7062f 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2963,28 +2963,35 @@ static int ravb_probe(struct platform_device *pdev)
 		priv->num_rx_ring[RAVB_NC] = NC_RX_RING_SIZE;
 	}
 
+	if (!devres_open_group(&pdev->dev, priv, GFP_KERNEL)) {
+		error = -ENOMEM;
+		goto out_reset_assert;
+	}
+
 	error = ravb_setup_irqs(priv);
 	if (error)
-		goto out_reset_assert;
+		goto out_release_irqs;
+
+	devres_close_group(&pdev->dev, priv);
 
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		error = PTR_ERR(priv->clk);
-		goto out_reset_assert;
+		goto out_release_irqs;
 	}
 
 	if (info->gptp_ref_clk) {
 		priv->gptp_clk = devm_clk_get(&pdev->dev, "gptp");
 		if (IS_ERR(priv->gptp_clk)) {
 			error = PTR_ERR(priv->gptp_clk);
-			goto out_reset_assert;
+			goto out_release_irqs;
 		}
 	}
 
 	priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
 	if (IS_ERR(priv->refclk)) {
 		error = PTR_ERR(priv->refclk);
-		goto out_reset_assert;
+		goto out_release_irqs;
 	}
 	clk_prepare(priv->refclk);
 
@@ -3124,6 +3131,8 @@ static int ravb_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	clk_unprepare(priv->refclk);
+out_release_irqs:
+	devres_release_group(&pdev->dev, priv);
 out_reset_assert:
 	reset_control_assert(rstc);
 out_free_netdev:
@@ -3141,9 +3150,10 @@ static void ravb_remove(struct platform_device *pdev)
 
 	error = pm_runtime_resume_and_get(dev);
 	if (error < 0)
-		return;
+		dev_warn(dev, "failed to resume device: %d\n", error);
 
 	unregister_netdev(ndev);
+	devres_release_group(dev, priv);
 	if (info->nc_queues)
 		netif_napi_del(&priv->napi[RAVB_NC]);
 	netif_napi_del(&priv->napi[RAVB_BE]);
@@ -3153,7 +3163,8 @@ static void ravb_remove(struct platform_device *pdev)
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
 
-	pm_runtime_put_sync_suspend(&pdev->dev);
+	if (error >= 0)
+		pm_runtime_put_sync_suspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(dev);
 	clk_unprepare(priv->refclk);
-- 
2.34.1

