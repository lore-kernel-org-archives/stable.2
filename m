Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584DE37BE75
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789609765; cv=none; b=Z4WYX0CyEgUhF+78AeLGBhcp3utPohgLOT5Rl+IrrjM3e/cQUdoqfuASL+7oMOddT71Ei20kxgSndEFv61XnbBSLOvuHtHJMHIpMYjQWQ9ZZ+iCk8oJQMPDVRAeBkiMIJUNvRgVf+iJgBxTwPVQ3OLcei3nqntwIq5S9zUDhnyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789609765; c=relaxed/simple;
	bh=i6FyLAQxOF2gRXKdWRNI8uA3WlMb0MdfauPuj7UkaJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kpyhr1sPG/d4x1ufVI4t6UMuQi+YZLcD337WeqX6Mcb/IVVwlDlh23sNNlbo/jgMjmh07Gz3QSNNx7jcJHzMGQFzIvGzw+KI4c++uvKbD26rbAcIlQ5T6zABs/NytmL4D43JtynhO+Ugx0yk1LmE+lIdbLrR45Ed+kUoprufd3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBIkOIh2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBIkOIh2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592CA1F000FF;
	Thu, 17 Sep 2026 01:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789609764;
	bh=mrgfdBfvEVCsfw+l0G6KZFJDXZlVHfPIOeVHVI7K+PE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dBIkOIh2NFnfQyAjyWMk+gNTj2BRSZlmS4vMUrMhbJMs40iRl8eofQuSbtlK5Ad1o
	 umMrlY61J6UqMaEBtSEEuvBU6z7pufTteZ6QLY5dUnWdSLJFoRKq2KGmLbz7Ia1oeX
	 TVeLmuqd/Vh4LPO+ex0XvSMG6IwTQXRdYdd1/DrXN6cYYr4ZyColnWqWQLmiR2YEvv
	 KDXgf5qD8T7jKBJ3d8lbSNRm0eVB/vrSNmv4lnAEsJCs/SquM7AYTM4rQL3FeLVoYw
	 0iejUCQRm7tVQTlzWtBIsriHHyJbdDA9uRY6AWUUplY4TS5GpTmU8yn4wA0bKBV99t
	 bJR/4beVtP52Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] net: macb: unify device pointer naming convention
Date: Wed, 16 Sep 2026 21:49:20 -0400
Message-ID: <20260917014922.3697068-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091647-cranberry-striking-e506@gregkh>
References: <2026091647-cranberry-striking-e506@gregkh>
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

Stable 5.15 dependency adaptation for e1406330d70e:

Keep only the gem_ptp_init() netdev parameter rename and its matching
interface declarations. Drop the unrelated driver-wide naming and printk
changes; the newer APIs and code surrounding those hunks differ from 5.15.

Preserve the 5.15 transmit timestamp queue/work initialization, moving it
before PTP clock registration so it is outside the lock/TSU block removed
by the target. INIT_WORK() only initializes work; it does not schedule it.

Move the existing conditional jumbo_max_len assignment immediately before
the probe lock initialization and brace it to supply the target's exact
context without importing newer hardware setup. Its value and condition
are unchanged, and there are no intervening users of jumbo_max_len.

These adjustments add no functions. The target remains responsible for
moving tsu_clk_lock initialization to probe and initializing the TSU before
publishing the PTP clock.

[ sashal: Reduced backport -- upstream 07362f68e61d8 touches 4 file(s), this
  backport carries 3. Not backported here:
  drivers/net/ethernet/cadence/macb_pci.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: e1406330d70e ("net: macb: initialize PTP state before registering clock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb.h      |  6 +++---
 drivers/net/ethernet/cadence/macb_main.c |  5 +++--
 drivers/net/ethernet/cadence/macb_ptp.c  | 17 +++++++++--------
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index d3d1b9237d594..46899650707fc 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1145,7 +1145,7 @@ struct macb_or_gem_ops {
 
 /* MACB-PTP interface: adapt to platform needs. */
 struct macb_ptp_info {
-	void (*ptp_init)(struct net_device *ndev);
+	void (*ptp_init)(struct net_device *netdev);
 	void (*ptp_remove)(struct net_device *ndev);
 	s32 (*get_ptp_max_adj)(void);
 	unsigned int (*get_tsu_rate)(struct macb *bp);
@@ -1327,7 +1327,7 @@ enum macb_bd_control {
 	TSTAMP_ALL_FRAMES,
 };
 
-void gem_ptp_init(struct net_device *ndev);
+void gem_ptp_init(struct net_device *netdev);
 void gem_ptp_remove(struct net_device *ndev);
 int gem_ptp_txstamp(struct macb_queue *queue, struct sk_buff *skb, struct macb_dma_desc *des);
 void gem_ptp_rxstamp(struct macb *bp, struct sk_buff *skb, struct macb_dma_desc *desc);
@@ -1349,7 +1349,7 @@ static inline void gem_ptp_do_rxstamp(struct macb *bp, struct sk_buff *skb, stru
 int gem_get_hwtst(struct net_device *dev, struct ifreq *rq);
 int gem_set_hwtst(struct net_device *dev, struct ifreq *ifr, int cmd);
 #else
-static inline void gem_ptp_init(struct net_device *ndev) { }
+static inline void gem_ptp_init(struct net_device *netdev) { }
 static inline void gem_ptp_remove(struct net_device *ndev) { }
 
 static inline int gem_ptp_do_txstamp(struct macb_queue *queue, struct sk_buff *skb, struct macb_dma_desc *desc)
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 74e4b28e21cbd..41c7af7432acf 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4794,8 +4794,6 @@ static int macb_probe(struct platform_device *pdev)
 	bp->tx_clk = tx_clk;
 	bp->rx_clk = rx_clk;
 	bp->tsu_clk = tsu_clk;
-	if (macb_config)
-		bp->jumbo_max_len = macb_config->jumbo_max_len;
 
 	bp->wol = 0;
 	if (of_get_property(np, "magic-packet", NULL))
@@ -4804,6 +4802,9 @@ static int macb_probe(struct platform_device *pdev)
 
 	bp->usrio = macb_config->usrio;
 
+	if (macb_config) {
+		bp->jumbo_max_len = macb_config->jumbo_max_len;
+	}
 	spin_lock_init(&bp->lock);
 	spin_lock_init(&bp->stats_lock);
 
diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index 3ce92b2d0df8b..010e6d1776ec7 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -355,19 +355,25 @@ static void gem_tx_timestamp_flush(struct work_struct *work)
 	}
 }
 
-void gem_ptp_init(struct net_device *dev)
+void gem_ptp_init(struct net_device *netdev)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 	struct macb_queue *queue;
 	unsigned int q;
 
 	bp->ptp_clock_info = gem_ptp_caps_template;
 
+	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		queue->tx_ts_head = 0;
+		queue->tx_ts_tail = 0;
+		INIT_WORK(&queue->tx_ts_task, gem_tx_timestamp_flush);
+	}
+
 	/* nominal frequency and maximum adjustment in ppb */
 	bp->tsu_rate = bp->ptp_info->get_tsu_rate(bp);
 	bp->ptp_clock_info.max_adj = bp->ptp_info->get_ptp_max_adj();
 	gem_ptp_init_timer(bp);
-	bp->ptp_clock = ptp_clock_register(&bp->ptp_clock_info, &dev->dev);
+	bp->ptp_clock = ptp_clock_register(&bp->ptp_clock_info, &netdev->dev);
 	if (IS_ERR(bp->ptp_clock)) {
 		pr_err("ptp clock register failed: %ld\n",
 			PTR_ERR(bp->ptp_clock));
@@ -379,11 +385,6 @@ void gem_ptp_init(struct net_device *dev)
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

