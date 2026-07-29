Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE4A469855
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344275; cv=none; b=XjTu5Da6DFxeEiX12IXS5J2/4UXxTwVn4qFQ745iqtk0hcNoEjo6lhHI1G9MBaxuaUIWd6VZ3ksOoAgjJlfZKz5EoskpUaaAqORmgVjyx/jty2cM2153y176F/oKYsmw6ukvp+9ePVWfsaecdbJ20FiprITeE9xwFwNb7cAoTMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344275; c=relaxed/simple;
	bh=AEpZgj+qOty3aF9Vb4JTmEWQ8nTXLuYQl6xPt4PPRks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncVRjs6U3HUt1QpX1PA6MgFVsqm4BLqnJTtTZ+qrGNPTTy8cX2b0d9FqTM1T8a4QyhYZ04j4Azjbf8XLI9rkY4RLmBOF4rYi2eBYBRyXuJEeduIMwHxglvv6uegzMb72RRUUoXOEMpmhX9EOmthIjysVdkvbCV/Mqv0jFtRWlI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCmnnkvB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCmnnkvB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210261F00A3A;
	Wed, 29 Jul 2026 16:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785344272;
	bh=x1FDWZP0YzQqxyL0x/wPCJzwOtj1UXXom8mRY4N2kAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nCmnnkvBD2o1zNpq7Xj465xD2IX1etSOK4EumqT+Z/3eqO2BJcnTFYgUBjSQpsLN0
	 vKDrxNF0EuCgwUi/qVwqc1I5zRtAEAcuVXUNvpN0quVXAdduFsFKtP8YjlY2Yu3A6i
	 yDafFuFQ73sJc2HTCWk0eOi/qe4Tp2Wqmds2aucbrKBEbBc5qaIUDW6MjreexnEt3k
	 mOxvaYEvjvANpZpi+kev1QQtrG9vCn7FVoHj4qcU6Zqr9WmykZP4T/IG2f/fv0nRjm
	 XmmxaHfqbBpizQg68yjnCMk4z63/4WTQVlSmJMPsSdkoETJzC2fzRKQqqufqHR48V6
	 3CVTQBOUV77Dw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Robert Hancock <robert.hancock@calian.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/6] net: macb: use NAPI for TX completion path
Date: Wed, 29 Jul 2026 12:57:45 -0400
Message-ID: <20260729165749.3661232-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729165749.3661232-1-sashal@kernel.org>
References: <2026072142-acorn-watch-76da@gregkh>
 <20260729165749.3661232-1-sashal@kernel.org>
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
index 3dbef49b17668c..b116d6778f8f90 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -837,7 +837,7 @@ static int macb_halt_tx(struct macb *bp)
 					bp, TSR);
 }
 
-static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb)
+static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb, int budget)
 {
 	if (tx_skb->mapping) {
 		if (tx_skb->mapped_as_page)
@@ -850,7 +850,7 @@ static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb)
 	}
 
 	if (tx_skb->skb) {
-		dev_kfree_skb_any(tx_skb->skb);
+		napi_consume_skb(tx_skb->skb, budget);
 		tx_skb->skb = NULL;
 	}
 }
@@ -940,7 +940,7 @@ static void macb_tx_error_task(struct work_struct *work)
 		if (ctrl & MACB_BIT(TX_USED)) {
 			/* skb is set for the last buffer of the frame */
 			while (!skb) {
-				macb_tx_unmap(bp, tx_skb);
+				macb_tx_unmap(bp, tx_skb, 0);
 				tail++;
 				tx_skb = macb_tx_skb(queue, tail);
 				skb = tx_skb->skb;
@@ -970,7 +970,7 @@ static void macb_tx_error_task(struct work_struct *work)
 			desc->ctrl = ctrl | MACB_BIT(TX_USED);
 		}
 
-		macb_tx_unmap(bp, tx_skb);
+		macb_tx_unmap(bp, tx_skb, 0);
 	}
 
 	/* Set end of TX queue */
@@ -1064,7 +1064,7 @@ static void macb_tx_interrupt(struct macb_queue *queue)
 			}
 
 			/* Now we can safely release resources */
-			macb_tx_unmap(bp, tx_skb);
+			macb_tx_unmap(bp, tx_skb, 0);
 
 			/* skb is set only for the last buffer of the frame.
 			 * WARNING: at this point skb has been freed by
@@ -1903,7 +1903,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 	for (i = queue->tx_head; i != tx_head; i++) {
 		tx_skb = macb_tx_skb(queue, i);
 
-		macb_tx_unmap(bp, tx_skb);
+		macb_tx_unmap(bp, tx_skb, 0);
 	}
 
 	return 0;
-- 
2.53.0

