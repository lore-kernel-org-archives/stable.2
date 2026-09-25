Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8101A4A4EF5
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344802; cv=none; b=puYRP1qjNOON4/oLknaN84e45VvZabSPgpGk7smDZKG2C5vkELF8/ssEklK8TxDao6Xl/ZubpEvLzJ5qdWUtoyOjohPMTe91k+erjv0ylCPu2e/mGHLdcUWvXTi8cPlCg9J3TjYU4jnV/1lxgi+9KX18x04ZRk6h18KMxlx/9kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344802; c=relaxed/simple;
	bh=GXbd9O8F0Ga868206Jp3PJXH7V5mfwwh4/C7YNP71qw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VE2kgyJzudf2I6DpC6T5D5Hn5XGtZtn01JzgOeIf3YlNHL3gnAxVsYXpybJgrAqub7h9tvj8scwgySNC/hVzFY1Q9PdhysxhA8GbDkLVfkHiaORAwD2jUZt0aLskjrJzd/YSMHkB7XpNZFKO9Z5Yf9zCe12vOErcJbxF7BjJsZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VzMRiRta; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VzMRiRta"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5949B1A101D;
	Fri, 25 Sep 2026 13:59:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2D4AF6073B;
	Fri, 25 Sep 2026 13:59:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9905C10328856;
	Fri, 25 Sep 2026 15:59:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790344789; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MT3XSGNQA4LE+B/Kq3xueLTY2svzc0JEP6wXJ7cJaUc=;
	b=VzMRiRta30sYqbaLaweAUJ/ANph1gDspnL9W1+XpVNtPp2+NZIkFpAk/+sIMSkccLy3Bfs
	yEqSy87K61ZlfIKMN2uE8iMdG4LqffW74vO8vRIWiAJ5uttiZPDy+E4H8MH00yCtHY75xW
	eqIFbWlms1tPwhb8qHZOYsOR2GPnVQs0t6AGnWFlg7IQb2RtOVXeFX6IKGqbFUfzSt+kEl
	NGKyyyV0+ZaIN3yhhFk0nU08SpLGxLarDD35BX9dyC0SYU33kYH9UnkZ4UTNCNn+gN64WT
	EUjmg7SyC2PRNeHVzX4oMBTtH1/EFJZY9LulhF4nANDXXnRnSALYMpdtxT/ERQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 25 Sep 2026 15:59:34 +0200
Subject: [PATCH net v2 1/3] net: macb: never give hardware a NULL RX buffer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260925-macb-close-v2-1-360efa565914@bootlin.com>
References: <20260925-macb-close-v2-0-360efa565914@bootlin.com>
In-Reply-To: <20260925-macb-close-v2-0-360efa565914@bootlin.com>
To: Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Antoine Tenart <atenart@kernel.org>, Eric Dumazet <edumazet@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

The refill logic is simple: iterate over all pending rx slots, allocate
SKB (& DMA map) if needed and hand it off to the hardware by clearing
the RX_USED flag.

If the refill operation fails mid-way, it early returns leaving the
remaining slots untouched. In an initialised ring that is safe: a slot
is either owned by the hardware holding a valid buffer, or
software-owned (RX_USED set) waiting for refill to hand it a new one.
When slots have never been initialised however, we are in trouble.

After dma_alloc_coherent() of the rx ring buffer, all slots have NULL
pointers and RX_USED cleared meaning HW will try using them. Ensure
this does not happen by setting the RX_USED flag on all slots before
calling refill at buffer alloc, in gem_init_rx_ring(). That way even if
refill fails on an alloc/dma_map, the HW won't try using NULL pointers
as buffers.

Note we tweak gem_rx() and macb_rx_pending(): their previous stop
condition was only if desc was RX_USED. Now it must be either RX_USED
or we got out of the range of successfully allocated descriptors
(detected using the rx_tail and rx_prepared_head cursors).
Otherwise gem_rx() could consume unallocated buffers.

Theoretical bugfix, never encountered in practice. To reproduce,
introduce memory pressure (less than 512 SKBs of free memory) and open
the interface.

Note that this codepath also hits at resume, on HRESP errors and on
set_ringparam (while interface is running).

Fixes: 4df95131ea80 ("net/macb: change RX path for GEM")
Cc: stable@vger.kernel.org
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 8e5c034dc3a4..7f25574928d7 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1596,6 +1596,13 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		dma_addr_t addr;
 		bool rxused;
 
+		/* Only descriptors in [rx_tail, rx_prepared_head) were armed
+		 * for hardware. Outside, we might have RX_USED descriptors for
+		 * alloc failures.
+		 */
+		if (queue->rx_tail == queue->rx_prepared_head)
+			break;
+
 		entry = macb_rx_ring_wrap(bp, queue->rx_tail);
 		desc = macb_rx_desc(queue, entry);
 
@@ -1859,6 +1866,10 @@ static bool macb_rx_pending(struct macb_queue *queue)
 	struct macb_dma_desc *desc;
 	unsigned int entry;
 
+	/* No armed descriptor left: nothing can be pending. */
+	if (macb_is_gem(bp) && queue->rx_tail == queue->rx_prepared_head)
+		return false;
+
 	entry = macb_rx_ring_wrap(bp, queue->rx_tail);
 	desc = macb_rx_desc(queue, entry);
 
@@ -2795,9 +2806,14 @@ static int macb_alloc(struct macb *bp)
 
 static void gem_init_rx_ring(struct macb_queue *queue)
 {
+	unsigned int i;
+
 	queue->rx_tail = 0;
 	queue->rx_prepared_head = 0;
 
+	for (i = 0; i < queue->bp->rx_ring_size; i++)
+		macb_rx_desc(queue, i)->addr |= MACB_BIT(RX_USED);
+
 	gem_rx_refill(queue);
 }
 

-- 
2.55.0

