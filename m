Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF934D2EDE
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674643; cv=none; b=ZXeEKEWdlNq6Ky9JIZi9i9yI1d/uap0r7iMMfeBut3sW4IPf7HsW4cfhuq2Ng6ImY4OYkaZLLdfkChyQ60ViMgiNqf44tVFX3QhX1/zIL9ky1HLtUOOUa4whcj8hvpWRNUoJqwk4oHNuCzL2bHeU05mBp2UFR5SI4S3VgSxpqfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674643; c=relaxed/simple;
	bh=Y2mzhdtssDHR9KEpK37lmFtUCIen1HlUYRbsWHD9gbM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WfiZNFmpvFaSXuQwV+cCDqPbLTWqUEZiF2HvzpRYkRWH3AmWxf0PGiRsNsycvudfsXtzt9V4+THSGQjMyg8eQeep1Pd/wCl+j3Nl/lwZlwaC6a755GLxqLPK3z5mMaJg7TfsQYEk9lXm8WGG63jAgXa8UXzEyKb4Q7Ngvjbv1RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JNEZoNO4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JNEZoNO4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3ED1F000FF;
	Tue, 29 Sep 2026 09:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790674642;
	bh=fQgk6hk+TRwBTgU/fO1xlxgIw9WnxbB4voo+b/IYtzg=;
	h=Subject:To:Cc:From:Date;
	b=JNEZoNO48Wlq/cyr6fcsTf1PIPPu2oS1G9axEk3pGKRwybWM/fvtO0udJasesLVPc
	 xA1tS+z7iUwtK36ke5kd2MG6V7skkd/yNAfs3HlJINmEPuov58MUm2RqFT+233v0aN
	 wy71RO+1ftsF9cxaiOscfYk2wrl6FLxcA9NnpoAc=
Subject: FAILED: patch "[PATCH] net: macb: fix dma_alloc_coherent() leak on macb_alloc()" failed to apply to 6.18-stable tree
To: theo.lebrun@bootlin.com,nb@tipi-net.de,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 11:37:01 +0200
Message-ID: <2026092901-evaluator-improvise-eb56@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 23d42b9a3bcd55b17d3b371544fedc708c2397e9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092901-evaluator-improvise-eb56@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 23d42b9a3bcd55b17d3b371544fedc708c2397e9 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 18 Sep 2026 21:53:52 +0200
Subject: [PATCH] net: macb: fix dma_alloc_coherent() leak on macb_alloc()
 error paths
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix 3 leaks in macb_alloc() error paths:
- Tx buffer allocated but crossing a 4G boundary: Tx leaked.
- Rx buffer allocation fails: Tx leaked.
- Rx buffer allocated but crossing a 4G boundary: Tx & Rx leaked.

This is because our error handling calls macb_free(bp) which in turn
frees the buffers stored in bp->queues[0], but nothing has been stored
in there. Fix by storing allocated buffers into bp->queues[0] ASAP.

Fixes: 78d901897b3c ("net: macb: single dma_alloc_coherent() for DMA descriptors")
Cc: stable@vger.kernel.org
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Link: https://patch.msgid.link/20260918-macb-alloc-leak-v1-1-aba9a3d4f6e3@bootlin.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b8234ac4b602..8e5c034dc3a4 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2749,14 +2749,24 @@ static int macb_alloc(struct macb *bp)
 
 	size = bp->num_queues * macb_tx_ring_size_per_queue(bp);
 	tx = dma_alloc_coherent(dev, size, &tx_dma, GFP_KERNEL);
-	if (!tx || upper_32_bits(tx_dma) != upper_32_bits(tx_dma + size - 1))
+	if (!tx)
+		goto out_err;
+	/* Record the buffer so that the error path frees it. */
+	bp->queues[0].tx_ring = tx;
+	bp->queues[0].tx_ring_dma = tx_dma;
+	if (upper_32_bits(tx_dma) != upper_32_bits(tx_dma + size - 1))
 		goto out_err;
 	netdev_dbg(bp->netdev, "Allocated %zu bytes for %u TX rings at %08lx (mapped %p)\n",
 		   size, bp->num_queues, (unsigned long)tx_dma, tx);
 
 	size = bp->num_queues * macb_rx_ring_size_per_queue(bp);
 	rx = dma_alloc_coherent(dev, size, &rx_dma, GFP_KERNEL);
-	if (!rx || upper_32_bits(rx_dma) != upper_32_bits(rx_dma + size - 1))
+	if (!rx)
+		goto out_err;
+	/* Record the buffer so that the error path frees it. */
+	bp->queues[0].rx_ring = rx;
+	bp->queues[0].rx_ring_dma = rx_dma;
+	if (upper_32_bits(rx_dma) != upper_32_bits(rx_dma + size - 1))
 		goto out_err;
 	netdev_dbg(bp->netdev, "Allocated %zu bytes for %u RX rings at %08lx (mapped %p)\n",
 		   size, bp->num_queues, (unsigned long)rx_dma, rx);

