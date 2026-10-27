Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.14.198.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103493;
	b=3ZiIRb57cRi9euzN2vyrnQaAfyxuE3FBc3eXf7km0QjdHzF9U6elZGr0ypzOTwxVIuIP
	 E0knSwD1SDeYow5RP5ottwxBOxCeXAVmjP/JJqocB2JnxfyOVvn/lAD7RqEBeqLGt6+KP
	 PECVG1jKTVoxkfjs2d8q85BnaPeyQcRHMa6aQBd5TkyrqFmiqmni7kIzEtSwdvyyJ8bhM
	 pEQ2w713yYS4gRYb3hC7+3epLgkhTLVPu6w3Gd1v4RXMA5Hl9Z2mObjxcWOxnihvFvyPb
	 41/TsiDlF2fcKQSW4EkrF6nNfXmZNRzkCOCZ9yCK12tbTaU3Vpc5UvEU0uMyH8zkXTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103493;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Haraka-GeoIP:
	 X-Haraka-GeoIP-Received:DKIM-Signature;
	bh=iJ1Nfpl2TinUNkpTG4ohkPo/oX2ZD3x210L8IQ08D14=;
	b=ouSyIIjwQxZoU8NtnWBNe/Qq3OJAf0oZtlZxvUBxLApYIKsDkqnIr5r+KHVYTFsPyCeI
	 QhgGSMiJaejqP+ZAfJS6I3TkyHP58vKjmd78tG2FNq29N3wgWg13eDS66qWu3EtAUVDoM
	 6uZJaAMGRd3V/P5m/LLOYwTRb8adL34NVDUamNfNIAZDyWHCEDi4/vcItd/Gukr8mFIvx
	 ytnb2FxXJsxbsbif04MU5kVpVY76N/MF6xABKc8ghwUrQ13qha84m4OSrqktHzsunfP2L
	 maQQTYrpLBZJ0Yy6n7wbBxH401kqubo5JJpdKibvgsd8N0pnW0Jid8cRIoO+ZJjoASQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rimpianto.com;
	spf=pass smtp.mailfrom=rimpianto.com;
	dkim=pass header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=Mo9PDoWg;
	arc=none smtp.remote-ip=46.14.198.178
Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD7F606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 12:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FD7F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=Mo9PDoWg
Authentication-Results: mail.rimpianto.com;
	auth=pass (plain)
Received: from Mac.littleredfox.internal (213-144-151-178.init7.net [213.144.151.178])
	by mail.rimpianto.com (Haraka) with ESMTPSA id 8F3E3102-F2EB-4E63-920E-365A352252E4.1
	envelope-from <federico@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Tue, 27 Oct 2026 13:18:11 +0100
From: Federico Musto <federico@rimpianto.com>
To: federico@rimpianto.com
Cc: stable@vger.kernel.org
Subject: [PATCH net] net: atl1c: free the RX buffer when the descriptor reports an error
Date: Tue, 27 Oct 2026 13:18:10 +0100
Message-ID: <20261027121810.18654-1-federico@rimpianto.com>
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
X-Haraka-GeoIP: CH
X-Haraka-GeoIP-Received: 213.144.151.178:CH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=s20260314391; t=1793103491;
 bh=iJ1Nfpl2TinUNkpTG4ohkPo/oX2ZD3x210L8IQ08D14=;
 b=Mo9PDoWgNZc3Kab2lDc9p/DvfJMcXcCWNIxz+pcde0Zwm4+XsqqbJqvbLkz8zgzXE3jUrnQL9
 p9JIGH8xHFkvQU2hV9aXvKEzCO2MZkwtoNi+jMFGPMG5NtgxF/q5bC7XYvVWzlILnHW1Bx+uLsK
 BUpiS0mAIpjMLWRj0OADAsMtcSFmaOR5Nid5bfdsYrqlQY+r5q9oOsqz2+TYF9qcTSfcxfe/kmU
 Pj9/UEStsIapRL/HSOUSWjHSPEPTRU4fFTnM3Yv6HVljqm5ZwGlku4r11/aKyViqKzXHMTml5Bz
 5iMOn5vNN0g61Z0n6xTRuiZYMhK6T3WbtuDFQr5KmBiQ==

atl1c_clean_rx() drops a frame whose return descriptor carries
RRS_RX_ERR_SUM or RRS_802_3_LEN_ERR by calling atl1c_clean_rfd(), which
only marks the RFD free and clears the skb pointer.  Nothing unmaps the DMA
mapping and nothing frees the skb, so every errored frame - CRC, alignment,
truncation, runt - leaks one skb and one DMA mapping.  The driver uses a
32-bit DMA mask, so on a host without an IOMMU each of those mappings also
pins a swiotlb slot.

Unmap and free before the RFD is recycled, the same way the good path does.
The hardware already counts these frames in its own error counters, which
atl1c_get_stats() reports, so no software counter is added here.

Fixes: 43250ddd75a3 ("atl1c: Atheros L1C Gigabit Ethernet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Federico Musto <federico@rimpianto.com>
---
Spotted while reviewing a fix for a different problem in the same function
(skb_over_panic on oversized RX frames), by the Sashiko review bot.  It is
independent of that patch and applies on its own.

The guard on buffer_info->skb is there because the slot can be empty after a
reset; rfd_num != 1 stays on the old path, since multi-RFD is not supported
by this driver anywhere else either.
---
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index e58f1d2..2d68955 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -1908,6 +1908,23 @@ static int atl1c_clean_rx(struct napi_struct *napi, int budget)
 rrs_checked:
 		atl1c_clean_rrd(rrd_ring, rrs, rfd_num);
 		if (rrs->word3 & (RRS_RX_ERR_SUM | RRS_802_3_LEN_ERR)) {
+			/* The RFD is recycled below, and that drops the only
+			 * pointer to the buffer: unmap and free it first, or the
+			 * skb and its DMA mapping leak on every errored frame.
+			 */
+			if (likely(rfd_num == 1)) {
+				rfd_index = (rrs->word0 >> RRS_RX_RFD_INDEX_SHIFT) &
+						RRS_RX_RFD_INDEX_MASK;
+				buffer_info = &rfd_ring->buffer_info[rfd_index];
+				if (buffer_info->skb) {
+					dma_unmap_single(&pdev->dev,
+							 buffer_info->dma,
+							 buffer_info->length,
+							 DMA_FROM_DEVICE);
+					kfree_skb_reason(buffer_info->skb,
+							 SKB_DROP_REASON_NOT_SPECIFIED);
+				}
+			}
 			atl1c_clean_rfd(rfd_ring, rrs, rfd_num);
 			if (netif_msg_rx_err(adapter))
 				dev_warn(&pdev->dev,
-- 
2.54.0 (Apple Git-157)

