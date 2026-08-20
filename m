Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4F0215161
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 22:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787264881; cv=none; b=A8yZA0wNS4nwKmOzcDDiV6ptZLwpOwEWFK4sYdmeYFHELWrJ2/zMeJNG1ceNUk1kBqd0MiDOeHZCDkCWFKojxp0BQ4+sYowGw6OHFNFjZa8uDH0t900cnm2JWXHR7Aj0eh1Kpy3fZSfYNbmErrb3h5gIecA4CZVF7ybocPydpmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787264881; c=relaxed/simple;
	bh=qsy5aJb37WaM+HptbzgPpG3IycpqFk4jBKAuDAE3FpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/W1GVuE6knU/fvqG3dmjJU+9REyw2/JBhx0TLk3APULIq5za9+TKpR60cV+6aQJwTK6MFB/7V5M9aRO5yUF+KVybzQ77GYHnsFgbgH+FYFRitsZyfs/P5fNAHg+CSrX6b8rs+jJUp3jyaCSqXzjbIRYKE76BdLlR/hXDlOFrCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbH7OAXM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbH7OAXM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E941F000E9;
	Thu, 20 Aug 2026 22:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787264880;
	bh=7ovW3nmJ0dYMAJi0rQQn70omooXPhhr6z4p4Wv+DBwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CbH7OAXMFFYCdWuIsVXOXKqVjy3y0zdBNk/aUAL5bmzx9CZqUS7yfL00lXSMwoa8A
	 H/TLJ3xeE+nar/sjCFDSRnsNaolyCGrPQtks96xZEeALCcWMnEJySn63fjtN6jRlAG
	 RciHZflMax+jrvEeGPFmswZ/jj+cPc8iVw98O+m1RHdR6d0zO9USnCoXbzC/q1991f
	 Jo0yfnTajiHJL4Y3dk72KeUDoJ4qtix6aljuRRA42VYVQs1dXDna3EgRXJp8obpIzE
	 IMD96vVediC2rt9nTXCaGOgu8bUSq4JXuOkczIW53l8S8L+6sbg/w4hrPlwagdc43/
	 Y6jj+mZeR15yg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Koichiro Den <den@valinux.co.jp>,
	Dave Jiang <dave.jiang@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] NTB: ntb_netdev: Preserve RX queue depth on allocation failure
Date: Thu, 20 Aug 2026 18:27:57 -0400
Message-ID: <20260820222757.2319999-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081710-mandolin-absence-59b8@gregkh>
References: <2026081710-mandolin-absence-59b8@gregkh>
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
index dade51cf599c6..554ec6e544403 100644
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

