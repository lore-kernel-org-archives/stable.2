Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3894025228D;
	Mon, 28 Sep 2026 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598938; cv=none; b=LrzdqZEj3XM8iT9RczEQI5hLxpUgwii3vdBoLfPkCR9i9qLsGhGFtsVxAnXTCkvYMnq3mzU51ljsV+OgE6BKWPwq9NURy7ZNA2BisfmB8ISqyOS7fbd3tmx28CpO5y0sz15Df4OoMPJAp7PW/JjBT05HZJbcuBYn55PIpJ8GJ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598938; c=relaxed/simple;
	bh=AAymeJ47wZJzijBjAjTeIOAL3/ew+7H0zqr/yz6O3Gc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OWKxVGlmS3fLu3FigqV+eHUi9HOIY0X76KbLq3bC/rourNrDA+OSrnpbGD9YtTQDkcIsV02sVPHDRgEbIsjKwmXpKbtE0S2Sf1C1OB9seu1FlTRbSYYiRyqIsanTkgVuIM6mQtRfJPgZH/ZbFfnptmt9j7IuSGYqbUyy71pgSXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=AWBllJTo; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="AWBllJTo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=zA
	/NU+RNAgeD9BOrpSB6bKryvPeGYSvBJqFkKYtNmis=; b=AWBllJTokd4kPeZzb5
	k8asaCq/kXPYcf0gWyyqx3rgebS7ek/aLQyFU4qvYPHa4KYZGnBpDaiTzfixQBxC
	gBnsrmbfca7RnzFE7kUd3Fha2LdbifW4XMvxkP7slZWvenocYtFKLZwVqgX9gc+9
	qdrZUuo5ipr93Zci/1ipXUAfw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3P6HPXrpqTCkyAQ--.12557S2;
	Mon, 28 Sep 2026 20:34:23 +0800 (CST)
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
Subject: [PATCH net v4] net: stmmac: do not keep the new TSO MSS cached on mapping failures
Date: Mon, 28 Sep 2026 20:34:22 +0800
Message-Id: <20260928123422.1698785-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P6HPXrpqTCkyAQ--.12557S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr17KFyUur4DJw43Aw13Arb_yoWrAF4rpF
	W5Zws0k34kJr1Sqw48Cw48Xa4Fyayrtay5Cw1UK343Cwsxtr92grySgrWjg34UCFZ5Xr1S
	9anxua43Cr4UJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULFxUUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqA8U6mq6Xs9xjgAA3n

From: Linkui Xiao <xiaolinkui@kylinos.cn>

stmmac_tso_xmit() fills the MSS context descriptor and stores the new MSS
in tx_q->mss right away, but the descriptor only gets its OWN bit much
later, right before the frame is handed to the DMA. Every error path in
between - the dma_map_single() of the linear part and the
skb_frag_dma_map() of each fragment - returns with tx_q->mss already
updated while the MAC is still programmed with the previous MSS.

The context descriptor is now handled like the data descriptors are:
tx_q->cur_tx is not advanced while it is being filled, so the slot stays
where the next transmit fills it, and the error paths release it
explicitly instead of leaving a descriptor the DMA will stop on in the
middle of the ring. With the queue no longer wedged by that descriptor,
the stale cached MSS is what remains: the next skb carrying the same
gso_size compares equal to the cached value, no context descriptor is
emitted, and the hardware segments the TCP stream with the MSS of an
earlier frame, generating frames whose payload size does not match what
the stack accounted for.

Drop the cached value on those paths instead. Zero is what
stmmac_reset_tx_queue() leaves behind, so the next TSO frame programs the
context descriptor again.

The store itself stays ahead of the mappings, as before, rather than
moving next to the OWN bit: stmmac_tx_err() reinitialises the channel and
clears tx_q->mss from the DMA interrupt handler, which takes no TX queue
lock, so it can run in the middle of stmmac_tso_xmit(). Publishing the
cache after the descriptor has been handed over would widen the window in
which such a reset is overwritten with an MSS that the reinitialised
channel was never programmed with.

Fixes: f748be531d70 ("stmmac: support new GMAC4")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
v3:
- Link: https://lore.kernel.org/netdev/20260922124408.645496-1-xiaolinkui@126.com/
Changes in v4:
- Drop the cached MSS on the mapping failure paths instead of publishing it
  after the context descriptor has been given to the DMA. The deferred store
  widened the window in which a stmmac_tx_err() from the DMA interrupt
  handler, which takes no TX queue lock, is overwritten again with the new
  MSS for a channel that was never programmed with it; zero cannot
  republish anything, as it is what the reset itself leaves behind.
  (Sashiko AI review)
- Not carrying over the Acked-by from Lorenzo Bianconi, as the cache
  handling changed again.

 .../net/ethernet/stmicro/stmmac/stmmac_main.c    | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index af2d38a2bb3d..a20b2366f61a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4564,9 +4564,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 
 		stmmac_set_mss(priv, mss_desc, mss);
 		tx_q->mss = mss;
-		tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx,
-						priv->dma_conf.dma_tx_size);
-		WARN_ON(tx_q->tx_skbuff[tx_q->cur_tx]);
 	}
 
 	if (netif_msg_tx_queued(priv)) {
@@ -4577,6 +4574,9 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	first_entry = tx_q->cur_tx;
+	if (mss_desc)
+		first_entry = STMMAC_NEXT_ENTRY(first_entry,
+						priv->dma_conf.dma_tx_size);
 	entry = first_entry;
 
 	WARN_ON(tx_q->tx_skbuff[entry]);
@@ -4745,6 +4745,16 @@ error_dma_unmap:
 						priv->dma_conf.dma_tx_size);
 	}
 error:
+	if (mss_desc) {
+		/* The context descriptor never reached the DMA, so the MAC is
+		 * still programmed with the previous MSS. Invalidate the cache
+		 * instead of leaving it ahead of the hardware; zero is the
+		 * value stmmac_reset_tx_queue() leaves behind.
+		 */
+		stmmac_release_tx_desc(priv, mss_desc, priv->descriptor_mode);
+		tx_q->mss = 0;
+	}
+
 	dev_err(priv->device, "Tx dma map failed\n");
 	dev_kfree_skb(skb);
 	priv->xstats.tx_dropped++;
-- 
2.25.1

