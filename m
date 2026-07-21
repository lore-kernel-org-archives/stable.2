Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDA73B7B9D
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625291; cv=none; b=trIxwGq0iA9aywH9aubUgcdG7yKDfEqWaxz8CUlZkRgMA5a9WIf/StcXOpq9tOVwkVv4UDpr3zOcxExNu6gkQwiQ6Wa2GimZKFyfF2pIJ27+VHeL1LYgSp4un/8wgQqo5+kcBmFk3SvypIXovMap2Tp4zYmmaSdRMYJAIvoaVtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625291; c=relaxed/simple;
	bh=x3OR9rv7uqe0Fpn15TIer4PHtI2xwW5kvuxQ6SgVhcI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=A1eZyU03sRMgojXYNVTXOKmSVwBCNr9mmYdJhEUjRthtdLWjjrKY5eG3Vp9cc4/FgLx5HBOqOW+p5OhsJULPpcy32opCw1gPa+REgkj/ucnEGaAyCuAwx3RUkcqo6Jz3hTBPhI6PV1oN7tPZ+3a9FUlAVO4ZabFP5qBY3z5PT/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NI9mdCQG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NI9mdCQG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2951F000E9;
	Tue, 21 Jul 2026 09:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784625290;
	bh=HOj6SHmLyFzanCI7CRT/tokOriVaRDGll4+piMA/bgs=;
	h=Subject:To:Cc:From:Date;
	b=NI9mdCQGblKSOAXjxPbJcu2q3JREeD6MgQlMFtRM8P+DAVLvmuLEgcrlscuv0B0W4
	 9RN13/3Dzw2kMOqN1Zl0CdC3SsvKFr8stxBsovmlbDCewkA9ZDv8HFfvB0UTnT6VVd
	 jr+UZSnEnyHMAiwm0Xp2WbJhCrMljf2eMQ+onZSE=
Subject: FAILED: patch "[PATCH] net: macb: drop in-flight Tx SKBs on close" failed to apply to 6.12-stable tree
To: theo.lebrun@bootlin.com,nb@tipi-net.de,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:14:41 +0200
Message-ID: <2026072140-catacomb-activator-d955@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 27f575836cfebbf872dec020428742b10650a955
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072140-catacomb-activator-d955@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 27f575836cfebbf872dec020428742b10650a955 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 2 Jul 2026 17:37:02 +0200
Subject: [PATCH] net: macb: drop in-flight Tx SKBs on close
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The MACB driver has since forever leaked the outgoing SKBs that
have not yet been marked as completed. They live in queue->tx_skb
which gets freed without remorse nor checking.

macb_free_consistent() gets called in a few codepaths, but only close will
trigger the added expressions. In macb_open() and macb_alloc_consistent()
failure cases, queues' tx_skb just got allocated and are empty.

Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
Cc: stable@vger.kernel.org
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Link: https://patch.msgid.link/20260702-macb-drop-tx-v4-1-1c833eebdbc8@bootlin.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index fd282a1700fb..d394f1f43b68 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2668,8 +2668,25 @@ static void macb_free_consistent(struct macb *bp)
 	dma_free_coherent(dev, size, bp->queues[0].rx_ring, bp->queues[0].rx_ring_dma);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		kfree(queue->tx_skb);
-		queue->tx_skb = NULL;
+		if (queue->tx_skb) {
+			unsigned int dropped = 0, tail;
+
+			for (tail = queue->tx_tail; tail != queue->tx_head;
+			     tail++) {
+				if (macb_tx_skb(queue, tail)->skb)
+					dropped++;
+				macb_tx_unmap(bp, macb_tx_skb(queue, tail), 0);
+			}
+
+			queue->stats.tx_dropped += dropped;
+			bp->dev->stats.tx_dropped += dropped;
+
+			kfree(queue->tx_skb);
+			queue->tx_skb = NULL;
+		}
+
+		queue->tx_head = 0;
+		queue->tx_tail = 0;
 		queue->tx_ring = NULL;
 		queue->rx_ring = NULL;
 	}

