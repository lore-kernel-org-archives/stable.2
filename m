Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15BC26056C
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254519; cv=none; b=Q/ofDePa4ETDVV57YcVnSSD9a/+LKxVzinhB5CFfyQYmW7mVlknVu/mQFtWRzvtTg1a9+trvcYbRtEfK3xW5HXrF1CcE7rUTbQxsri4nF9HY9yRU1mZWNU2ZzDF2lb6r+jZlPW1WUw6NMzgEcdwxi9uPtfceeROfhlQQcF2Z5ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254519; c=relaxed/simple;
	bh=4KL6H7LGIyRlRkm5f1vK/G/tftgHSDk4pi2rScosg1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pvvn/uPKWS0rGIR9eLq9phexwH2Ip00589R+tZc7qcWsZ85nYJ+gSs+fT6hQ7iNvDlXma/ChyP/rtMQhMicWlHYJPpnqTARWiNuiafPqvPDZBmRvOrFetQ7Arv6mtMT7lM+zzGCIm3dQVyH0uZpQhNIOt9rj+aLfY2nGixOP/D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4jkSso5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4jkSso5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144791F000E9;
	Thu, 20 Aug 2026 19:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787254518;
	bh=84zJFq2mzwUUk2XoeUSloOODbudjlUws4LI44R9GWic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J4jkSso5CO8UjxehxGDd1xbeG/WeBkOvckX6nJB7nXGBkLhUpx2kQMw1hgyrbfmb9
	 lb/xO8YVznx4O5VwiLsWkHUEpqqHI8Wi+I+P5Ao72S43siyqwp1LduyW1PxUHWVP42
	 7m/n1siEBW+ljs9gfHjpUuag2iQEFoJIbtzS74vQOadpk5ybUieM9POOFqXfDaozaU
	 2/3tnKppJAKqkD9a04bDV5/wmHJtliWNI+MloqeiCne/7ss9tK3v5f2EpnWsFd9vDk
	 Z6T9hx7ZCT/fs4gqi/9qhbC5Mr7S1sGkZFKP2tn2QEr1NCgVqkZjH1uxodMgwpKw4F
	 oHHrVlWKa/tXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Koichiro Den <den@valinux.co.jp>,
	Dave Jiang <dave.jiang@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] NTB: ntb_netdev: Preserve RX queue depth on allocation failure
Date: Thu, 20 Aug 2026 15:35:15 -0400
Message-ID: <20260820193515.2272594-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081709-chump-underhand-f0fd@gregkh>
References: <2026081709-chump-underhand-f0fd@gregkh>
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
index ef6df0e37bea5..05bd6ad9c88fe 100644
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

