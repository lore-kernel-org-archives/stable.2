Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03E8488747
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342272; cv=none; b=CWc1JN/v0sGaz3XPcKNociL1bKuH5HRmy03mxb0i7y1/yKm+IjcTY1Qlu8/hxoJL/RlnoruLcqWKfeFSKsWxizyCBIrounNRLgDuDhCMasBM5fiwXxCADt58OMqjCC7BFPTgClxnRoO6/TqWTNEwV1kiIWR6C49hTlZhkiphl0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342272; c=relaxed/simple;
	bh=Ewe5XgbhH3r2o0PJXetfG/vW8SpPlTDL6f4NoHshN8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4Qx+wG0aroptp1OSGdJrn+peZz/TrkrsaU2+VQeZddKSFe6PfPqJwGI07XDwnr1OyYeX0x6TZYTRzuZGzLPLdi+8gRgEI3iuC4ZJuZjsU7ms0Kr+vkwZX1Alb/5OTIMpIEZmYiDbX7PDP+1qBc4NVe0RvhkGbWK9+ma8nmkjzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCRVjYQK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCRVjYQK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C111F000E9;
	Wed, 29 Jul 2026 16:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785342270;
	bh=0W6+rvB357PjWIJLLmN2lBmMpEA+lw0gMWr2ZUiBgIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GCRVjYQKgwMHp5xlA83+ZPSaNeT2CD21e08lTS2Nu/QYUglXbOgpx33e2fwnscfYq
	 AamGZ8JdYS6NkTB0eawFNu3HwUnZVnYXR2B0SEmnwu/9RKXLQlXkqpifOY1zlJEsze
	 xwZLAA3/yeTIFTkJ3sDe/C3kVh1nxsx2/dwKjWYtgU9c86wjobxvImy+9foNEYeLDF
	 A1fpEEbJgNh1CePCAiWWYP4ec0uQU+47v3q4FDagEi2en+AoqvAwOJAiU0E4c/Hk4+
	 13P5CKtZn3fKaiEvViFM/VQD0Udm8KPyQ5tKj7/XBqTOGPO6SCnLIe5zkaW9IDZ56u
	 aewE5VpU3nhHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Robert Hancock <robert.hancock@calian.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/6] net: macb: use NAPI for TX completion path
Date: Wed, 29 Jul 2026 12:24:23 -0400
Message-ID: <20260729162427.3522161-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729162427.3522161-1-sashal@kernel.org>
References: <2026072141-overrate-gratified-54e6@gregkh>
 <20260729162427.3522161-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Robert Hancock <robert.hancock@calian.com>

[ Upstream commit 138badbc21a0113ce783270c426210d6451da5d1 ]

This driver was using the TX IRQ handler to perform all TX completion
tasks. Under heavy TX network load, this can cause significant irqs-off
latencies (found to be in the hundreds of microseconds using ftrace).
This can cause other issues, such as overrunning serial UART FIFOs when
using high baud rates with limited UART FIFO sizes.

Switch to using a NAPI poll handler to perform the TX completion work
to get this out of hard IRQ context and avoid the IRQ latency impact. A
separate NAPI instance is used for TX and RX to avoid checking the other
ring's state unnecessarily when doing the poll, and so that the NAPI
budget handling can work for both TX and RX packets.

A new per-queue tx_ptr_lock spinlock has been added to avoid using the
main device lock (with IRQs needing to be disabled) across the entire TX
mapping operation, and also to protect the TX queue pointers from
concurrent access between the TX start and TX poll operations.

The TX Used Bit Read interrupt (TXUBR) handling also needs to be moved into
the TX NAPI poll handler to maintain the proper order of operations. A flag
is used to notify the poll handler that a UBR condition needs to be
handled. The macb_tx_restart handler has had some locking added for global
register access, since this could now potentially happen concurrently on
different queues.

Signed-off-by: Robert Hancock <robert.hancock@calian.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 27f575836cfe ("net: macb: drop in-flight Tx SKBs on close")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 3d431132bc0216..42a2a768fa64e6 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -997,7 +997,7 @@ static int macb_halt_tx(struct macb *bp)
 					bp, TSR);
 }
 
-static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb)
+static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb, int budget)
 {
 	if (tx_skb->mapping) {
 		if (tx_skb->mapped_as_page)
@@ -1010,7 +1010,7 @@ static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb)
 	}
 
 	if (tx_skb->skb) {
-		dev_kfree_skb_any(tx_skb->skb);
+		napi_consume_skb(tx_skb->skb, budget);
 		tx_skb->skb = NULL;
 	}
 }
@@ -1100,7 +1100,7 @@ static void macb_tx_error_task(struct work_struct *work)
 		if (ctrl & MACB_BIT(TX_USED)) {
 			/* skb is set for the last buffer of the frame */
 			while (!skb) {
-				macb_tx_unmap(bp, tx_skb);
+				macb_tx_unmap(bp, tx_skb, 0);
 				tail++;
 				tx_skb = macb_tx_skb(queue, tail);
 				skb = tx_skb->skb;
@@ -1130,7 +1130,7 @@ static void macb_tx_error_task(struct work_struct *work)
 			desc->ctrl = ctrl | MACB_BIT(TX_USED);
 		}
 
-		macb_tx_unmap(bp, tx_skb);
+		macb_tx_unmap(bp, tx_skb, 0);
 	}
 
 	/* Set end of TX queue */
@@ -1254,7 +1254,7 @@ static void macb_tx_interrupt(struct macb_queue *queue)
 			}
 
 			/* Now we can safely release resources */
-			macb_tx_unmap(bp, tx_skb);
+			macb_tx_unmap(bp, tx_skb, 0);
 
 			/* skb is set only for the last buffer of the frame.
 			 * WARNING: at this point skb has been freed by
@@ -2094,7 +2094,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 	for (i = queue->tx_head; i != tx_head; i++) {
 		tx_skb = macb_tx_skb(queue, i);
 
-		macb_tx_unmap(bp, tx_skb);
+		macb_tx_unmap(bp, tx_skb, 0);
 	}
 
 	return 0;
-- 
2.53.0

