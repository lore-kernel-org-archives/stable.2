Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F5247FAE6
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342271; cv=none; b=jDx3ZYl/qgYhZC5qCOE2JEru+Nn1LPkF/9dJ+BJ65drBXn16iMrxdS9+ezHv0RgwuTlNsg19AvH7zXWFs9jYGkUdKiRtjKC6d1qaY+GfCtD1lreS0rEpxndBPXXhJb3shh2iVPs8cOPKDlEWZiN0VtYQMThaMP5xCW0j9bYONxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342271; c=relaxed/simple;
	bh=kU161W7iv6FLfblTtPo5+ExwydhzcpeZRLyKF2s6Vkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+fWU21ktsohVds2Fq0vBRpaAh9gr03BRDUrJsXRuJBLv8F+R2E561UUo28GXKHpB2HqpDLH4ZO5Gpn6znsTl1sfEoQgiNW0cGlXL/idsyQN2MRveaZXl39f7d4zWCpjKSlTS5N9Cyip7HYiBWwEWHrE/f0E/WMoCi44dxugTdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mh8rZsBw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mh8rZsBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E8A1F00A3A;
	Wed, 29 Jul 2026 16:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785342269;
	bh=8WeGqHylFean/C0JVRUgYauKvdT9ptvOTk+STI3GxBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mh8rZsBwzlgujpzMTaqHZOePwWSmo8FT/lEi9icruIrXq7Qs43sgNJzteUN+3M8ab
	 zEF1p+/RSjprFfo501sjaFbmdK5aW5xmABRN1FrMYyuESQcrfsBk8jHd7a7HJegM+P
	 db9nzmDetwFK7aqhCBST7B6yQDLOtfn9D37MG4EfR0R/zTAMG4FgeyMa6kM0ZTqj+N
	 77r1LACrauy58poow9BEWlzn1JTi/hactgJH3y7CkerZ6mlaF78o/uRSlprtczI2kj
	 qgVXaFlWeHX40uhXbRcG4iMSg75PsGb2tLmw1UkoCzMGwercZGeFlWy9jddT3KQjH6
	 SFJPa645RXwBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Robert Hancock <robert.hancock@calian.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/6] net: macb: simplify/cleanup NAPI reschedule checking
Date: Wed, 29 Jul 2026 12:24:22 -0400
Message-ID: <20260729162427.3522161-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072141-overrate-gratified-54e6@gregkh>
References: <2026072141-overrate-gratified-54e6@gregkh>
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
index 74e4b28e21cbdc..3d431132bc0216 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1626,54 +1626,51 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
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

