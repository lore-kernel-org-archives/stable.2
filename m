Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.14.198.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746347;
	b=h4W3pJIGV6p9rI6WsRLjbzafwPrcYnNtKvEK1upjGRuHJApDXMPtSe61wxoinrppbody
	 YO8FPsAw7ZeBFvQzw8rOwqAoQzY22Dzssnd48TifcbPRPIjpQMzRDGSK40dltaFrknRi6
	 FAYOS0grBEOpFsVxhasFVq/0b6/EuA93YaE9ZK1hjJhGLDXJt2ErIORfhkTUoL/W4TkAZ
	 yEYknL10wrDKs/brqW3pByVtm/i3JaS3MVEqjiQs/qpykxg8gCHSGwlbw3QclACn9Xzau
	 SMiN2XAVtfUAt0rY/pq/uzxCTwGbN2Xq2KY+2Y9Dh5G0P8QIwVv7vprAl32HFAU2Cgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746347;
	h=DMARC-Filter:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Received:DKIM-Signature;
	bh=nA+o7aI2kHzI0LDKF2Nij4UJ5KGoZ4T1BNF4tUWoql4=;
	b=3HTZ9bDEYyUVEiTf2532F4Yxpa0laqnONguTaBx8uHfl9J60hM2sh53EJQkcS7muhlMC
	 J2UOFaw3YPkzuvbukUiEyyQHG0dzjuN22iPQUp6lE62vUMb4X/bq2WAiKYJ3et1MQpVse
	 wmlCYItPoNQf1wluHpUbzivzBQUGzlLV9MlUdodSMNcEBRKxCppX4BaJC5WyzcINxqT0f
	 ObkWzlJtv7M7gpGPIyYGDi9WHiKlw3n35A5PRDPdu42VvG4wJDI6AnKO/8ZsEFsWoFjJT
	 Uebdt0t/BXs0DU3SZqN6gOutOqDxKrA84Xm+2Wv+TXZw7TIhv1eEbKk/7loOpwvoPgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rimpianto.com;
	spf=pass smtp.mailfrom=rimpianto.com;
	dkim=pass header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=NP+hRU0k;
	arc=none smtp.remote-ip=46.14.198.178
Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117CE606A31B;
	Tue,  3 Nov 2026 22:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 117CE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=NP+hRU0k
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
	federico@rimpianto.com,
	stable@vger.kernel.org
Subject: [PATCH net v3] net: atl1c: free the RX buffer when the descriptor reports an error
Date: Tue,  3 Nov 2026 23:52:18 +0100
Message-ID: <20261103225218.19206-1-federico@rimpianto.com>
X-Mailer: git-send-email 2.54.0
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
	by mail.rimpianto.com (Haraka) with ESMTPSA id C4D89676-CAA1-4582-A49B-E37E648CD050.1
	envelope-from <federico@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Tue, 03 Nov 2026 23:52:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=s20260314391; t=1793746338;
 bh=nA+o7aI2kHzI0LDKF2Nij4UJ5KGoZ4T1BNF4tUWoql4=;
 b=NP+hRU0kHPktbP1Nv3b+nJPpZo2+/u1t7VPaKxFi3xUXHTBxS9SOgm7d0GRp/ghin7oY3SCUw
 em+sr0EOP1mX9SHbmd2r4TFGUUfadrsfWd9MyEGcKhF110IAEPhVxeHXd1FS9zS7Y/PUYgzXn12
 2KQx9SHKyleYgKV0t0PDLynzvDqLNyZhpsxRTdin7N71d6ZgihWmhqvi3n5aW4NvLYN/t+3CHpD
 OnicR1MvrYfkqkrsNxhRzSi0y19jSKSU5RGKOe/yFvLXyc8P61yyehOofU+xLmiNlno2fiOjFsa
 zajJmW0MoxcgrZ8Eo4+9AlxXuA0dZg1p5DQDCdGtDF8w==

atl1c_clean_rx() drops a frame whose return descriptor carries
RRS_RX_ERR_SUM or RRS_802_3_LEN_ERR by calling atl1c_clean_rfd(), which
only marks the RFD free and clears the skb pointer. Nothing unmaps the DMA
mapping and nothing frees the skb, so every errored frame - CRC, alignment,
truncation, runt - leaks one skb and one DMA mapping. The driver uses a
32-bit DMA mask, so on a host without an IOMMU each of those mappings also
pins a swiotlb slot.

Unmap and free every RFD slot referenced by an errored RRD before the slots
are recycled. Decode word0 once in CPU byte order and use it for both the
RFD count and index, so the unmap and the subsequent RFD cleanup always
select the same slots. Share the unmap helper with the good receive path.

Count errored descriptors as completed work so the RX refill also runs when
a poll contains no good frames. Clear the RRD ring on reset, preventing a
stale error descriptor from causing a freshly reposted RX buffer to be
unmapped and freed while the device still owns it.

The hardware already counts these frames in its own error counters, which
atl1c_get_stats() reports, so no software counter is added here.

Fixes: 43250ddd75a3 ("atl1c: Atheros L1C Gigabit Ethernet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Federico Musto <federico@rimpianto.com>
---
v2 -> v3, after the Sashiko AI review:
 - decode rrs->word0 once in CPU byte order and pass the same value to the
   unmap and RFD cleanup paths;
 - unmap and free all RFDs of an errored multi-RFD frame, with ring wrap;
 - count errored descriptors as work so the RX refill cannot starve;
 - clear RRD descriptors on reset so stale error reports cannot free newly
   reposted buffers.

v2: https://lore.kernel.org/netdev/20261102215253.68185-1-federico@rimpianto.com/
v1: https://lore.kernel.org/netdev/20261027115156.17128-1-federico@rimpianto.com/

The issues were found by code inspection; no hardware test has been
performed. The pre-existing memory-ordering and link-reset/NAPI races are
left to separate patches rather than expanding this fix.
---
 .../net/ethernet/atheros/atl1c/atl1c_main.c   | 52 ++++++++++++++-----
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index eddd840..0d7d842 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -912,8 +912,9 @@ static void atl1c_clean_rx_ring(struct atl1c_adapter *adapter, u32 queue)
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
@@ -1846,14 +1847,11 @@ static void atl1c_clean_rrd(struct atl1c_rrd_ring *rrd_ring,
 }
 
 static void atl1c_clean_rfd(struct atl1c_rfd_ring *rfd_ring,
-	struct atl1c_recv_ret_status *rrs, u16 num)
+	u16 rfd_index, u16 num)
 {
 	u16 i;
-	u16 rfd_index;
 	struct atl1c_buffer *buffer_info = rfd_ring->buffer_info;
 
-	rfd_index = (rrs->word0 >> RRS_RX_RFD_INDEX_SHIFT) &
-			RRS_RX_RFD_INDEX_MASK;
 	for (i = 0; i < num; i++) {
 		buffer_info[rfd_index].skb = NULL;
 		ATL1C_SET_BUFFER_STATE(&buffer_info[rfd_index],
@@ -1864,6 +1862,20 @@ static void atl1c_clean_rfd(struct atl1c_rfd_ring *rfd_ring,
 	rfd_ring->next_to_clean = rfd_index;
 }
 
+static struct atl1c_buffer *
+atl1c_unmap_rx_buffer(struct pci_dev *pdev, struct atl1c_rfd_ring *rfd_ring,
+		      u16 rfd_index)
+{
+	struct atl1c_buffer *buffer_info;
+
+	buffer_info = &rfd_ring->buffer_info[rfd_index];
+	if (buffer_info->skb)
+		dma_unmap_single(&pdev->dev, buffer_info->dma,
+				 buffer_info->length, DMA_FROM_DEVICE);
+
+	return buffer_info;
+}
+
 /**
  * atl1c_clean_rx - NAPI Rx polling callback
  * @napi: napi info
@@ -1874,7 +1886,8 @@ static int atl1c_clean_rx(struct napi_struct *napi, int budget)
 	struct atl1c_rrd_ring *rrd_ring =
 		container_of(napi, struct atl1c_rrd_ring, napi);
 	struct atl1c_adapter *adapter = rrd_ring->adapter;
-	u16 rfd_num, rfd_index;
+	u16 rfd_num, rfd_index, i;
+	u32 rrs_word0;
 	u16 length;
 	struct pci_dev *pdev = adapter->pdev;
 	struct net_device *netdev  = adapter->netdev;
@@ -1894,8 +1907,11 @@ static int atl1c_clean_rx(struct napi_struct *napi, int budget)
 			break;
 		rrs = ATL1C_RRD_DESC(rrd_ring, rrd_ring->next_to_clean);
 		if (likely(RRS_RXD_IS_VALID(rrs->word3))) {
-			rfd_num = (rrs->word0 >> RRS_RX_RFD_CNT_SHIFT) &
+			rrs_word0 = le32_to_cpu(rrs->word0);
+			rfd_num = (rrs_word0 >> RRS_RX_RFD_CNT_SHIFT) &
 				RRS_RX_RFD_CNT_MASK;
+			rfd_index = (rrs_word0 >> RRS_RX_RFD_INDEX_SHIFT) &
+				RRS_RX_RFD_INDEX_MASK;
 			if (unlikely(rfd_num != 1))
 				/* TODO support mul rfd*/
 				if (netif_msg_rx_err(adapter))
@@ -1908,11 +1924,22 @@ static int atl1c_clean_rx(struct napi_struct *napi, int budget)
 rrs_checked:
 		atl1c_clean_rrd(rrd_ring, rrs, rfd_num);
 		if (rrs->word3 & (RRS_RX_ERR_SUM | RRS_802_3_LEN_ERR)) {
-			atl1c_clean_rfd(rfd_ring, rrs, rfd_num);
+			/* atl1c_clean_rfd() drops the only pointer to each skb. */
+			for (i = 0; i < rfd_num; i++) {
+				buffer_info = atl1c_unmap_rx_buffer(pdev, rfd_ring,
+								    rfd_index);
+				if (buffer_info->skb)
+					kfree_skb_reason(buffer_info->skb,
+							 SKB_DROP_REASON_NOT_SPECIFIED);
+				atl1c_clean_rfd(rfd_ring, rfd_index, 1);
+				if (++rfd_index == rfd_ring->count)
+					rfd_index = 0;
+			}
 			if (netif_msg_rx_err(adapter))
 				dev_warn(&pdev->dev,
 					 "wrong packet! rrs word3 is %x\n",
 					 rrs->word3);
+			work_done++;
 			continue;
 		}
 
@@ -1920,11 +1947,8 @@ rrs_checked:
 				RRS_PKT_SIZE_MASK);
 		/* Good Receive */
 		if (likely(rfd_num == 1)) {
-			rfd_index = (rrs->word0 >> RRS_RX_RFD_INDEX_SHIFT) &
-					RRS_RX_RFD_INDEX_MASK;
-			buffer_info = &rfd_ring->buffer_info[rfd_index];
-			dma_unmap_single(&pdev->dev, buffer_info->dma,
-					 buffer_info->length, DMA_FROM_DEVICE);
+			buffer_info = atl1c_unmap_rx_buffer(pdev, rfd_ring,
+							    rfd_index);
 			skb = buffer_info->skb;
 		} else {
 			/* TODO */
@@ -1933,7 +1957,7 @@ rrs_checked:
 					"Multi rfd not support yet!\n");
 			break;
 		}
-		atl1c_clean_rfd(rfd_ring, rrs, rfd_num);
+		atl1c_clean_rfd(rfd_ring, rfd_index, rfd_num);
 
 		/* A link partner whose l2mtu is larger than ours can hand us a
 		 * frame that does not fit the buffer the hardware was given:
-- 
2.54.0 (Apple Git-157)

