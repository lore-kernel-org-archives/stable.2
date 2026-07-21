Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165E87261A
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625305; cv=none; b=cF/+uZLKYT3dHav8rNbfVueHl3M+Mvj8r0JDnJAAJwBVRRSSkwXuVMI4V/Hi6CNxytjPxw/fto6VmA1ezihsvQbK8vJVCxYnassfU1iyuAs1CDxx7YKPTFOLNpzP7Y6RKlZLIbbe1WOLnzQgw4x5naP2Z4Qi3FFWM1VeAWSWOPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625305; c=relaxed/simple;
	bh=8OVhIuUz51IevQtI0IidTv1wDYL1pxoV39VJdF5s3AE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=osmfWF0SEUe8MFcEXLv+KU3MdrdNVKywCcAu+IvEYDFaxdra1/yiR4W83VUX8i9LE4m2fGkLzOdg42dhM5iZcyTg6J6Sd7shsG5DaaLOc+G5pxhM3vimd/7gofBiyG+DFMfwlByqiamWJ3ahcNnJFi4TDEZxvTI93nkL/xbVHS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ikkOS9Uh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ikkOS9Uh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B39E1F00A3A;
	Tue, 21 Jul 2026 09:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784625304;
	bh=Cv6Un9f0zdNs9bTLXy4V7EFWPczw+D4Jpih9PlgZauA=;
	h=Subject:To:Cc:From:Date;
	b=ikkOS9Uh0hFPXHji2+JoHbyX3W86M94udQqJMPs1/Z+qsb7cBY6AaeYTrMsdtSUAD
	 d9Bk9jbViASmN5x38ME42elKezWznV6HiAv9EjIvZ/eghgZEr0ruVeojDNnYa1WmtV
	 qNUjoqTCHGH5DONquqcWGtMb8GetQDlugBooAF+0=
Subject: FAILED: patch "[PATCH] net: macb: drop in-flight Tx SKBs on close" failed to apply to 5.15-stable tree
To: theo.lebrun@bootlin.com,nb@tipi-net.de,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:14:41 +0200
Message-ID: <2026072141-overrate-gratified-54e6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 27f575836cfebbf872dec020428742b10650a955
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072141-overrate-gratified-54e6@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

