Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EFA382F2F
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611951; cv=none; b=Q1Q6OM8IE02xc8wFm9q45dVv57oILbN+/n9ZpLY/ScmXuxinMZA0dnV1ZbgwViO6aq0C6AbZ0QpTK31rQoRN1RbBzKPPWVjeHXwXj7D0f6FUmnfLL1kc6Cf+c+VXmh9Kal7Jg7mprZX6pzXnPPV2HZZywuTSvIaKBMV/qwX7TWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611951; c=relaxed/simple;
	bh=52eG2d5sKl8inrlk2m0z2jfNycouzLeRfuR6oFoczio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNxwO1lJTh6FKVqh3v5G/s+S2iEVpez8Wfy9OM5hGsPHoEM6qBWNEPirBrPx65TXChk7f3MZFW1dsHM4ix+M7B7/aisDTAVOIOlrldwYCtqsrjB7XSmeNsl2/4Wm1VnL0PVqXZulD/ErzGSVX5rK1z6EDTKZfTSmkzossm3Mun4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNTjym1h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNTjym1h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0621F000FF;
	Thu, 17 Sep 2026 02:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611949;
	bh=oCmz5aAQVAv7bWHbKwKukMHDFWngZZ+UhiFGu+28CPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SNTjym1h+Gr50mhh9nUhrpDIpaf5fmVePaq3ggQXVGGBozA3QqXaPtaWWmncqfPyM
	 asfIN3qgyiWr4Ih9MDcDNc77DBhLaLnWD3uRpF8/Im+Q4l59PR2RQvcBoiQM4LTDzO
	 oQ0m/ze6rtPLF16zm+599mPmvlWtOzyUF/2kHQJMTfWddMu+MSmexcJs5ZCrax65FI
	 g3ua/fYrvf+lCm+QHHjjupD2w/IrJuVkWQKrtOIGlBjwPTN2zjTkrZqUkMv2LsO5VU
	 R4HVATWsLmHQwY21DrdpU14fA3zPRzK0GA25b2PVmr+HYnC+d+u4KvCxcdFsFVKgId
	 A4I8KbwbYd+GA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] net: macb: unify device pointer naming convention
Date: Wed, 16 Sep 2026 22:25:46 -0400
Message-ID: <20260917022547.3826863-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091649-armoire-absurd-8a42@gregkh>
References: <2026091649-armoire-absurd-8a42@gregkh>
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

Keep only the net_device argument rename for gem_ptp_init(), together
with its callback, declaration and disabled-PTP stub. The other naming
changes are unrelated to the PTP initialization fix and conflict with
driver APIs and code paths that differ substantially in Linux 5.10.

Linux 5.10 still initializes per-queue deferred TX timestamp state in
gem_ptp_init(). Move that existing loop to the start of the function,
preserving its counters and work initialization. This keeps the lock and
TSU initialization block contiguous so that target commit
e1406330d70e56dd44fa6fbafc86e77e5c80c122 applies without conflicts.

The target remains responsible for initializing tsu_clk_lock once at probe
and initializing the TSU before publishing the PTP clock. No functions or
newer driver APIs are introduced by this dependency backport.

[ sashal: Reduced backport -- upstream 07362f68e61d8 touches 4 file(s), this
  backport carries 2. Not backported here:
  drivers/net/ethernet/cadence/macb_main.c
  drivers/net/ethernet/cadence/macb_pci.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: e1406330d70e ("net: macb: initialize PTP state before registering clock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb.h     |  6 +++---
 drivers/net/ethernet/cadence/macb_ptp.c | 17 +++++++++--------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 7ce391209cdd1..0b507def88616 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1087,7 +1087,7 @@ struct macb_or_gem_ops {
 
 /* MACB-PTP interface: adapt to platform needs. */
 struct macb_ptp_info {
-	void (*ptp_init)(struct net_device *ndev);
+	void (*ptp_init)(struct net_device *netdev);
 	void (*ptp_remove)(struct net_device *ndev);
 	s32 (*get_ptp_max_adj)(void);
 	unsigned int (*get_tsu_rate)(struct macb *bp);
@@ -1260,7 +1260,7 @@ enum macb_bd_control {
 	TSTAMP_ALL_FRAMES,
 };
 
-void gem_ptp_init(struct net_device *ndev);
+void gem_ptp_init(struct net_device *netdev);
 void gem_ptp_remove(struct net_device *ndev);
 int gem_ptp_txstamp(struct macb_queue *queue, struct sk_buff *skb, struct macb_dma_desc *des);
 void gem_ptp_rxstamp(struct macb *bp, struct sk_buff *skb, struct macb_dma_desc *desc);
@@ -1282,7 +1282,7 @@ static inline void gem_ptp_do_rxstamp(struct macb *bp, struct sk_buff *skb, stru
 int gem_get_hwtst(struct net_device *dev, struct ifreq *rq);
 int gem_set_hwtst(struct net_device *dev, struct ifreq *ifr, int cmd);
 #else
-static inline void gem_ptp_init(struct net_device *ndev) { }
+static inline void gem_ptp_init(struct net_device *netdev) { }
 static inline void gem_ptp_remove(struct net_device *ndev) { }
 
 static inline int gem_ptp_do_txstamp(struct macb_queue *queue, struct sk_buff *skb, struct macb_dma_desc *desc)
diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index d0063495a4a71..1faca23dc3ccc 100644
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

