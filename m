Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.14.198.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102890;
	b=tlTAI+14kmYxoVrP3uvxOWv5emYI2q1aJ7m5ryv/wONE1PYs0vfnku2XrgdxZiH8ZypF
	 BLx05OO697n7OVKPdqstWV3XvO75yt3oxHZAnojoUOR5Icpvd33PjYgmbog9UGzo8qccs
	 VHa+Xet+scZuXCoQHnhG+VdIl85xA401aXtTenN+sheeY8b+HjdUfAvm9VIwe5FFO9so2
	 UxYyJvQDFHTdyE92lD9P2Ej9OiPF0f5LsP92EONcJ1/NeeJv0NIKdLmTm2w7V1HWoCtqf
	 tM8mRlM3j8CFjSnF6eRzhggxWW8tNezA5PvFu7kpoZbIVihVMIlKj6aKUnIAGqA2f/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102890;
	h=DMARC-Filter:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Received:DKIM-Signature;
	bh=iJ1Nfpl2TinUNkpTG4ohkPo/oX2ZD3x210L8IQ08D14=;
	b=qUVLGOcoapmTeibiey9Dfc8VgaafcJjvnE3XRGySkM5MzMvi+bAplChnVgGqs1lyJsUh
	 KPrUj+RluJsSCHuZKZyxcI2rKhgATLXNpF9kuewRk0y5wjcLmOjI9KISE7j8VaxxHdvEy
	 tNoE49w6stOPe5Om8NTmSJEWpm4kftr/vnxtEn4slCxrCgYrQ7m6S0CuLWos8yLZ5PTcq
	 Uvjn2+UaRpIOUZg0//E5bY2M+JWt6G8WnGVid6Ha5za003rOiAtl9glsjs5d1VNIIi4pV
	 6Mm9AB6TtlF8H4nLWtTp91GVNEnaOgdKKarKLqbdO0nX6Sfwlwb2MTIqe3ecV/a4jUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rimpianto.com;
	spf=pass smtp.mailfrom=rimpianto.com;
	arc=none smtp.remote-ip=46.14.198.178
Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B817A606A31D;
	Tue, 27 Oct 2026 12:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B817A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: mail.rimpianto.com;
	auth=pass (plain)
From: Federico Musto <federico@rimpianto.com>
To: chris.snook@gmail.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Federico Musto <federico@rimpianto.com>
Subject: [PATCH net] net: atl1c: free the RX buffer when the descriptor reports an error
Date: Tue, 27 Oct 2026 12:51:56 +0100
Message-ID: <20261027115156.17128-1-federico@rimpianto.com>
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
	by mail.rimpianto.com (Haraka) with ESMTPSA id ECD9B085-34C4-401A-BE21-7661E91ADE66.1
	envelope-from <federico@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Tue, 27 Oct 2026 12:51:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=s20260314391; t=1793101917;
 bh=iJ1Nfpl2TinUNkpTG4ohkPo/oX2ZD3x210L8IQ08D14=;
 b=FDIqmYn6/O3kkRnbmBj/C0JLibmeR2LwCYrqqfmufMs8rcAl+lOec5KFHhHQGfdJlULS4y+Qp
 Kup/f2MF+f+3fvgPHm+3O7NYmWGjuT9iUChkIaunemnheNo3O7Ooemlz+0qUVKrW3UnJw/zAnTr
 Ecyx3g3xpZqJnpKykkl658UQRTnfwn1fpIvbz+zUv3CCd+2LtokLy2oDALA+owD7kcpt7sH9pBD
 eNXgnJ2akF80/6yvHNAhW4acBJHWqxCtkXzt2rSqXocWBk+CxMQEHrgu5btxWAAcPrgOlG9hag+
 JN0uOMeMc6I3mloz7PjID5/tJs/31NBv/CHrF5in23Qg==

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

