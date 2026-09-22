Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDD32222CC;
	Tue, 22 Sep 2026 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081133; cv=none; b=uo3Cvsp5ZbNFS/cnREg9Gzgs7jWv1mIQ2wz8U09tL850FRgMhqVj2ub7XdYPBxnX8RD0xJf5kEtnGynzNPt1wOgD+Z7vmR+KdB9HoEoOFKvIeuLr2M356S2c519p6lMbLE6tCk85TyJqlf6xPnP6iYvIF8Y8cWfk89+op3Hof10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081133; c=relaxed/simple;
	bh=SexyDCDDA86IrxgleDDpgNquGCBXEAW+5IL256OLIYg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UQEIxBRxkYVL5ebgJvBWHz9Y6ZaUja6wiRMmp8dFQ+G8zVLM8LDVIPOhFQnX+igH0pJ2B3mRjblgFl6F/0vR4Jsd13XShatZaQb4KgmXyKaTyecsBaiMkztLbQkdAOs96dlV9snZPJaZBe8ZKJ9zRAvLt2s/ceOnHDMo+mJFHNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=pIw/gEsw; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="pIw/gEsw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dJ
	/NF/IKzyTCf3s98R9LljNUJNr1ysT/7jTS8YD1kDA=; b=pIw/gEsw9hc1kv9ou/
	jvGzbKBcUQ31Ucys3yYzr7CAgtmNo8A2er9874K7ht7fKVc1qN4vqf3b4TwhpFl0
	nKg7uJXyEiIhv0UwwzGcu6QYNE2CI1lZ0F/ZH1XLBaFFOtHnqhVc+MKcuFFobgw6
	bmV5IPQs57ZzAChDwKhdApAUc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3f90ZeLJqrJ0eAA--.64182S2;
	Tue, 22 Sep 2026 20:44:09 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>,
	stable@vger.kernel.org,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net v3] net: stmmac: do not cache the new TSO MSS before it reaches the DMA
Date: Tue, 22 Sep 2026 20:44:08 +0800
Message-Id: <20260922124408.645496-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f90ZeLJqrJ0eAA--.64182S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr17KFyUur4DJw43Aw13Arb_yoWrZrWxpF
	4UZa90yr95Jr1fWw48C3y0va45Jayrtay5Cw18G3sxCwsIyryvgryfKrWUWa4UAF95ZF1a
	ka1q9asxAF4UJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ul-ewUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqRlrQmqyeBnq-AAA32

From: Linkui Xiao <xiaolinkui@kylinos.cn>

stmmac_tso_xmit() fills the MSS context descriptor and stores the new MSS
in tx_q->mss right away, but the descriptor only gets its OWN bit much
later, right before the frame is handed to the DMA. Every error path in
between - the dma_map_single() of the linear part and the
skb_frag_dma_map() of each fragment - returns with tx_q->mss already
updated while the MAC is still programmed with the previous MSS.

The abandoned context descriptor is never handed to the DMA:
stmmac_set_mss() does not set the OWN bit, and the error paths return
before stmmac_flush_tx_descriptors(), which is the only place that
advances the TX tail pointer. When a later xmit advances the tail pointer
past the abandoned slot, the DMA stops on the not-owned context
descriptor and suspends; stmmac_tx_clean() then reclaims the slot in
software but stops at the first descriptor the DMA still owns, so the
ring can never wrap around. The queue stalls until the watchdog fires
and stmmac_tx_err() resets the channel, which also clears the stale
tx_q->mss via stmmac_reset_tx_queue().

Update tx_q->mss only once the context descriptor has been given to the
DMA, so that the cached value always describes what the hardware is
actually programmed with.

The context descriptor is now handled like the data descriptors are:
tx_q->cur_tx is not advanced while it is being filled. Whether the frame
can be queued is only known after every dma_map_single() and
skb_frag_dma_map() has succeeded, so the descriptor stays at the slot
tx_q->cur_tx points to and the index moves past it later, together with
the data descriptors. That also keeps the context descriptor outside the
range stmmac_tx_clean() walks when the ring is cleaned after a failure,
so the error paths have to release it explicitly. A mapping failure
therefore leaves the slot reusable instead of parked in the middle of
the ring as a descriptor the DMA will stop on.

Fixes: f748be531d70 ("stmmac: support new GMAC4")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
Changes in v3:
- Rewrote the failure description in the commit message: after a mapping
  failure the not-owned context descriptor wedges the TX ring (the DMA
  suspends on it, stmmac_tx_clean() pins dirty_tx, only the watchdog
  reset recovers), it does not produce mis-sized segments as previously
  claimed. No code change. (Sashiko AI review)
- Kept Lorenzo's Acked-by, as the patch is unchanged from v2.
- Link: https://lore.kernel.org/all/20260920061609.1919876-1-xiaolinkui@126.com/

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a268cd4acdef..276187f50ee3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4563,10 +4563,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 			mss_desc = &tx_q->dma_tx[tx_q->cur_tx];
 
 		stmmac_set_mss(priv, mss_desc, mss);
-		tx_q->mss = mss;
-		tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx,
-						priv->dma_conf.dma_tx_size);
-		WARN_ON(tx_q->tx_skbuff[tx_q->cur_tx]);
 	}
 
 	if (netif_msg_tx_queued(priv)) {
@@ -4577,6 +4573,9 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	first_entry = tx_q->cur_tx;
+	if (mss_desc)
+		first_entry = STMMAC_NEXT_ENTRY(first_entry,
+						priv->dma_conf.dma_tx_size);
 	entry = first_entry;
 
 	WARN_ON(tx_q->tx_skbuff[entry]);
@@ -4714,6 +4713,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 		 */
 		dma_wmb();
 		stmmac_set_tx_owner(priv, mss_desc);
+		tx_q->mss = mss;
 	}
 
 	if (netif_msg_pktdata(priv)) {
@@ -4745,6 +4745,9 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 						priv->dma_conf.dma_tx_size);
 	}
 error:
+	if (mss_desc)
+		stmmac_release_tx_desc(priv, mss_desc, priv->descriptor_mode);
+
 	dev_err(priv->device, "Tx dma map failed\n");
 	dev_kfree_skb(skb);
 	priv->xstats.tx_dropped++;
-- 
2.25.1

