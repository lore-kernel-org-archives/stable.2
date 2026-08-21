Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C5E2F0C74
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 04:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787286749; cv=none; b=IZsqtLL9ykM3w7r/dJQ3ixuUC3SkodBr9Hbr75ru7OtySHN41ukr6lR+/xEErxuWW4HY8upetxlFn6OHd1RGhcwx3YoXi20P03tYBTC+yBpjpZHESDSnq7ecB36Hifl758twn4L5X7pDrJktA8Pmr9/eQoqA5CO7XRn9yFajhhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787286749; c=relaxed/simple;
	bh=sv8v4PyMGrkePS4v/wbKnHUjDum188YLl/JYPkfwHDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ep+BCCIvz7x5FiYLW2IPIU02jnQjMsjo96g+0BfPb8D2M/KBt1+0CBhhzm5QDUkK3KgdjJY4N8TQ5B+bJIT+5dvKTBvGduVVnljTXmaPrgplQlWkr+5Bi2ITHnSX49Mij3fljjOga4XRfZZe9Dfu0MY4E8SUlhDaXoX9hErjJ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBqAUtUO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBqAUtUO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F111F000E9;
	Fri, 21 Aug 2026 04:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787286747;
	bh=UT3rJSiVtSOe7QlrlWN1mWEpV9J37EOkgNiuBEcd6y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MBqAUtUOZF8ayFy4khgSZLWo8uAqMhcC0wWaw09AKggdIxn7YaICXNWNp47KkbbAG
	 sMO0DqAv1B7u3Zkcu5IiJJvJYmYWjmzZHqN6nstHpc6zkChXJZCNFsxNWrD36UeBQd
	 lY6LytLyTVHWxZgmU29DpFpr9OWI7RGh5dtyJ23oz+AnhQBDiRy5HVk2mQ0l7hM8Ov
	 2SGtGs/n8Qr5Ke75Ixk4TzQOUHGzuv3YitgjkZDAY36MYGw0nNWGiSz93JiehCQy46
	 yTHxBvvQgNb5IYSho2OQSHt46Wq17dDnWi5Eyu6JpOEkLgheicCzdDmI2clkpoHKDa
	 RtdQasthDlT9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Koichiro Den <den@valinux.co.jp>,
	Dave Jiang <dave.jiang@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] NTB: ntb_netdev: Preserve RX queue depth on allocation failure
Date: Fri, 21 Aug 2026 00:32:25 -0400
Message-ID: <20260821043225.2540369-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081711-ranged-confusing-4505@gregkh>
References: <2026081711-ranged-confusing-4505@gregkh>
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

