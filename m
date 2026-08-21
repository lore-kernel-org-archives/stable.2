Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE13743B6C4
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787309951; cv=none; b=jnfW0iwPLPVA8/xtJWAB72j9eutPTH7LSU/GxBlft0vNkE3dheSi8t5oBEb14Y7CKFewHX4sLR8j01qCAtsNl+NgsRNIYWI0ssiKDoYbTmJQOsUfcLTG2rgqxYTuxzzrMxOcxA5xjj79g1NNx9P0Wa1LAnXxjuP+9f3p4nbDhys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787309951; c=relaxed/simple;
	bh=sv8v4PyMGrkePS4v/wbKnHUjDum188YLl/JYPkfwHDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyZ2CgY3VNsNpKOGZFsJVb3kEcVyo6oaVVG7++YjJFzfbUfklFbnx9qOC+G5mPDl1m+Yb0I0sesJiQ1f2fby4uIXyLc3JIsC1w/s/zqka2nrEWl3/qOoOIjqG1rVcnjL3oMwvLUDo1oqQI69lrObF+6ydRfbflJDqkuZ3mEGhnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cg3GGsvt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cg3GGsvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5CA1F000E9;
	Fri, 21 Aug 2026 10:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787309947;
	bh=UT3rJSiVtSOe7QlrlWN1mWEpV9J37EOkgNiuBEcd6y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cg3GGsvtZKRyUihPruPef086C80QvcEgdzEcVccI8CoWoFKJTzdmjE6/dX/Z6qKr9
	 5v6EDoTGh3HIEUOtatr6zASfA1tRY8WYQmXLQI4XHqCgHzd3c1D4oRo4YR2lU+rKrT
	 +L7t80Z8VZO9mKRiMV/2oP945gMYmWCdBOtYeKaEzzMm737yvjzMo/cL3hiAAli9Hy
	 dVt3WFG1zSTqWnx4702nM4tZdvtRLHPgePfuXyTKXVaqZQOKfJEL05woxO3AUlFO6l
	 EzoDRD3ji9yMYvylENN3UxnNcRZRVrAbk9NtlcQapwqWFGKrpKGAuqYzZdgiLQtDID
	 Mmr7Cywqfu/8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Koichiro Den <den@valinux.co.jp>,
	Dave Jiang <dave.jiang@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] NTB: ntb_netdev: Preserve RX queue depth on allocation failure
Date: Fri, 21 Aug 2026 06:59:05 -0400
Message-ID: <20260821105905.2811977-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081711-stipulate-scone-4ee3@gregkh>
References: <2026081711-stipulate-scone-4ee3@gregkh>
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
index b701ee83e64a8..7e562751d6ddc 100644
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

