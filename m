Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452D44A9D42;
	Fri, 25 Sep 2026 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344817; cv=none; b=HjUfoqPmoacz/XF42L1zku5va8BlUepPGWpMl8oh237KSJEQRcz1FDRYSji+pmx8htrp+rFyrPhsISNQyPGOmzGYf2kt2vgKudHUJc/d+rz/jlq7qfW0ohEZ7ui7foZi8JjBfJVUxUow1CNlLRvpx62Z4Z5TAN2PLbanJBhXGGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344817; c=relaxed/simple;
	bh=BgwPVGM5htdEbSVqgbrxWN2+UbA/R66GdTOSA9Cbnt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t5WkyjcJl6Jk9Y7bcpVAp8UyEW2NZm+Fh8Sw8Z+85nzfvfYt0F6M6cbU6gr8ryK8SbY+W6in3gzsK1YCawrXFcqLJvH7OHs0b4ne2HNzup0vPGitTy0Y0z+PS/bLky8PZIh6+xhV5OSPEx5kmTayelBsYZCXmI1S0col+FkvOTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cO68NurB; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cO68NurB"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4588F4E41072;
	Fri, 25 Sep 2026 14:00:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 17D2F6073B;
	Fri, 25 Sep 2026 14:00:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 43C1B10329527;
	Fri, 25 Sep 2026 16:00:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790344802; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aHr2jhlS0HazH4+CNkOfPqlvGH22UoWzJoaXrl82ZXE=;
	b=cO68NurB24nOc8B6bUGUQfpcsoD5zBeULOS+x8G5Peqv7dEykOPmCFUxSElZzE7wO9OFAA
	WtxXhsvkDVLP3E0vmIfuKkiK3rr/Tub2zY2Ju7wXGRFct2fkH8o/MgqDK4Zkewp4Bi80zG
	A7EgmfEw/vk4PzXpyRo2nQZm+eiRwTsCnZ7cfqlN4Y9h1jee6xqoPaJ2X6suh/zdfdJF4a
	K2F1cVnjS0sJu9AnOR9mzKtTlLWUYxQMM+CLCbpktC3t1VcojiSVP2+ju3a4gun9oLntkq
	nZM5FIfX2b4dHyBRHEHRYUUWIWlqGagtD8qtjCplwDSmd4/b6jvDSnaCebSGyg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 25 Sep 2026 15:59:36 +0200
Subject: [PATCH net v2 3/3] net: macb: quiesce IRQs and drain BH on
 interface close
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260925-macb-close-v2-3-360efa565914@bootlin.com>
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
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
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
index 18a1b5f7ad91..1d6361c0d8bc 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2009,6 +2009,53 @@ static int macb_tx_poll(struct napi_struct *napi, int budget)
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
@@ -2151,8 +2198,8 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 	spin_lock(&bp->lock);
 
 	while (status) {
-		/* close possible race with dev_close */
-		if (unlikely(!netif_running(netdev))) {
+		/* self-disarm while the netdev is closed */
+		if (unlikely(bp->irq_quiesced)) {
 			queue_writel(queue, IDR, -1);
 			macb_queue_isr_clear(bp, queue, -1);
 			break;
@@ -3179,8 +3226,6 @@ static int macb_open(struct net_device *netdev)
 {
 	size_t bufsz = netdev->mtu + ETH_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;
 	struct macb *bp = netdev_priv(netdev);
-	struct macb_queue *queue;
-	unsigned int q;
 	int err;
 
 	netdev_dbg(bp->netdev, "open\n");
@@ -3204,10 +3249,7 @@ static int macb_open(struct net_device *netdev)
 		goto free_rings;
 	macb_init_buffers(bp);
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		napi_enable(&queue->napi_rx);
-		napi_enable(&queue->napi_tx);
-	}
+	macb_quiesce_end(bp);
 
 	macb_init_hw(bp);
 
@@ -3234,11 +3276,10 @@ static int macb_open(struct net_device *netdev)
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
@@ -3249,19 +3290,17 @@ static int macb_open(struct net_device *netdev)
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
@@ -4783,6 +4822,11 @@ static int macb_init_dflt(struct platform_device *pdev)
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

