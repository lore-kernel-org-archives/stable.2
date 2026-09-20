Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCC433986F;
	Sun, 20 Sep 2026 06:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789885063; cv=none; b=fG1Mcr7BgVe2DZ8E2TCyu0RrwELuSzOnyiPhnqs8Dp2tm+wAZPn5J356uQTeumuZsooYJ5Jmn8j+rk/Dy9zJigo5kEGKwtvM/FPi0d9DwDgGr7TTSCXQiIGCG2zr4yitt0AO2W0jgsMSJR4ANrYBhNcrWPLCqqbXhQe6fDP0G1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789885063; c=relaxed/simple;
	bh=f04XNksIqZ3jdRrR4QeUbXTOo/hxqhH5+cMqIpcrXBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S2ndx/nbefBq7a25GPmD2NOVP1vqldJZKwAUauACeGKazcL1GHIMZmQRuuT9VF61dv2cC/L0JOlpOysPxNyhVo1B1TdaW38z4VWKZndcNt+Be+NbmE6GHAm6Qy97Ysi6AXuq85l+X4HwssPBOV89Fp6gzxV8FGAVN4KrUkKxGEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=G8T1U/IW; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="G8T1U/IW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0M
	JtPJukxDHokGFqPIDOiixqdEoWYSRe1kuishwSmuQ=; b=G8T1U/IWWh3Iq+QoWS
	Dli0CFPLBlZhIK4dcX3ut2r7eRcPFmWcYJvUbyrARGulY8JDxS7ltH5o+lBMYhBn
	xTbPici6Nsz0dj92Kvdp0ihNq4YZQXdnQwL2YS2OXlqG420iejsQEmx7SyzEy4z4
	mXvGzs5sGddTvMeij3qnwlpBI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3xwwqeq9qij3sBg--.31149S2;
	Sun, 20 Sep 2026 14:16:12 +0800 (CST)
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
	stable@vger.kernel.org
Subject: [PATCH net v2] net: stmmac: do not cache the new TSO MSS before it reaches the DMA
Date: Sun, 20 Sep 2026 14:16:09 +0800
Message-Id: <20260920061609.1919876-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3xwwqeq9qij3sBg--.31149S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr17KFyUur4DJw43Aw13Arb_yoW5KFyDpF
	4UAa90yr98Jr4fXw48Cw40qa45Ja95tayYkw18G3sxGw4ayryvgryfKrW8G34UCFyrZr1S
	ka129a43Ar4UXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UlhFsUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqAwwB2qveixC+wAA35

From: Linkui Xiao <xiaolinkui@kylinos.cn>

stmmac_tso_xmit() fills the MSS context descriptor and stores the new MSS
in tx_q->mss right away, but the descriptor only gets its OWN bit much
later, right before the frame is handed to the DMA. Every error path in
between - the dma_map_single() of the linear part and the
skb_frag_dma_map() of each fragment - returns with tx_q->mss already
updated while the MAC is still programmed with the previous MSS; the
abandoned context descriptor is later reclaimed by stmmac_tx_clean().

The next skb carrying the same MSS then compares equal to the cached
value, so no context descriptor is emitted and the hardware segments the
TCP stream with a stale MSS, generating frames whose payload size does
not match what the stack accounted for.

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
so the error paths have to release it explicitly.

Fixes: f748be531d70 ("stmmac: support new GMAC4")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
Changes in v2:
- Do not advance tx_q->cur_tx while the context descriptor is filled, as
  for the data descriptors, and release the context descriptor on the
  error paths instead of leaving it to stmmac_tx_clean(). (Lorenzo Bianconi)

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index af2d38a2bb3d..e2e680dd980c 100644
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

