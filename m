Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.14.198.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794956131;
	b=l9CxfXc6iUk6PWawcHufChZePGFladh7nM8JUmStRjsgdiuPX1gjhr2VAofrtQH4Pqj0
	 eCQe80Tkk15gA6uhxekOMtB6LXwFEV0/dBjuwKTJKxHW54Fpnpv6lnThdoTIwUE6AMnM+
	 sSmdDZZ8lFcv1dAIyoVClSsVFe3aQwFBJIzOLBBFS5kwnDTeYVuOaWm9q1LsRTglLFHsh
	 3HPf+8A+11RD9iL4j0OudJocTssCzIeTaMXnW17mM/p6aumSoimI23xOetQJgV+lxuN2T
	 +ddvH/roB7Sl9sUjdzpDyh4kPKI297InCz/+Qv4cOPtTOIkovCM7S+IPMchwY9J7rmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956131;
	h=DMARC-Filter:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Received:
	 DKIM-Signature;
	bh=p1d3Y2CLMAz4CqU2eQsHo73W9hHZXrd7SctRraH/gy8=;
	b=c4ldBcHnQEt5clOxO3bji76/nI5rrl+3M7SoyiwZsY5Becb2QcKzAUSYiyZD0ii5KRvL
	 Q8ZqkgQiYxcm48XxiuJpB/6sWI1SalFILQ9niyYhZ8FMyyUyxsY3h5ey1py1wj1hTuYzO
	 dtixB9HUnNOx61HbTgltbtD1y50/061UdU2ACdIfhfl/gLURROglH51lnfQpphJpkz2de
	 NY+Hfvnqkb8ozaGq3BCHfeV5wtE9H64jI092mgMuc6UJiGB3oPF6h/P0WZNSxpB9jTdI+
	 vyOURZd12pXVqU6E5QDzg442+sFUWShBXuKxAp1TvC99GeRKp1ORtiCSW8BbuXMmh1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rimpianto.com;
	spf=pass smtp.mailfrom=rimpianto.com;
	dkim=pass header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=erqVDgpd;
	arc=none smtp.remote-ip=46.14.198.178
Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474E6606A31C;
	Tue, 17 Nov 2026 22:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 474E6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=erqVDgpd
Authentication-Results: mail.rimpianto.com;
	auth=pass (plain)
From: Federico Musto <federico@rimpianto.com>
To: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Federico Musto <federico@rimpianto.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4 2/2] net: atl1c: free the RX buffer when the descriptor reports an error
Date: Tue, 17 Nov 2026 23:55:21 +0100
Message-ID: <20261117225521.19689-3-federico@rimpianto.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261117225521.19689-1-federico@rimpianto.com>
References: <20261117225521.19689-1-federico@rimpianto.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received: from localhost (Unknown [127.0.0.1])
	by mail.rimpianto.com (Haraka) with ESMTPSA id 1A751935-FDFB-4345-9147-8CBB6C5D7B43.3
	envelope-from <federico@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Tue, 17 Nov 2026 23:55:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=s20260314391;
 t=1794956122; bh=p1d3Y2CLMAz4CqU2eQsHo73W9hHZXrd7SctRraH/gy8=;
 b=erqVDgpd5tu44G6/WgRfklXGQhAzSCOJqQL0CMldSlIIfeFxiXfMm2VppPV90/Zp70j67RrpG
 3QMEn7BsNLDrLC2s9uyWI4YpSb3suC+lAJ/BSDNvSdprsDxgVtF3pVEt4AKWxYAAaxeue1uGusF
 0Lr3Rm/mN6kd+6PW0aAdIRgPI69rATssKzIg/4Q3ePc7ppEV4w8fQxZbMhawhSV+JapeVig22vP
 BqxOPR9rTjvX4mMBXG605Dk2yTvTDl4/Ff0ntn078TQLXNIZRe3hnoHk59XV6PkMyjbIJDLKxjc
 mZVSeXa2ZhYZ8MMqReH5PQnjDS43fjKZ783/WTPmvrEQ==

atl1c_clean_rx() drops a frame whose return descriptor (RRD) carries
RRS_RX_ERR_SUM or RRS_802_3_LEN_ERR by calling atl1c_clean_rfd(), which
only marks the RFD free and clears the skb pointer. Nothing unmaps the DMA
mapping and nothing frees the skb, so every errored frame - CRC, alignment,
truncation, runt - leaks one skb and one DMA mapping. The driver uses a
32-bit DMA mask, so on a host without an IOMMU each of those mappings also
pins a swiotlb slot.

Unmap the buffer and free the skb before the RFD is recycled.

Freeing makes the RFD index and count found in the RRD matter more than
they did. Both are written by the device and neither is checked: the index
field is 12 bits wide for a ring of 512 entries, and the count can be 0 to
15 while one RFD per frame is all the driver handles. A wrong index used to
leak a buffer; it would now unmap and free one the device still owns, or
one outside the ring. So validate the RRD first, the way
alx_clean_rx_irq() does for the same descriptor layout: the count must be
1, the index must be the one the driver expects back next
(rfd_ring->next_to_clean) and that slot must hold a buffer. Otherwise touch
no buffer and schedule a reset through ATL1C_WORK_EVENT_RESET, as the
interrupt handler does on ISR_ERROR. After the check the slot is addressed
through the driver's own index, in the good receive path too, which took
the unchecked index from the descriptor in the same way.

The check also covers two cases the count was left to cause. An RRD with a
count of 0 was never consumed and RX stalled on it, in an endless loop
inside the poll when it also had an error bit set. A good RRD with a count
above 1 was consumed without recycling its RFDs.

Count an errored descriptor as work, so that the refill runs when a poll
sees no good frame. Clear the RRD ring on reset: the RRD and RFD rings
advance in step, so an RRD left over from before a reset would pass the
check above and release a freshly posted buffer the device still owns.

The hardware already counts these frames in its own error counters, which
atl1c_get_stats() reports, so no software counter is added here.

Found by code inspection; the error path has not been exercised on
hardware.

Fixes: 43250ddd75a3 ("atl1c: Atheros L1C Gigabit Ethernet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Federico Musto <federico@rimpianto.com>
---
v3 -> v4, after the Sashiko AI review of v3:
 - validate the RFD count and index of the RRD against
   rfd_ring->next_to_clean, and that the slot holds a buffer, before any
   buffer is touched; reset on a mismatch, as alx_clean_rx_irq() does;
 - address the buffer through the driver's own index in the error path
   and in the good path; atl1c_clean_rfd() takes nothing from the
   descriptor any more;
 - drop the multi-RFD loop added in v3: a count other than 1 resets;
 - a count of 0 no longer leaves the RRD unconsumed;
 - new patch 1/2 for the link-down reset race.

Pre-existing and left to separate patches: there is no dma_rmb() between
the test of the RRD valid bit (word3) and the read of word0, and word3 is
__le32 but is read without conversion.

v3: https://lore.kernel.org/netdev/20261103225218.19206-1-federico@rimpianto.com/
v2: https://lore.kernel.org/netdev/20261102215253.68185-1-federico@rimpianto.com/
v1: https://lore.kernel.org/netdev/20261027115156.17128-1-federico@rimpianto.com/
---
 .../net/ethernet/atheros/atl1c/atl1c_main.c   | 97 ++++++++++---------
 1 file changed, 52 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index e9baee8fa7e5..5d00f2489d15 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -933,8 +933,9 @@ static void atl1c_clean_rx_ring(struct atl1c_adapter *adapter, u32 queue)
 		buffer_info = &rfd_ring->buffer_info[j];
 		atl1c_clean_buffer(pdev, buffer_info, 0);
 	}
-	/* zero out the descriptor ring */
+	/* zero out the descriptor rings */
 	memset(rfd_ring->desc, 0, rfd_ring->size);
+	memset(rrd_ring->desc, 0, rrd_ring->size);
 	rfd_ring->next_to_clean = 0;
 	rfd_ring->next_to_use = 0;
 	rrd_ring->next_to_use = 0;
@@ -1866,23 +1867,16 @@ static void atl1c_clean_rrd(struct atl1c_rrd_ring *rrd_ring,
 	}
 }
 
-static void atl1c_clean_rfd(struct atl1c_rfd_ring *rfd_ring,
-	struct atl1c_recv_ret_status *rrs, u16 num)
+/* Recycle the RFD the driver expects back next.  The caller owns the skb. */
+static void atl1c_clean_rfd(struct atl1c_rfd_ring *rfd_ring)
 {
-	u16 i;
-	u16 rfd_index;
-	struct atl1c_buffer *buffer_info = rfd_ring->buffer_info;
+	struct atl1c_buffer *buffer_info;
 
-	rfd_index = (rrs->word0 >> RRS_RX_RFD_INDEX_SHIFT) &
-			RRS_RX_RFD_INDEX_MASK;
-	for (i = 0; i < num; i++) {
-		buffer_info[rfd_index].skb = NULL;
-		ATL1C_SET_BUFFER_STATE(&buffer_info[rfd_index],
-					ATL1C_BUFFER_FREE);
-		if (++rfd_index == rfd_ring->count)
-			rfd_index = 0;
-	}
-	rfd_ring->next_to_clean = rfd_index;
+	buffer_info = &rfd_ring->buffer_info[rfd_ring->next_to_clean];
+	buffer_info->skb = NULL;
+	ATL1C_SET_BUFFER_STATE(buffer_info, ATL1C_BUFFER_FREE);
+	if (++rfd_ring->next_to_clean == rfd_ring->count)
+		rfd_ring->next_to_clean = 0;
 }
 
 /**
@@ -1896,6 +1890,7 @@ static int atl1c_clean_rx(struct napi_struct *napi, int budget)
 		container_of(napi, struct atl1c_rrd_ring, napi);
 	struct atl1c_adapter *adapter = rrd_ring->adapter;
 	u16 rfd_num, rfd_index;
+	u32 rrs_word0;
 	u16 length;
 	struct pci_dev *pdev = adapter->pdev;
 	struct net_device *netdev  = adapter->netdev;
@@ -1914,47 +1909,59 @@ static int atl1c_clean_rx(struct napi_struct *napi, int budget)
 		if (work_done >= budget)
 			break;
 		rrs = ATL1C_RRD_DESC(rrd_ring, rrd_ring->next_to_clean);
-		if (likely(RRS_RXD_IS_VALID(rrs->word3))) {
-			rfd_num = (rrs->word0 >> RRS_RX_RFD_CNT_SHIFT) &
-				RRS_RX_RFD_CNT_MASK;
-			if (unlikely(rfd_num != 1))
-				/* TODO support mul rfd*/
-				if (netif_msg_rx_err(adapter))
-					dev_warn(&pdev->dev,
-						"Multi rfd not support yet!\n");
-			goto rrs_checked;
-		} else {
+		if (!RRS_RXD_IS_VALID(rrs->word3))
+			break;
+
+		rrs_word0 = le32_to_cpu(rrs->word0);
+		rfd_num = (rrs_word0 >> RRS_RX_RFD_CNT_SHIFT) &
+			RRS_RX_RFD_CNT_MASK;
+		rfd_index = (rrs_word0 >> RRS_RX_RFD_INDEX_SHIFT) &
+			RRS_RX_RFD_INDEX_MASK;
+		buffer_info = &rfd_ring->buffer_info[rfd_ring->next_to_clean];
+
+		/* The RRD is written by the device.  Its RFD index field is
+		 * wider than the ring, and only one RFD per frame is
+		 * supported.  Check both against the driver's own ring state,
+		 * and that the slot holds a buffer, before anything is
+		 * unmapped or freed.  When they disagree there is no telling
+		 * which buffers the device still owns: leave them all alone
+		 * and reset.
+		 */
+		if (unlikely(rfd_num != 1 ||
+			     rfd_index != rfd_ring->next_to_clean ||
+			     !buffer_info->skb)) {
+			dev_err_ratelimited(&pdev->dev,
+					    "RRD out of sync: RFD count %u index %u, expected index %u%s; resetting\n",
+					    rfd_num, rfd_index,
+					    rfd_ring->next_to_clean,
+					    buffer_info->skb ? "" : " (no buffer)");
+			set_bit(ATL1C_WORK_EVENT_RESET, &adapter->work_event);
+			schedule_work(&adapter->common_task);
 			break;
 		}
-rrs_checked:
-		atl1c_clean_rrd(rrd_ring, rrs, rfd_num);
+
+		atl1c_clean_rrd(rrd_ring, rrs, 1);
+		dma_unmap_single(&pdev->dev, buffer_info->dma,
+				 buffer_info->length, DMA_FROM_DEVICE);
+		skb = buffer_info->skb;
+		atl1c_clean_rfd(rfd_ring);
+
 		if (rrs->word3 & (RRS_RX_ERR_SUM | RRS_802_3_LEN_ERR)) {
-			atl1c_clean_rfd(rfd_ring, rrs, rfd_num);
 			if (netif_msg_rx_err(adapter))
 				dev_warn(&pdev->dev,
 					 "wrong packet! rrs word3 is %x\n",
 					 rrs->word3);
+			kfree_skb_reason(skb, SKB_DROP_REASON_NOT_SPECIFIED);
+			/* The RFD has been recycled, so count the drop as
+			 * work: the refill after the loop only runs when
+			 * some was done.
+			 */
+			work_done++;
 			continue;
 		}
 
 		length = le16_to_cpu((rrs->word3 >> RRS_PKT_SIZE_SHIFT) &
 				RRS_PKT_SIZE_MASK);
-		/* Good Receive */
-		if (likely(rfd_num == 1)) {
-			rfd_index = (rrs->word0 >> RRS_RX_RFD_INDEX_SHIFT) &
-					RRS_RX_RFD_INDEX_MASK;
-			buffer_info = &rfd_ring->buffer_info[rfd_index];
-			dma_unmap_single(&pdev->dev, buffer_info->dma,
-					 buffer_info->length, DMA_FROM_DEVICE);
-			skb = buffer_info->skb;
-		} else {
-			/* TODO */
-			if (netif_msg_rx_err(adapter))
-				dev_warn(&pdev->dev,
-					"Multi rfd not support yet!\n");
-			break;
-		}
-		atl1c_clean_rfd(rfd_ring, rrs, rfd_num);
 
 		/* A link partner whose l2mtu is larger than ours can hand us a
 		 * frame that does not fit the buffer the hardware was given:
-- 
2.47.3

