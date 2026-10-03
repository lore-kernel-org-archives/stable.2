Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09540282F10;
	Sat,  3 Oct 2026 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791018062; cv=none; b=U5RfcI+9ixfCMhkMgbQP25eG2o6rFoDQ44OTxVghS3pm8xVQI0t7ZgQeptcLRLC2y/61JMWnpqxGSElMg4Xx11jFjosSrnSngveG6rluD4QSepseBGcUz/fBIqeI88nWFiYbF2MOB4H2aAIsMHR7eBZ1fnX6dv2o68/UBGdJZ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791018062; c=relaxed/simple;
	bh=gCJ2Y+9Ii/0oTuh9JHBvzNRrME8urp7sA9q8osHRJFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Raf7XYrzJEyFGLomfgyL54QrrxoeUW4C3KQ4uZvG6Ft6Wj1j8/YquumyaoQc+flG9C7mcaQ9aGxZ0Q6LEPcNul2cjkp2KZkGBoHRH1VT3iiA+RVkZ/y8iw61oNTmTej3jjMYxEUGjnO37xQzv4o7WW21f8pCxZKdSwgCF5Pwo2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DhHs4oAh; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DhHs4oAh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=o6
	pbr0MqsE4xJG+7dGbFGQ+GBFL8J44m8Mgor8rfGAs=; b=DhHs4oAhoswv88W1lb
	V6zRjcseS5vfj2tMJvN326VftaZ9zpZSFz9IhzMhuhf+sK18hKlmYzSfWU5HpKvo
	kr2pJ6JNxGk6s1jE0Vu5CQbcQXjwr9jp1HNO+mXqhhvA/JNw01TOkZ1LuV8U6Wll
	3TLNy/6DzT/DxOiKzM2t0GGQA=
Received: from pc.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXP4b_w8BqInaGCg--.62290S8;
	Sat, 03 Oct 2026 16:59:57 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 6/7] net: ravb: release managed IRQs before freeing netdev
Date: Sat,  3 Oct 2026 16:59:37 +0800
Message-Id: <20261003085940.493951-7-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261003085940.493951-1-yaojiale02@163.com>
References: <20261003085940.493951-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDXP4b_w8BqInaGCg--.62290S8
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF15Cw4kXr1rJry5uFyrCrg_yoW5Xw43p3
	95Aa98Wr1ktrn7Xan7tw4kZ3Wru3W8Ka45GFWUtayfAwnIyrWDXr1FgF1jqF48GFWkA3yY
	gayjy3y8u3WUu37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pibo7iUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQ3+OWrAxA1F0wAA3y

ravb_remove() frees the netdev before devres releases the managed IRQs.
The handlers use the netdev as their data pointer, so an interrupt during
that window can access freed memory. Probe error paths have the same
ordering problem.

Keep the netdev manually managed and place only the IRQ resources in a
dedicated devres group. Release the group after unregistering the netdev
and before freeing it, and release it on probe failures as well. This
keeps the existing runtime PM error handling unchanged.

This issue was found by a static analysis method used in our research.

Fixes: 32f012b8c01c ("net: ravb: Move getting/requesting IRQs in the probe() method")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index ea1c7e536791..ab4703888778 100644
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
+		goto out_release_irq_group;
+
+	devres_close_group(&pdev->dev, priv);
 
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		error = PTR_ERR(priv->clk);
-		goto out_reset_assert;
+		goto out_release_irq_group;
 	}
 
 	if (info->gptp_ref_clk) {
 		priv->gptp_clk = devm_clk_get(&pdev->dev, "gptp");
 		if (IS_ERR(priv->gptp_clk)) {
 			error = PTR_ERR(priv->gptp_clk);
-			goto out_reset_assert;
+			goto out_release_irq_group;
 		}
 	}
 
 	priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
 	if (IS_ERR(priv->refclk)) {
 		error = PTR_ERR(priv->refclk);
-		goto out_reset_assert;
+		goto out_release_irq_group;
 	}
 	clk_prepare(priv->refclk);
 
@@ -3124,6 +3131,8 @@ static int ravb_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	clk_unprepare(priv->refclk);
+out_release_irq_group:
+	devres_release_group(&pdev->dev, priv);
 out_reset_assert:
 	reset_control_assert(rstc);
 out_free_netdev:
@@ -3144,6 +3153,7 @@ static void ravb_remove(struct platform_device *pdev)
 		return;
 
 	unregister_netdev(ndev);
+	devres_release_group(dev, priv);
 	if (info->nc_queues)
 		netif_napi_del(&priv->napi[RAVB_NC]);
 	netif_napi_del(&priv->napi[RAVB_BE]);
-- 
2.34.1

