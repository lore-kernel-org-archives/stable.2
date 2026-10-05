Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63F3547072;
	Mon,  5 Oct 2026 02:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791167913; cv=none; b=CmVlOqxXhAP/46xhHmbDYQGRRBcHo/XLiR/wFYxEMdzlYUmjEBI0YxsQGgfKXsySlUbY0BGUpThdaZEKRFFHTArFO75lQS1EPl700cHJrE2YxZXnV8Oei2xW2KRShpquljrQDByKev9zWOKgGefVB/g2/TEOBIuY17j9U4UJnpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791167913; c=relaxed/simple;
	bh=0K73ybWj1AHLcstbBrnklE+u7vQErNZh0cGc5/aaq18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lrWcpfwjmF3NgffDOYEC71xhWp80Kt5qND3PIYVOtm5G2GH75IMr+Bqgf4YnwTNjaOCobQWCDzjQUwj0K24QYTJttKStX2BNFLduj3PvPagcG43ubcrbUwiQSAiwZmUpu4Htwydesw+DzLV/Y9Rta+mkdDWCDGtYhojYatgbDAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixkD/3TT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixkD/3TT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0F11F000FF;
	Mon,  5 Oct 2026 02:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791167911;
	bh=NuY6RBcNQjnzWed3xH/AV/H3fXG6XQ6i128hpQCb3Zk=;
	h=From:To:Cc:Subject:Date;
	b=ixkD/3TTRXyl7QOtRR/Zyif7b/vHoR8HI2sNPjIr1yEjGAm001zl49lJhm2BT76KB
	 LpsqOjHGVj2zU6L3GFoKqqlZDoe9+CewUhPTa9llfMyQ6ttTbjuoEHCMUSRRLAzFTI
	 ubmfuBN0+rmjnoUM4W+m5tMTmrFL6kZYGIBy9tIHfVZNnn2s8qiaopWCg/61iLYl9S
	 7JGCNz6ub8+YGgo8CqENp74stloDdAe4JnVd0LApWx9YIRLovrzGgllibVLP0w4Crm
	 SJuTU9yzcd+LhhMivsVJQhvDWwZAkloksgKAk4o2sbsCT4H/sMxaHbL/Ig4DNPgwop
	 hWfMf6OIETlLQ==
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
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net] bnxt_en: fix DMA mapping length for padded small packets
Date: Mon,  5 Oct 2026 04:38:12 +0200
Message-ID: <20261005023812.130639-1-edumazet@kernel.org>
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

Fix this by using skb_put_padto(skb, BNXT_MIN_PKT_SIZE) in the normal_tx
path. This ensures skb->len and skb_headlen(skb) reflect the padded size so
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
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d7728d0c5b6e63ee72de9dea54426bb4c8b7a9fc..7ea27e81e88c5ca82a453b449982b791e8acc831 100644
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
@@ -672,14 +672,12 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 normal_tx:
-	if (length < BNXT_MIN_PKT_SIZE) {
-		pad = BNXT_MIN_PKT_SIZE - length;
-		if (skb_pad(skb, pad))
-			/* SKB already freed. */
-			goto tx_kick_pending;
-		length = BNXT_MIN_PKT_SIZE;
+	if (skb_put_padto(skb, BNXT_MIN_PKT_SIZE)) {
+		/* SKB already freed. */
+		goto tx_kick_pending;
 	}
-
+	length = skb->len;
+	len = skb_headlen(skb);
 	mapping = dma_map_single(&pdev->dev, skb->data, len, DMA_TO_DEVICE);
 
 	if (unlikely(dma_mapping_error(&pdev->dev, mapping)))
@@ -759,10 +757,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
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

