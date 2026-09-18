Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385A84FDA68
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763560; cv=none; b=H3HqeQ0Vsja791bnSQhwJeBCObQUWei+B026jHezUnhacNt575BFI8ez+reSI7fkGfJys68blRTYa5e+Rc7ar822tpXQJUWu6sVy9/tqXEkKOXnrNMdkoP7EnVOk5gcLk1ExL1iWV4cQyliLXNnkIgVDeRycKdx0tManzvb1VnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763560; c=relaxed/simple;
	bh=lYVIRWYpEJbrhQ/oBp9dfFrspCsE0CzlZ1NBrrCWUHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mRfZ4w0IeZhOi7FhW4o1XbJalI58/U2zAU3STYnY4LRIT1ZlPVoyB435y9LUkTs4WwixuQ4Vq+HkwuJZuQs682XzTE9KmoxCZuNirl3vSRUnmFWfhbresdJCOATUfG7ad9tpH2ij5Hq8EKX3AvAGUaI3iXwuLL453viQqptQZJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bmwDgNBk; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bmwDgNBk"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D43234E40885;
	Fri, 18 Sep 2026 20:32:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A163F60649;
	Fri, 18 Sep 2026 20:32:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D05631032907F;
	Fri, 18 Sep 2026 22:32:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789763552; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KiYXgWSHGS4Z5hj8EXdVamYzUDB+odt7GHe4rRMG7F4=;
	b=bmwDgNBkkAgcSE8Vop2hXB0nwLRabo+2AURiZijWpL6i8fg7JXSD8aNrajTzlxCsSGlblf
	wbo5vRqJ6MRp30zP7mRmq+TY91g41vKRAEuwR9lxi7Xf/TxnjAvBEovP4lWDpxy0gMwCy6
	JN+N2L1k3DCi8ntiOu8kk/jEJXnFENBsdBBQ7RQDh3uMkBOy3kee2DEhjqy8xiFT2ckDPb
	Hc9b60xTi2gcW7UvkK7EmN673fJzRNpAcvJu6CJTfrV2pK3uXyuZ9ypdIzxHnYtFpvbDKw
	fk91mrbPHIUGH2GtPXdpmYkT137Y9JQ402CW375rcI5Di60FYzP/oHV+/6LXfA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 18 Sep 2026 22:32:04 +0200
Subject: [PATCH 3/3] net: macb: quiesce IRQs and drain BH on interface
 close
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260918-macb-close-v1-3-221d916b7961@bootlin.com>
References: <20260918-macb-close-v1-0-221d916b7961@bootlin.com>
In-Reply-To: <20260918-macb-close-v1-0-221d916b7961@bootlin.com>
To: Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Antoine Tenart <atenart@kernel.org>, Russell King <linux@armlinux.org.uk>
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

The macb_close() operation is facing races as it disables IRQs late in
its sequence and keeps BH primitives alive while shutdown.

Non exhaustive list of races that could occur:

 - macb_tx_error_task() could be scheduled and access the buffers freed
   by macb_close().

 - macb_tx_error_task() or macb_hresp_error_task() might re-enable
   interrupts after the IDR write in macb_close().

 - macb_close() calls napi_disable() meaning that if
   macb_tx_error_task() occurs later, it will deadlock on napi_disable()
   that shouldn't be called if NAPI is already disabled.

 - macb_hresp_error_task() might reinit every RX/TX ring under
   macb_close()'s foot.

 - macb_interrupt() might re-enable NAPI just after it has been
   disabled by macb_close().

Instead, disable all our primitives one by one:
 - (1) mask and sync on IRQ handlers,
 - (2) drain any scheduled bp->hresp_err_bh_work,
 - (3) drain any scheduled queue->tx_error_task,
 - (4) drain queue->napi_rx/napi_tx,
 - (5) drain bp->tx_lpi_work.

Careful! Ordering is important because our scheduling primitives can
wake each other up. Recap table:

|               |   enable/disable   |           schedule            |
|               |----|-------|-------|------|----|----|--------|-----|
|               |IRQs|napi_tx|napi_rx|tx_lpi|napi|napi|tx_error|hresp|
| Context       |    |       |       | task | rx | tx |  task  |task |
|===============|====|=======|=======|======|====|====|========|=====|
| open          | X  |   X   |   X   |      |    |    |        |     |
| link_up       | X  |       |       |      |    |    |        |     |
| link_down     | X  |       |       |      |    |    |        |     |
| close         | X  |   X   |   X   |      |    |    |        |     |
| enable_tx_lpi |    |       |       |  X   |    |    |        |     |
| swap          | X  |   X   |   X   |  X   |    |    |        |     |
| suspend       | X  |   X   |   X   |      |    |    |        |     |
| resume        | X  |   X   |   X   |      |    |    |        |     |
|---------------|----|-------|-------|------|----|----|--------|-----|
| irq & netpoll | X  |       |       |      | X  | X  |   X    | X   |
|---------------|----|-------|-------|------|----|----|--------|-----|
| napi_rx       | X  |       |       |      | X  |    |        |     |
| napi_tx       | X  |       |       |  X   |    | X  |        |     |
|---------------|----|-------|-------|------|----|----|--------|-----|
| tx_error_task | X  |   X   |       |      |    |    |        |     |
| hresp task    | X  |       |       |      |    |    |        |     |

As example, one ordering constraint that can be deduced from the table:
napi_tx can schedule tx_lpi_task meaning napi_tx must be disabled
before tx_lpi_task, else we risk napi_tx re-enabling tx_lpi_task after
it has been disabled by macb_close().

We do *not* use IDR masking to shutdown IRQs because that risks
conflicting with BH primitives we have not disabled yet. For example if
we writel(IDR) in macb_close() and napi_rx is pending then IRQs might
be unmasked by the NAPI poll. As for why we do not use disable_irq():
we will have situations where we are quiesced but want to listen to
some IRQs and (minor reason) we register shared IRQ handlers so we
shouldn't disable the full IRQ line.

Instead we introduce a bool that tells macb_interrupt() to self-disarm.
Its default value is true as we start closed. It gets set to false
while interface is active. Reading into my crystal ball, we'll reuse
that flag in suspend/WOL, set_ringparam and change_mtu (context swap).

Note that old IRQ handler tried preventing a race with close by
self-disarming based on netif_running(). This might work, but it does
not prevent a race with the error codepath of macb_open() which needs
to run with IRQs dis-armed but netif_running() returns true during that
time.

Fixes: e86cd53afc59 ("net/macb: better manage tx errors")
Cc: stable@vger.kernel.org
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |  5 ++
 drivers/net/ethernet/cadence/macb_main.c | 84 ++++++++++++++++++++++++--------
 2 files changed, 69 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index cfaa0ca49f1a..1cb2778fe49e 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1382,6 +1382,11 @@ struct macb {
 	struct delayed_work	tx_lpi_work;
 	u32			tx_lpi_timer;
 
+	/* ISR must not drive NAPI & BH mechanisms. True when the interface
+	 * is closed. Protected by bp->lock.
+	 */
+	bool			irq_quiesced;
+
 	int	rx_bd_rd_prefetch;
 	int	tx_bd_rd_prefetch;
 
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index c418f859cc34..75bbde81d62c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1995,6 +1995,53 @@ static int macb_tx_poll(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
+static void macb_quiesce_start(struct macb *bp)
+{
+	struct macb_queue *queue;
+	unsigned long flags;
+	unsigned int q;
+
+	spin_lock_irqsave(&bp->lock, flags);
+	bp->irq_quiesced = true;
+	spin_unlock_irqrestore(&bp->lock, flags);
+
+	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
+		synchronize_irq(queue->irq);
+
+	cancel_work_sync(&bp->hresp_err_bh_work);
+
+	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		/* Must be done before NAPI is disabled: the task ends with a
+		 * napi_enable() call.
+		 */
+		cancel_work_sync(&queue->tx_error_task);
+
+		napi_disable(&queue->napi_rx);
+		napi_disable(&queue->napi_tx);
+	}
+
+	/* Must be done after napi_tx is disabled: its completion re-arms
+	 * the LPI timer.
+	 */
+	cancel_delayed_work_sync(&bp->tx_lpi_work);
+}
+
+static void macb_quiesce_end(struct macb *bp)
+{
+	struct macb_queue *queue;
+	unsigned long flags;
+	unsigned int q;
+
+	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		napi_enable(&queue->napi_rx);
+		napi_enable(&queue->napi_tx);
+	}
+
+	spin_lock_irqsave(&bp->lock, flags);
+	bp->irq_quiesced = false;
+	spin_unlock_irqrestore(&bp->lock, flags);
+}
+
 static void macb_hresp_error_task(struct work_struct *work)
 {
 	struct macb *bp = from_work(bp, work, hresp_err_bh_work);
@@ -2137,8 +2184,8 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 	spin_lock(&bp->lock);
 
 	while (status) {
-		/* close possible race with dev_close */
-		if (unlikely(!netif_running(netdev))) {
+		/* self-disarm while the netdev is closed */
+		if (unlikely(bp->irq_quiesced)) {
 			queue_writel(queue, IDR, -1);
 			macb_queue_isr_clear(bp, queue, -1);
 			break;
@@ -3155,8 +3202,6 @@ static int macb_open(struct net_device *netdev)
 {
 	size_t bufsz = netdev->mtu + ETH_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;
 	struct macb *bp = netdev_priv(netdev);
-	struct macb_queue *queue;
-	unsigned int q;
 	int err;
 
 	netdev_dbg(bp->netdev, "open\n");
@@ -3180,10 +3225,7 @@ static int macb_open(struct net_device *netdev)
 		goto free_rings;
 	macb_init_buffers(bp);
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		napi_enable(&queue->napi_rx);
-		napi_enable(&queue->napi_tx);
-	}
+	macb_quiesce_end(bp);
 
 	macb_init_hw(bp);
 
@@ -3210,11 +3252,10 @@ static int macb_open(struct net_device *netdev)
 	phy_power_off(bp->phy);
 
 reset_hw:
+	/* The netdev stays down: quiesce and drain, as macb_close() does. */
+	macb_quiesce_start(bp);
+
 	macb_reset_hw(bp);
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		napi_disable(&queue->napi_rx);
-		napi_disable(&queue->napi_tx);
-	}
 free_rings:
 	macb_free(bp);
 pm_exit:
@@ -3225,19 +3266,17 @@ static int macb_open(struct net_device *netdev)
 static int macb_close(struct net_device *netdev)
 {
 	struct macb *bp = netdev_priv(netdev);
-	struct macb_queue *queue;
 	unsigned long flags;
 	unsigned int q;
 
+	macb_quiesce_start(bp);
+
+	/* Drain the BH contexts before stopping the queues: NAPI completion
+	 * and tx_error_task wake them up.
+	 */
 	netif_tx_stop_all_queues(netdev);
-
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		napi_disable(&queue->napi_rx);
-		napi_disable(&queue->napi_tx);
+	for (q = 0; q < bp->num_queues; ++q)
 		netdev_tx_reset_queue(netdev_get_tx_queue(netdev, q));
-	}
-
-	cancel_delayed_work_sync(&bp->tx_lpi_work);
 
 	phylink_stop(bp->phylink);
 	phylink_disconnect_phy(bp->phylink);
@@ -4759,6 +4798,11 @@ static int macb_init_dflt(struct platform_device *pdev)
 	bp->tx_ring_size = DEFAULT_TX_RING_SIZE;
 	bp->rx_ring_size = DEFAULT_RX_RING_SIZE;
 
+	/* No locking needed because the IRQs are not requested yet. The
+	 * flag is cleared by macb_open() and re-armed by macb_close().
+	 */
+	bp->irq_quiesced = true;
+
 	/* set the queue register mapping once for all: queue0 has a special
 	 * register mapping but we don't want to test the queue index then
 	 * compute the corresponding register offset at run time.

-- 
2.55.0

