Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661952;
	b=TeAHjzmFSawgIKRRp32A5oaFx8aWYfeTM2PkJM2TvvFkbt2YO0tBfreFuHNfoIcZYjrz
	 rpOk6xUgeXbpXEcajWnFKO8t19FDApbx3Yi0lOn6PWvgPsXniUAfVdPszNuyPNVCA89Ss
	 yuRT0QTEEMQyVf25ZT9995aBxLRjkYQDTjdh+78SjiYvE4I7ZXYhDAt6+e88+SuIiRbjc
	 86S9oQlMV1Rt4SCP2rvuIsw8xsEAovwYusSP3EHqW2daK+LBrsIX4QuNBueE+soMO87YZ
	 mK8rPWCYKtSnMIVnWeQp+XVGlzeuM6WP5QnRmH2hUPcyrA0BLwz3ZfuqrWopjDSwCkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661952;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Rspamd-Queue-Id;
	bh=Omxv2Mm8QufsZ7qulUJXdVEh66B2cIV2QhPW4FgWnTE=;
	b=bGXkUXT3A/NXNOqWJ5i6Brsnb394AhfZVTUfFPk1jp8ZxXIuoSMn9QrCQ4aEHj76jirX
	 IalhfDV3NmVZGvYuWdNwMYbRg+0QJ6Ye0bwTM8Pez1wAofH5Dv3/KEE6+Q0R/UimrBqKF
	 7t90/HhV/0ugw96JzE+Nx5HtqqP5UZ1MROv6dFgzd/rgQWNdJFsbXwiAoZc04EbXHogo3
	 DW10AGJrASrM1NjIr9kWk9j2NVK8ZAG30RTpg3TzOA8zZpp5Q6dCshi3B3nDYSA0xU9Ri
	 FsHEQkvViq87GLKq5Z31zllXBre6Oa9PbKcb6FJTqrWOPMZaHmfscgaRYQjBCwaboNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=steffen.cc;
	spf=pass smtp.mailfrom=steffen.cc;
	dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=LqashFgF;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4FE60A261B;
	Thu, 22 Oct 2026 09:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C4FE60A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=LqashFgF
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j9LhD0Hz3zMljH;
	Thu, 22 Oct 2026 11:39:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1792661948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Omxv2Mm8QufsZ7qulUJXdVEh66B2cIV2QhPW4FgWnTE=;
	b=LqashFgF/yJ+c5ct6+HTVskDLtlI+t7FFP7iMsyr9eXXGenk5H+0Kl+VrMsPFP68QSzamq
	VtZ0MJSzjZ61Lxjor6q13Gbr3hf5niB0NWQ6zqGwGnp0PGPQrcxJWXH7bJC0I1C5Krj++l
	IemLsNk6ctv1Jqk6kA8FnqGKyHmDTWx+D5IKGufzK39fnBmt9gw+HtHjlqXG17ODxre7Ke
	w+itnRMZvjXK4urXLVTVV1NttCC6gqV6+U+y9S0N1i91TdL1yNwQ9yEwiB1WoeAYUgKXr9
	/OLbnHviWnskTGbVv3cXjV7Xq7muPZ4brjpPMNslTOI5MY1YhQeLo+ncc0la2g==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Thu, 22 Oct 2026 11:38:49 +0200
Subject: [PATCH RFC net 4/6] net: macb: rotate unreaped TX frames behind
 the ring base on link-up
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-std-macb-v14-send-v1-4-9187bc545bf6@beckhoff.com>
References: <20261022-std-macb-v14-send-v1-0-9187bc545bf6@beckhoff.com>
In-Reply-To: <20261022-std-macb-v14-send-v1-0-9187bc545bf6@beckhoff.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Kevin Hao <haokexin@gmail.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 Christian Taedcke <christian.taedcke@weidmueller.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Andrea della Porta <andrea.porta@suse.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792661936; l=4726;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=0viIiPU5WIpc/1LXbcjtKBH7YCYP4VkmvYvGZraIf5U=;
 b=rruHMCKOATDsnv/RfRgb5KzHk+BU3c3Locf39Q0+WJOX3wtjJbbOEzTXEFYodbQvRYrL6UNxe
 yCTIwqVKMofCCZrkUIgara9UD9XX8daqiqRZSew5ocVT5o80kt0Ed+B
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4j9LhD0Hz3zMljH

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

Start the link-up rotation in gem_shuffle_tx_one_ring() at the first
frame that still has to be sent instead of at tx_tail, and schedule the
TX NAPI poll once transmit is enabled again.

macb_mac_link_down() masks TCOMP before disabling transmit. A frame
completed in that window keeps the used bit on its first descriptor and
is never reaped. The rotation moves it to index 0, where the controller
starts after link-up, reads the used bit and stops; macb_tx_restart()
then keeps writing TSTART onto the same descriptor, an interrupt storm
that on PREEMPT_RT ends in RCU stalls.

Keeping the completed frames behind the ring base leaves tx_tail on
them for NAPI to reap. Reaping in link-down instead would have to wait
for NAPI there, which deadlocks against macb_close() and the PM
callbacks disabling it.

Fixes: 881a0263d502 ("net: macb: Shuffle the tx ring before enabling tx")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 43 +++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 14c8299cb7f3..6e7ead23d0b7 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -798,7 +798,7 @@ static void macb_mac_link_down(struct phylink_config *config, unsigned int mode,
 /* Use juggling algorithm to left rotate tx ring and tx skb array */
 static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 {
-	unsigned int head, tail, count, ring_size, desc_size;
+	unsigned int head, tail, count, ring_size, desc_size, start, done;
 	struct macb_tx_skb tx_skb, *skb_curr, *skb_next;
 	struct macb_dma_desc *desc_curr, *desc_next;
 	unsigned int i, cycles, shift, curr, next;
@@ -817,8 +817,19 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 	ring_size = bp->tx_ring_size;
 	count = CIRC_CNT(head, tail, ring_size);
 
-	if (!(tail % ring_size))
-		goto unlock;
+	/* Frames completed while link-down had TCOMP masked are still
+	 * unreaped and their used bit would stop the controller at the ring
+	 * base, so rotate the first frame still to be sent there instead.
+	 */
+	rmb();
+	for (start = tail; start != head &&
+	     (macb_tx_desc(queue, start)->ctrl & MACB_BIT(TX_USED)); start++)
+		while (start + 1 != head && !macb_tx_skb(queue, start)->skb)
+			start++;
+	done = start - tail;
+
+	if (!(start % ring_size))
+		goto reset_hw_ptr;
 
 	if (!count) {
 		queue->tx_head = 0;
@@ -826,7 +837,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 		goto reset_hw_ptr;
 	}
 
-	shift = tail % ring_size;
+	shift = start % ring_size;
 	cycles = gcd(ring_size, shift);
 
 	for (i = 0; i < cycles; i++) {
@@ -866,24 +877,23 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 		       sizeof(struct macb_tx_skb));
 	}
 
-	queue->tx_head = count;
-	queue->tx_tail = 0;
+	queue->tx_tail = done ? ring_size - done : 0;
+	queue->tx_head = queue->tx_tail + count;
 
 	/* Make descriptor updates visible to hardware */
 	wmb();
 
 reset_hw_ptr:
-	/* tx_tail was reset to the ring base, so TBQP must be reprogrammed
-	 * to match; otherwise it keeps pointing at a stale descriptor. Safe
-	 * to write directly here as TX is still disabled (called from
-	 * macb_mac_link_up() before TE is set).
+	/* The first frame to be sent is now at the ring base, so TBQP must
+	 * be reprogrammed to match; otherwise it keeps pointing at a stale
+	 * descriptor. Safe to write directly here as TX is still disabled
+	 * (called from macb_mac_link_up() before TE is set).
 	 */
 	queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
-unlock:
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 }
 
-/* Rotate the queue so that the tail is at index 0 */
+/* Rotate the queue so that the first frame to be sent is at index 0 */
 static void gem_shuffle_tx_rings(struct macb *bp)
 {
 	struct macb_queue *queue;
@@ -958,6 +968,15 @@ static void macb_mac_link_up(struct phylink_config *config,
 	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
 	spin_unlock_irqrestore(&bp->lock, flags);
 
+	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
+		/* Reap the frames completed while link-down had TCOMP masked */
+		local_bh_disable();
+		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
+			if (READ_ONCE(queue->tx_tail) != READ_ONCE(queue->tx_head))
+				napi_schedule(&queue->napi_tx);
+		local_bh_enable();
+	}
+
 	netif_tx_wake_all_queues(netdev);
 }
 

-- 
2.56.0

