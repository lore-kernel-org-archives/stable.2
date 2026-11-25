Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.14.198.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606356;
	b=j6T01JERtaq4lKC5OS4w+DejeDZFahE5QFGSh3bVSbfL1A5guwE68pNsOMxVpRZyjoz1
	 q87NPhd5d9sDdAan/VA84c4Uct+cUxNoaw5RGhYPAd2e4+OG9ZycG/lxJSAdte4aW7RH8
	 GSWNWg+s5EOKwowkHUuUb+iB7orsaST2YwUVUn6ftgzyXuwnEqgiAikPH5o1/iwezkgx1
	 x0AiYJcOM5UhI8E6QUahwRHs6GnoSQtLUCfmwKHoG7b5aVsa/8xG2t0hoagVThDlLBDv4
	 Kh+E1FVmqZxiDsghyx2BuZFIPQEetXNff4L7Bu7qgaZu4W7+ukRKtBn35J7kmeD77Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606356;
	h=DMARC-Filter:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Received:
	 DKIM-Signature;
	bh=oUfViTe7jR/bW0Md+dhz69VSMNtCwOaxO6F2hRcC7hQ=;
	b=ofQuUTGMWsWFYK6UJDaYa50srPGx0s0uiiQ9uAFG2xuSUWXUiYK0jaQGKRJtaUN8dIEk
	 jcnoM+0rmVBFxZi0zqZJImSYjzLsicCDP6Hwt6zXZNkvQZ95/hCdhxeAlhKfpLVM3uFns
	 yHda3FRjQ6giXq1gcsXNVpUNwim7xhL2/ROUDbB4xq8biz58eFmDVi+UwqWdqYfJrCJyx
	 VM0waB3YAxQfITh33+hR3FlLWUWWvIUMgBCanTgWc+ZWtsiB7nUoAyxst4zIyWAtk5H7P
	 ZwlER7l/lz4Q+ibattnY/qoXKYgvO+EER3GjmJ5uSWXo4o8orvobOWOYWyD6ZR/cGLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rimpianto.com;
	spf=pass smtp.mailfrom=rimpianto.com;
	dkim=pass header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=RONVmQiN;
	arc=none smtp.remote-ip=46.14.198.178
Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8B4606A326;
	Wed, 25 Nov 2026 11:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F8B4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=RONVmQiN
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
Subject: [PATCH net v5 2/2] net: atl1c: free the RX buffer when the descriptor reports an error
Date: Wed, 25 Nov 2026 12:31:20 +0100
Message-ID: <20261125113120.99743-3-federico@rimpianto.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261125113120.99743-1-federico@rimpianto.com>
References: <20261125113120.99743-1-federico@rimpianto.com>
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
	by mail.rimpianto.com (Haraka) with ESMTPSA id 455A4CB8-EA41-4A84-AB6F-0475A2A7EF25.3
	envelope-from <federico@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Wed, 25 Nov 2026 12:31:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=s20260314391;
 t=1795606281; bh=oUfViTe7jR/bW0Md+dhz69VSMNtCwOaxO6F2hRcC7hQ=;
 b=RONVmQiN+UOez6zmbCe6O32sBwD+GLj+MYVxAg0F3DX7UUnNDrOl6FuZ8orUiJ+rLuyv/TNFa
 kCEfFR/gCkt7DKpe0EB4I+/obmwomZBmwLlJo01Ilofw1IwTqAEcKfdZSV5hjtOHWQ1jtsB0LJr
 8qa5TVohAqvjv75Vw2CtxMaiZZHCBYagDUpCk5wFPk/y0zIJPPhh75OaT3JAcyW2P8MNkqN+G8M
 HpfbvAWqy6nb2V9Rx9hmlT6ZM663aNaDpQsPANGw2RO99/dBhl9DWc5f4QBwtD6lYqimUQ3VeAV
 lxkg1tO7MKRIDTX09MAnPhEeD2UgvnLBB3+B3Hu/H9Yw==

atl1c_clean_rx() drops a frame whose return descriptor (RRD) carries
RRS_RX_ERR_SUM or RRS_802_3_LEN_ERR by calling atl1c_clean_rfd(), which
only marks the RFD free and clears the skb pointer. Nothing unmaps the
DMA mapping and nothing frees the skb, so every errored frame - CRC,
alignment, truncation, runt - leaks one skb and one DMA mapping. The
driver uses a 32-bit DMA mask, so on a host without an IOMMU each of
those mappings also pins a swiotlb slot.

Unmap the buffer and free the skb before the RFD is recycled.

Freeing makes the RFD index and count found in the RRD matter more than
they did. Both are written by the device and neither is checked: the
index field is 12 bits wide for a ring of 512 entries, and the count can
be 0 to 15 while one RFD per frame is all the driver handles. A wrong
index used to leak a buffer; it would now unmap and free one the device
still owns, or one outside the ring. So validate the RRD first, the way
alx_clean_rx_irq() does for the same descriptor layout: the count must
be 1, the index must be the one the driver expects back next
(rfd_ring->next_to_clean) and that slot must hold a buffer. Otherwise
touch no buffer and schedule a reset through ATL1C_WORK_EVENT_RESET, as
the interrupt handler does on ISR_ERROR. After the check the slot is
addressed through the driver's own index, in the good receive path too,
which took the unchecked index from the descriptor in the same way.

Reading the descriptor is now ordered as well: a dma_rmb() separates the
valid-bit test on word3 from the rest of the descriptor. The control
dependency does not order the loads, and word0 now decides whether a
reset is scheduled; without the barrier a stale word0 - the ring is zero
after open and after every reset - would schedule a spurious one on
weakly ordered CPUs.

The check also covers two cases the count was left to cause. An RRD with
a count of 0 was never consumed and RX stalled on it, in an endless loop
inside the poll when it also had an error bit set. A good RRD with a
count above 1 was consumed without recycling its RFDs.

Count an errored descriptor as work, so that the refill runs when a poll
sees no good frame. Clear the RRD ring on reset: the RRD and RFD rings
advance in step, so an RRD left over from before a reset would pass the
check above and release a freshly posted buffer the device still owns.

The hardware already counts these frames in its own error counters,
which atl1c_get_stats() reports, so no software counter is added here.

Found by code inspection; the error path has not been exercised on
hardware.  The RRD validation has been runtime-tested only on a
single-queue device presenting as an AR8151 (emulated), not on genuine
Atheros hardware and not on a multi-queue device.

Fixes: 43250ddd75a3 ("atl1c: Atheros L1C Gigabit Ethernet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Federico Musto <federico@rimpianto.com>
---
v4 -> v5, after the Sashiko AI review of v4:
 - add dma_rmb() between the valid-bit test on word3 and the reads of the
   rest of the descriptor; the RRD ring is zeroed after a reset, so a
   stale word0 would otherwise read as rfd_num 0 and schedule a spurious
   reset on weakly ordered CPUs;
 - no other change.

Runtime validation of the RRD check so far covers an emulated
single-queue AR8151 only; Tested-by: on genuine Atheros hardware, in
particular multi-queue, is welcome.

This patch applies textually only on top of patch 1/2; please keep the
two together.

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

Pre-existing and left to a separate patch: word3 is __le32 but is read
without conversion.

v4: https://lore.kernel.org/netdev/20261117225521.19689-1-federico@rimpianto.com/
v3: https://lore.kernel.org/netdev/20261103225218.19206-1-federico@rimpianto.com/
v2: https://lore.kernel.org/netdev/20261102215253.68185-1-federico@rimpianto.com/
v1: https://lore.kernel.org/netdev/20261027115156.17128-1-federico@rimpianto.com/
---
 .../net/ethernet/atheros/atl1c/atl1c_main.c   | 104 ++++++++++--------
 1 file changed, 59 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index afab3e1..8383203 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -971,8 +971,9 @@ static void atl1c_clean_rx_ring(struct atl1c_adapter *adapter, u32 queue)
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
@@ -1904,23 +1905,16 @@ static void atl1c_clean_rrd(struct atl1c_rrd_ring *rrd_ring,
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
@@ -1934,6 +1928,7 @@ static int atl1c_clean_rx(struct napi_struct *napi, int budget)
 		container_of(napi, struct atl1c_rrd_ring, napi);
 	struct atl1c_adapter *adapter = rrd_ring->adapter;
 	u16 rfd_num, rfd_index;
+	u32 rrs_word0;
 	u16 length;
 	struct pci_dev *pdev = adapter->pdev;
 	struct net_device *netdev  = adapter->netdev;
@@ -1952,47 +1947,66 @@ static int atl1c_clean_rx(struct napi_struct *napi, int budget)
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
+		/* Order the rest of the descriptor after the valid bit: on
+		 * weakly ordered CPUs word0 can otherwise be read before
+		 * the device's write of this RRD is visible, and a stale
+		 * word0 (the ring is zeroed after a reset) would schedule
+		 * a spurious reset.
+		 */
+		dma_rmb();
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
2.54.0 (Apple Git-157)

