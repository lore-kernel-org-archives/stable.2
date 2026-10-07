Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076273F106B;
	Wed,  7 Oct 2026 05:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791350277; cv=none; b=CuallLui1Aoivw26VJj5v6kbsx5QxF/JviZ5rgmmp6REBQLEVZ6U3SZ2WDB6EkLSkfWIrH0BJJ4B2/ROgw9v5RcYO7c2pzRCLn1Kto4K+CnImPsxV3U2V9HU2ppzf9srPgBxeXuIlPrGFl1Pf0SigKVCwwXVQ9o2gjbhDHhyK5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791350277; c=relaxed/simple;
	bh=17kHsZVFDJaDgq4ZoesnTXclcE6KyY3pqgFwnXY9K1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Prf1h0UIE9kM6yMlKH7AlIBocXd7UZhUen/Rb1IKkb9tWLK2QKogg+Z1Cvzq60xtGSGLux6+sEm7CN1iWArLfUOVj3nUDaACeCMcW8OMEjCTHJGM0hDoXYWHvXmk2YWp6uXAUYRzhIVoN7DEs/kNQNHRD4kKQ7C3IbL7t3zL+yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPU/A5o6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPU/A5o6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F9D1F0089B;
	Wed,  7 Oct 2026 05:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791350275;
	bh=qGlE0Dn055LtZkP2Rtvhwa3S6kVWWIlyJ/2Lm3KPA+k=;
	h=From:To:Cc:Subject:Date;
	b=BPU/A5o6V0g1snSniqH9SEIE2hKSBpjFE/dpT6qnu/qEROfZEWtfiXZUndfk/LlLi
	 hsSLdtKQvq9VPpTpFF0jrUKl7vPyeaH2HnMWyObuEceCojrrRPLxs6f5WOxPndiyiW
	 3kwV/ALsm/bBpNIhaCJZ+WlQ3wEqIrUGsKQjXtUN9tdLPQoW/sHLxOHaTsHU+w1zTf
	 Ok22uMrEO7GmjqzsbC0J9jDke8cAwz3mgzXytlAd2oGI0y4tm1ABTPa0FC1IVHaJV1
	 9xCGX442wBJQPXRk0KckpXKcbn/ynYV2M/U3883ZSO8Jnpa3dEm8NS1986JiFZj8fs
	 tWKDyrKuu+2NQ==
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
	Bernhard Schmidt <berni@debian.org>,
	Joe Damato <joe@dama.to>
Subject: [PATCH v3 net] bnxt_en: fix DMA mapping length for padded small packets
Date: Wed,  7 Oct 2026 07:17:47 +0200
Message-ID: <20261007051747.455273-1-edumazet@kernel.org>
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

Fix this by using skb_put_padto(skb, BNXT_MIN_PKT_SIZE) in
bnxt_start_xmit(), before skb_shinfo(skb)->nr_frags is sampled,
because padding might linearize the skb.
This ensures skb->len and skb_headlen(skb) reflect the padded size so
that dma_map_single() maps the full buffer and the descriptor length is
consistent. This also removes the temporary 'pad' variable and masking logic.

The padding is done after the SW USO branch, otherwise
bnxt_sw_udp_gso_xmit() would account the padding as UDP payload
and send it in extra segments.

Note that SW USO segments are still not padded: with IPv4, a segment
carrying less than 10 bytes of UDP payload (small gso_size, or a short
last segment) is sent as a frame shorter than BNXT_MIN_PKT_SIZE.
This is a separate issue, left for a followup patch.

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Cc: stable@vger.kernel.org
Reported-by: Stefan Fleischmann <sfle@kth.se>
Closes: https://lore.kernel.org/netdev/20261004122616.56714cbd@nargothrond/
Assisted-by: LLM
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Bernhard Schmidt <berni@debian.org>
Cc: Joe Damato <joe@dama.to>
---
v3: Pad after the SW USO branch (Sashiko)
v2: Move skb_put_padto() earlier (Sashiko)
    https://lore.kernel.org/netdev/20261006042153.199444-1-edumazet@kernel.org/
v1: https://lore.kernel.org/netdev/20261005023812.130639-1-edumazet@kernel.org/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 25 +++++++++++------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d7728d0c5b6e63ee72de9dea54426bb4c8b7a9fc..631c759b3752b29c1a649eedb08f8bbc9f37a607 100644
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
@@ -536,6 +536,16 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		return rc < 0 ? NETDEV_TX_BUSY : NETDEV_TX_OK;
 	}
 
+	/* Pad after the SW USO branch: bnxt_sw_udp_gso_xmit() would
+	 * otherwise account the padding as UDP payload.
+	 * Must be done before skb_shinfo(skb)->nr_frags is sampled,
+	 * because skb_put_padto() might linearize the skb.
+	 */
+	if (skb_put_padto(skb, BNXT_MIN_PKT_SIZE)) {
+		/* SKB already freed. */
+		goto tx_kick_pending;
+	}
+
 	free_size = bnxt_tx_avail(bp, txr);
 	if (unlikely(free_size < skb_shinfo(skb)->nr_frags + 2)) {
 		/* We must have raced with NAPI cleanup */
@@ -672,14 +682,6 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -759,10 +761,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
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

