Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97B23793CA
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 03:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787284767; cv=none; b=kgrL1TscB17mmpHi6fIhXXcxJrmzhSzOekbxvEX2D5N0ZrQRG0wtnlO07D61/bPxCJCbn7ly23Ym5m5c5dEbGzOC2I98bfYAv5Gc9kuWHSiPRCG5oxIYCCtJU/aonAAHSOPYtXqjU9THqC4j6sS03ja7Mm+PuvVHqazco40Y1go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787284767; c=relaxed/simple;
	bh=4Wtl1RzQrMxWyavuiKdH8xAPYp3a8DCOPHpUl6bnH54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJXHu4dUYn2YuzpGPGlN7Qg1vcpexQ/2+FSe2s2d7ScBPbFAXy/t22arz+aqwB36Zu80UTIeyYfB7oZkfyMq4eP2kSSgSH0T4NaYa+N7cfzpNLTifrgRAQUGfbiB1XXVkyLSQ6Oi/ZWhwDZUzYPeE+3Cb0a2WWYJCLpebfObiMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbbA4D9o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbbA4D9o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086801F000E9;
	Fri, 21 Aug 2026 03:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787284765;
	bh=m9Nr9wXlw9a3vi6KoxWVegao87dTdIzNN+bYmW5ZJ+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RbbA4D9oOTAKOmHXlC4QRoyw2aMwEabFJE/DrP98TFl+Rt/mTB/9SFnBqvrBVrP53
	 32fPXF2ZKN7d2PEuSJmzc14ooGrW2YbNqne+8x3BdUcD0dkrmcb015xQv1D4kM/swP
	 3jFX/l9eVCemDx8ItJetnOujat/PutY2+assEC74vZIUWU0gOqnuIuwwjLgfAundxe
	 2wjmx2b5pM/lnke1qgUXwkSjRz5YcGRlcPLiZaFnf+JXmLF22cVJSch1OeO8DPd44x
	 2DdJAOTAX780fp5E69YCRDeWw0A7p9+NHhPE4Bu8Pq4m5r6nHaLDhVnnhLOCo6dHQZ
	 bygTbVEfkK7Dg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Koichiro Den <den@valinux.co.jp>,
	Dave Jiang <dave.jiang@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] NTB: ntb_netdev: Preserve RX queue depth on allocation failure
Date: Thu, 20 Aug 2026 23:59:23 -0400
Message-ID: <20260821035923.2524987-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081710-dwindling-extenuate-15ef@gregkh>
References: <2026081710-dwindling-extenuate-15ef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Koichiro Den <den@valinux.co.jp>

[ Upstream commit d2121faf133ac3bf9531b53a7e21273649a08517 ]

ntb_netdev_rx_handler() hands the received skb to the network stack
before allocating its replacement. If the allocation fails, nothing is
reposted. Every failure therefore takes one buffer out of the RX queue
while the interface remains up, and enough failures eventually stall
reception.

A retry path could refill the queue later, but ntb_netdev has none.
Allocate the replacement first instead. If that fails, drop the packet
and repost the same skb. This keeps the queue full and lets packet
delivery resume as soon as memory is available again.

Fixes: 548c237c0a99 ("net: Add support for NTB virtual ethernet device")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://patch.msgid.link/20260806032537.3526498-1-den@valinux.co.jp
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ kept HEAD's `struct net_device *ndev = qp_data;` declaration instead of the per-queue context variables, adding only `new_skb` to the existing `skb` declaration ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ntb_netdev.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 535dc5b2901fc..95193a4ab0912 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -100,7 +100,7 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 				  void *data, int len)
 {
 	struct net_device *ndev = qp_data;
-	struct sk_buff *skb;
+	struct sk_buff *skb, *new_skb;
 	int rc;
 
 	skb = data;
@@ -115,6 +115,12 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 		goto enqueue_again;
 	}
 
+	new_skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
+	if (!new_skb) {
+		ndev->stats.rx_dropped++;
+		goto enqueue_again;
+	}
+
 	skb_put(skb, len);
 	skb->protocol = eth_type_trans(skb, ndev);
 	skb->ip_summed = CHECKSUM_NONE;
@@ -127,12 +133,7 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 		ndev->stats.rx_bytes += len;
 	}
 
-	skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
-	if (!skb) {
-		ndev->stats.rx_errors++;
-		ndev->stats.rx_frame_errors++;
-		return;
-	}
+	skb = new_skb;
 
 enqueue_again:
 	rc = ntb_transport_rx_enqueue(qp, skb, skb->data, ndev->mtu + ETH_HLEN);
-- 
2.53.0

