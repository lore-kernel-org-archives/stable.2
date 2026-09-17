Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804EC3612FE
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607613; cv=none; b=UN5GAySin+ArBGwD38vSbFa3fQQW/OLlwPiDiq339Kb7EeBeERwoUe2UCnKuZqDUHS6qqv1EjDL93MnubaGMjrMER43wPAiJ1jYnPnVk+mt+uBM/LRNZe10QJNH+VOnZOoHu4/y5zz5PBzMHmKoqSx5lfe05dy19W/XLa4jnFew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607613; c=relaxed/simple;
	bh=In8dY6R0x/LaDHhiS4vCmdX90NOOsDZn9L5hyVc61Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rn/exggQRKjC/UWAkJKEZK4xYbR4fKzG8/tVY481hmfqe16WGSDKjjIIqTztGAK4hQGDxw8ssu+Q//HWWzVGrIXzveuPy6YUciZPmKrQBxIcX2v+5cz4Hcqyd5UsMgzR5VQXzK0BgbDcZe4438E1G8VFLNNCq71+fz7hK/vjwhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXyQDGbb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXyQDGbb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924A51F000FF;
	Thu, 17 Sep 2026 01:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789607607;
	bh=dx3pPL6FbaOCwuuFaTh8mDRn2jxlFBulbDApeHcOwHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jXyQDGbbN/3FpoP7N9x/LaqD1iriZkazqDAQZ8k+kQDrSCEyJDGkM1ywPxOjcHOJR
	 hXIqR8mx1w5otaUjeVFh1bAXqP9ZSDJfVj5c9ppS0OYqxffM090GM5OTE06pVCugZt
	 X8RZZ6l8cqxWLc/fTg4K2/PIKiSuWQdxegOe9RwRJiJRLGT6vu3WgxQ+pt6FoSdu98
	 X80XiRKJRYM9Knr4I1HMIIvCOKI+jpZYQ3JE+vpjVx1XMPLxPT8UyRD7R81Z+duVYG
	 G9yRZyD2UuKKq1FE/rYdtfvGgQKnSuggczb5ZGylLrgrtp+kcF6sWEEoHgArA+dIP/
	 dBOdDM54IcsYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/5] net: macb: unify device pointer naming convention
Date: Wed, 16 Sep 2026 21:13:21 -0400
Message-ID: <20260917011322.3531179-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917011322.3531179-1-sashal@kernel.org>
References: <2026091646-swoop-cubical-81ce@gregkh>
 <20260917011322.3531179-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Théo Lebrun <theo.lebrun@bootlin.com>

[ Upstream commit 07362f68e61d82ee53da0e9ae2c7f981c3538861 ]

Here are all device pointer variable permutations inside MACB:

   struct device *dev;
   struct net_device *dev;
   struct net_device *ndev;
   struct net_device *netdev;
   struct pci_dev *pdev;              // inside macb_pci.c
   struct phy_device *phy;
   struct phy_device *phydev;
   struct platform_device *pdev;
   struct platform_device *plat_dev;  // inside macb_pci.c

Unify to this convention:

   struct device *dev;
   struct net_device *netdev;
   struct pci_dev *pci;
   struct phy_device *phydev;
   struct platform_device *pdev;

Ensure nothing slipped through using ctags tooling:

⟩ ctags -o - --kinds-c='{local}{member}{parameter}' \
    --fields='{typeref}' drivers/net/ethernet/cadence/* | \
  awk -F"\t" '
    $NF~/struct:.*(device|dev) / {print $NF, $1}' | \
  sort -u
typeref:struct:device * dev
typeref:struct:in_device * idev        // ignored
typeref:struct:net_device * netdev
typeref:struct:pci_dev * pci
typeref:struct:phy_device * phydev
typeref:struct:platform_device * pdev

Also fix some printk() calls to use __func__ instead of hardcoding.
This silences some checkpatch.pl warnings and doesn't deserve a
separate commit.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Link: https://patch.msgid.link/20260812-macb-context-v9-2-7ddbf5f715e0@bootlin.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Backport notes for 6.1:
Keep only the gem_ptp_init() net_device parameter rename needed by
e1406330d70e ("net: macb: initialize PTP state before registering clock").
Drop the other naming and printk cleanups, which are unnecessary for that
fix and conflict with the older MACB APIs and implementation.

Unlike upstream, 6.1 still uses the TX timestamp queues and work items
removed by 8e7610e686d0 ("net: macb: simplify TX timestamp handling").
Preserve their initialization, moving it before PTP clock setup so it no
longer splits the lock/TSU block changed by e1406330d70e. Initializing these
software objects does not need the TSU lock or touch the hardware. The
clock registration error paths may leave them initialized, but no work is
scheduled or resources allocated by this initialization.

Retain the existing timestamp implementation and all function definitions.
The target remains responsible for moving TSU lock initialization to probe
and initializing the TSU before registering the PTP clock.

[ sashal: Reduced backport -- upstream 07362f68e61d8 touches 4 file(s), this
  backport carries 1. Not backported here:
  drivers/net/ethernet/cadence/macb.h
  drivers/net/ethernet/cadence/macb_main.c
  drivers/net/ethernet/cadence/macb_pci.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: e1406330d70e ("net: macb: initialize PTP state before registering clock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_ptp.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index b1b02b8faa8bd..ee696f45110db 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -360,19 +360,25 @@ static void gem_tx_timestamp_flush(struct work_struct *work)
 	}
 }
 
-void gem_ptp_init(struct net_device *dev)
+void gem_ptp_init(struct net_device *netdev)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 	struct macb_queue *queue;
 	unsigned int q;
 
+	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		queue->tx_ts_head = 0;
+		queue->tx_ts_tail = 0;
+		INIT_WORK(&queue->tx_ts_task, gem_tx_timestamp_flush);
+	}
+
 	bp->ptp_clock_info = gem_ptp_caps_template;
 
 	/* nominal frequency and maximum adjustment in ppb */
 	bp->tsu_rate = bp->ptp_info->get_tsu_rate(bp);
 	bp->ptp_clock_info.max_adj = bp->ptp_info->get_ptp_max_adj();
 	gem_ptp_init_timer(bp);
-	bp->ptp_clock = ptp_clock_register(&bp->ptp_clock_info, &dev->dev);
+	bp->ptp_clock = ptp_clock_register(&bp->ptp_clock_info, &netdev->dev);
 	if (IS_ERR(bp->ptp_clock)) {
 		pr_err("ptp clock register failed: %ld\n",
 			PTR_ERR(bp->ptp_clock));
@@ -384,11 +390,6 @@ void gem_ptp_init(struct net_device *dev)
 	}
 
 	spin_lock_init(&bp->tsu_clk_lock);
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		queue->tx_ts_head = 0;
-		queue->tx_ts_tail = 0;
-		INIT_WORK(&queue->tx_ts_task, gem_tx_timestamp_flush);
-	}
 
 	gem_ptp_init_tsu(bp);
 
-- 
2.53.0

