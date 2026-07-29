Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735BB1E515
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344274; cv=none; b=AJNF/Q8EWKWSemNOsyzZSlRLgEfiu1GnCBs93LJankpRdvid8XsBfx2jzmNaMhTXDPdchtqW3c9UuMNxy7gWV+vdgGGEDSPh+8mLd9sdQgErE8XLP6K/n1QAYl0LqnbiMvmH+vCVYGKiwyMRCBcGnai+z8Jj+Mm/h8t/4XdEGus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344274; c=relaxed/simple;
	bh=ls/PIgmxENchnfD0BaxZuHoQuP7hVhQT2Q7kZhuh6IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gj8grsWLuiUQfhlBMKEEdJwoatabGbw6oIJCKJatAEy1Hz/diYFIYdndXSvrIlL6NmfjUYNPKudig7r+bcVrBvS9dM6r7VyW7CCDx8KD2mz2D3Plzc4KsRslOwevsh+MTAKWWkHhgRuXUoeoM1nasggOe11EaHlq1UFwNpPErpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1q7FYTU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1q7FYTU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B831F000E9;
	Wed, 29 Jul 2026 16:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785344271;
	bh=mI4rR2EXoUbC1iWAJmLgBA4oFG3Om0NVyqi7Q2XGpgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U1q7FYTUvkeTLntYzuM7jKEgYmmHjWmr8imzPvdSLW2gpU/JrEdRIs7Rrv7Wxipct
	 aiLiIR3sarp5veMWLeJY8CT9Kkc7JFo63Y3hlPV0jmim5cXsOr0tx4BwEb1mpJWDv7
	 YcOhQODvVJ9jL0MDSrpz1cxilvy4PhBNvtBAOv8+QhW7gaS3s62ZOup9EvlRo2SrRb
	 OqdIqrphAcHTkDWRGPW17Knz/wp4e2JW6Ssfnn/AOv2TC9ldUuCjeFm6SAkItrSY4E
	 zhbqwlduADYOSksIz8Bc4yZpks2UZdnl2s31QeXjiWagXxc+bMxWfHdFeYFaCBUITn
	 5NzYn8tstfOeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Robert Hancock <robert.hancock@calian.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/6] net: macb: simplify/cleanup NAPI reschedule checking
Date: Wed, 29 Jul 2026 12:57:44 -0400
Message-ID: <20260729165749.3661232-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072142-acorn-watch-76da@gregkh>
References: <2026072142-acorn-watch-76da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Robert Hancock <robert.hancock@calian.com>

[ Upstream commit 1900e30d0ef74755213811cc23079b1be51298fe ]

Previously the macb_poll method was checking the RSR register after
completing its RX receive work to see if additional packets had been
received since IRQs were disabled, since this controller does not
maintain the pending IRQ status across IRQ disable. It also had to
double-check the register after re-enabling IRQs to detect if packets
were received after the first check but before IRQs were enabled.

Using the RSR register for this purpose is problematic since it reflects
the global device state rather than the per-queue state, so if packets
are being received on multiple queues it may end up retriggering receive
on a queue where the packets did not actually arrive and not on the one
where they did arrive. This will also cause problems with an upcoming
change to use NAPI for the TX path where use of multiple queues is more
likely.

Add a macb_rx_pending function to check the RX ring to see if more
packets have arrived in the queue, and use that to check if NAPI should
be rescheduled rather than the RSR register. By doing this, we can just
ignore the global RSR register entirely, and thus save some extra device
register accesses at the same time.

This also makes the previous first check for pending packets rather
redundant, since it would be checking the RX ring state which was just
checked in the receive work function. Therefore we can get rid of it and
just check after enabling interrupts whether packets are already
pending.

Signed-off-by: Robert Hancock <robert.hancock@calian.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 27f575836cfe ("net: macb: drop in-flight Tx SKBs on close")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 65 +++++++++++-------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 8751d6ea9a5e81..3dbef49b17668c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1436,54 +1436,51 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 	return received;
 }
 
+static bool macb_rx_pending(struct macb_queue *queue)
+{
+	struct macb *bp = queue->bp;
+	unsigned int		entry;
+	struct macb_dma_desc	*desc;
+
+	entry = macb_rx_ring_wrap(bp, queue->rx_tail);
+	desc = macb_rx_desc(queue, entry);
+
+	/* Make hw descriptor updates visible to CPU */
+	rmb();
+
+	return (desc->addr & MACB_BIT(RX_USED)) != 0;
+}
+
 static int macb_poll(struct napi_struct *napi, int budget)
 {
 	struct macb_queue *queue = container_of(napi, struct macb_queue, napi);
 	struct macb *bp = queue->bp;
 	int work_done;
-	u32 status;
 
-	status = macb_readl(bp, RSR);
-	macb_writel(bp, RSR, status);
+	work_done = bp->macbgem_ops.mog_rx(queue, napi, budget);
 
-	netdev_vdbg(bp->dev, "poll: status = %08lx, budget = %d\n",
-		    (unsigned long)status, budget);
+	netdev_vdbg(bp->dev, "poll: queue = %u, work_done = %d, budget = %d\n",
+		    (unsigned int)(queue - bp->queues), work_done, budget);
 
-	work_done = bp->macbgem_ops.mog_rx(queue, napi, budget);
-	if (work_done < budget) {
-		napi_complete_done(napi, work_done);
+	if (work_done < budget && napi_complete_done(napi, work_done)) {
+		queue_writel(queue, IER, bp->rx_intr_mask);
 
-		/* RSR bits only seem to propagate to raise interrupts when
-		 * interrupts are enabled at the time, so if bits are already
-		 * set due to packets received while interrupts were disabled,
+		/* Packet completions only seem to propagate to raise
+		 * interrupts when interrupts are enabled at the time, so if
+		 * packets were received while interrupts were disabled,
 		 * they will not cause another interrupt to be generated when
 		 * interrupts are re-enabled.
-		 * Check for this case here. This has been seen to happen
-		 * around 30% of the time under heavy network load.
+		 * Check for this case here to avoid losing a wakeup. This can
+		 * potentially race with the interrupt handler doing the same
+		 * actions if an interrupt is raised just after enabling them,
+		 * but this should be harmless.
 		 */
-		status = macb_readl(bp, RSR);
-		if (status) {
+		if (macb_rx_pending(queue)) {
+			queue_writel(queue, IDR, bp->rx_intr_mask);
 			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
 				queue_writel(queue, ISR, MACB_BIT(RCOMP));
-			napi_reschedule(napi);
-		} else {
-			queue_writel(queue, IER, bp->rx_intr_mask);
-
-			/* In rare cases, packets could have been received in
-			 * the window between the check above and re-enabling
-			 * interrupts. Therefore, a double-check is required
-			 * to avoid losing a wakeup. This can potentially race
-			 * with the interrupt handler doing the same actions
-			 * if an interrupt is raised just after enabling them,
-			 * but this should be harmless.
-			 */
-			status = macb_readl(bp, RSR);
-			if (unlikely(status)) {
-				queue_writel(queue, IDR, bp->rx_intr_mask);
-				if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
-					queue_writel(queue, ISR, MACB_BIT(RCOMP));
-				napi_schedule(napi);
-			}
+			netdev_vdbg(bp->dev, "poll: packets pending, reschedule\n");
+			napi_schedule(napi);
 		}
 	}
 
-- 
2.53.0

