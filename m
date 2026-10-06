Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208D32853FD;
	Tue,  6 Oct 2026 04:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791260523; cv=none; b=j8yeExkBfDJlBiHsdHZFqFC4xJN/CbhqWtz6w/J8GJmV5hO3ey+7Jnlb9zz5FKYOW51uEZ4Vps8vYB3SpK1NdXCU4f+4LdzXYIrNeJhdPYWjG+yqaWvi+eciXOBDihKX4PpwcT8UQklVhpeCff3n8k0YvnYVbIptRF9C2ect1j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791260523; c=relaxed/simple;
	bh=fENWsDJ6WRpg4eUcP6QYKpb3Fdveii+Aay+uG0oHlhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJyBDFxBq0CnkRHQeWLGt0FTg27wj/jb4X+hnnDOCFLoEoHmw9o5MZuIEcWzfD/kjdpnzrlpcP2yW2x1+Oh4G+ccOc+pwDE89DWKL3c5PNUSB+U8ewh7hjcBa0sfmL0v2cfg0yLrSwzOJl+39pKd+AIHSedRYByoU8llgTcea7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOK/ajbl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOK/ajbl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7B41F000FF;
	Tue,  6 Oct 2026 04:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791260521;
	bh=FK1eOVwkQE5rZEWtjthVHY4ty0LJ8v64tvLefhkXcSo=;
	h=From:To:Cc:Subject:Date;
	b=gOK/ajbl5ahTxmWx+5zyHhf5ID7jbdIg/ubw1dTqhdlFSNT8PZnVWYCeEf4+Gotis
	 WaAmNDKDI28s1hQHvBnnYVhsSGGgCUBRMJRGeoQiREKy6MF9AIdaY/yPQHs419rr1x
	 SiUTqp/bKLRByTvzH7CI1XQRkUtWkuAacvuQuKdZUoLDCAU9h1R9Ld4VMKj0FjVKKl
	 44x6Cn7cDMAWHxUCP66Xl5c2GyRTIbPXLxFgGlynnknJisykROJ5ifUzSbp0oQYhzL
	 COwYV41gPP67TNe01RPa9Ni0QdRGS1HUP78qXSKf4KIwqZDLzKyszciCyZ1Tiz5Ju5
	 lUeL8+s6x1npQ==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	stable@vger.kernel.org,
	Stefan Fleischmann <sfle@kth.se>,
	Eric Dumazet <edumazet@google.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bernhard Schmidt <berni@debian.org>
Subject: [PATCH v2 net] bnxt_en: fix DMA mapping length for padded small packets
Date: Tue,  6 Oct 2026 06:21:53 +0200
Message-ID: <20261006042153.199444-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stefan Fleischmann reported Intel IOMMU DMA Read faults on BCM57412
NetXtreme-E NICs when transmitting packets on VLAN/macvlan interfaces:

  DMAR: [DMA Read NO_PASID] Request device [18:00.0] fault addr 0xfc499000
        [fault reason 0x06] PTE Read access is not set
  bnxt_en 0000:18:00.0 eno1np0: Abandoning msg {0xb4 0x41a} len: 0 due to firmware status: 0x2000001
  ...
  NETDEV WATCHDOG: eno1np0 (bnxt_en): transmit queue 0 timed out

The fault address (0xfc499000) is on an exact 4KB page boundary,
pointing to a DMA read buffer overrun.

In bnxt_start_xmit(), packets smaller than BNXT_MIN_PKT_SIZE (52 bytes),
such as 42-byte untagged ARP frames, are padded:

    if (length < BNXT_MIN_PKT_SIZE) {
        pad = BNXT_MIN_PKT_SIZE - length;
        if (skb_pad(skb, pad))
            goto tx_kick_pending;
        length = BNXT_MIN_PKT_SIZE;
    }

    mapping = dma_map_single(&pdev->dev, skb->data, len, DMA_TO_DEVICE);
    ...
    dma_unmap_len_set(tx_buf, len, len);

However, 'len' was initialized earlier to skb_headlen(skb) (e.g. 42 bytes)
and is left unadjusted after padding. Consequently, dma_map_single() and
dma_unmap_len_set() map and track only 42 bytes.

Later, the hardware TX buffer descriptor is programmed with the padded length:

    txbd->tx_bd_len_flags_type =
        cpu_to_le32(((len + pad) << TX_BD_LEN_SHIFT) | flags |
                    TX_BD_FLAGS_PACKET_END);

The NIC DMA engine is thus instructed to read 52 bytes from a region where
only 42 bytes were DMA-mapped. If skb->data ends near the boundary of a 4KB
page (within 'pad' bytes of the next page), the hardware DMA read overruns
into the unmapped adjacent page, triggering an IOMMU fault.

This issue was exposed after commit 447cbe95ebb9 ("vlan: fix skb_under_panic
and races when toggling HW VLAN offload") because reserving extra VLAN
headroom rounded LL_RESERVED_SPACE from 48 up to 64 bytes, shifting skb->data
offsets and potentially causing small frames to land right against page
boundaries.

Fix this by using skb_put_padto(skb, BNXT_MIN_PKT_SIZE) earlier in
bnxt_start_xmit().
This ensures skb->len and skb_headlen(skb) reflect the padded size so
that dma_map_single() maps the full buffer and the descriptor length is
consistent. This also removes the temporary 'pad' variable and masking logic.

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Cc: stable@vger.kernel.org
Reported-by: Stefan Fleischmann <sfle@kth.se>
Closes: https://lore.kernel.org/netdev/20261004122616.56714cbd@nargothrond/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Bernhard Schmidt <berni@debian.org>
---
v2: Move skb_put_padto() earlier (Sashiko)
v1: https://lore.kernel.org/netdev/20261005023812.130639-1-edumazet@kernel.org/

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d7728d0c5b6e63ee72de9dea54426bb4c8b7a9fc..7f379f21fe46543a7067462588522d4ab6ef4603 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -486,7 +486,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct netdev_queue *txq;
 	int i;
 	dma_addr_t mapping;
-	unsigned int length, pad = 0;
+	unsigned int length;
 	u32 len, free_size, vlan_tag_flags, cfa_action, flags;
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 	struct pci_dev *pdev = bp->pdev;
@@ -507,6 +507,11 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	txr = &bp->tx_ring[bp->tx_ring_map[i]];
 	prod = txr->tx_prod;
 
+	if (skb_put_padto(skb, BNXT_MIN_PKT_SIZE)) {
+		/* SKB already freed. */
+		goto tx_kick_pending;
+	}
+
 #if (MAX_SKB_FRAGS > TX_MAX_FRAGS)
 	if (skb_shinfo(skb)->nr_frags > TX_MAX_FRAGS) {
 		netdev_warn_once(dev, "SKB has too many (%d) fragments, max supported is %d.  SKB will be linearized.\n",
@@ -672,14 +677,6 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 normal_tx:
-	if (length < BNXT_MIN_PKT_SIZE) {
-		pad = BNXT_MIN_PKT_SIZE - length;
-		if (skb_pad(skb, pad))
-			/* SKB already freed. */
-			goto tx_kick_pending;
-		length = BNXT_MIN_PKT_SIZE;
-	}
-
 	mapping = dma_map_single(&pdev->dev, skb->data, len, DMA_TO_DEVICE);
 
 	if (unlikely(dma_mapping_error(&pdev->dev, mapping)))
@@ -759,10 +756,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		txbd->tx_bd_len_flags_type = cpu_to_le32(flags);
 	}
 
-	flags &= ~TX_BD_LEN;
-	txbd->tx_bd_len_flags_type =
-		cpu_to_le32(((len + pad) << TX_BD_LEN_SHIFT) | flags |
-			    TX_BD_FLAGS_PACKET_END);
+	txbd->tx_bd_len_flags_type |= cpu_to_le32(TX_BD_FLAGS_PACKET_END);
 
 	netdev_tx_sent_queue(txq, skb->len);
 
-- 
2.53.0

