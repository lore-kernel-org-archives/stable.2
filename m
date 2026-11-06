Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.21.23.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965915;
	b=uRAvaxhFWWoInBXs9sHdtEW7Ev4iFUiag0miignNGVmdi5vlw3hi2zMMH7rzT6/WeWxG
	 6/VbeKqV70sfxmFXmYYkMLZBKlI46O4jRe4qThatvJrtip7OrFCf2OjFM7UbH5zdLC4S3
	 HPfbrR0ihznZCAu/s7VcSvjAbzIfMy867EW4mO8Ztq1bzzXQDOx20k6HYF5y7Kvc308fP
	 N6wVUFluF8VNIJ6YUy7j7NkTaIRNrFZkAk2VwtxiwQJFtpnC/nUFvhZszA/U+Iylgn0Xr
	 xygZXdSjQFVBJUQyfs/h+QH2DENwR0Sg/3YQyH3xqsGG1D6aHEbTZ1ddMhMcbIo3fxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965915;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sowS8VlK0YFuxRXUqxju6orwyRWV15bvieZJXVvCSf8=;
	b=zo3WgIoFTMDHCMbrd/MJcrEAuV/9lBNfFpWpRIbq5iChSApCiTS0+GZKMt+TyoCzUXuJ
	 NtPGLXpXdQGSrqnjQmBRst0GR5bxiTvGgr0yy3XgBbsIqfzwbovu/J9H7QMCHzKzd7JJE
	 p4zgO3OpSpUMkioaBHNkFdJto+KdVc7PTD8i+dWZbrbweELj64Qll8ekg1t/nmktlpBba
	 alT1fxkR7bfuh2YTrKPyS0r+U4AZXYkDu9/CytM3FLaq8npFU/oPs4jxRwQdQAyz3KXln
	 7loZE/PofXIhnlJBz9l08yn7KWBpY4Mt7Ks73a7k7zhNE4Vj8M5Hi36b7pLfGNuhdKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=disroot.org;
	spf=pass smtp.mailfrom=disroot.org;
	dkim=pass header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256 header.s=mail header.b=ADpUlpgz;
	arc=none smtp.remote-ip=178.21.23.139
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECBF606A329;
	Fri,  6 Nov 2026 11:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DECBF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256 header.s=mail header.b=ADpUlpgz
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 29B26806EC;
	Fri, 06 Nov 2026 12:51:52 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W4gt2lxuuIWH; Fri,  6 Nov 2026 12:51:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1793965911; bh=2RDJyczQMowvvA1k3+Z+TXrpMLlqD8QWh6I1S4yjCY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ADpUlpgzIKc2V9n81xWTWSQ87qA/slREk3XS40Uj5B133nv8i0ZiW1mNDe9lN8Yaa
	 YeLJSriuTZC9gBgMGWPKQxlk0d1tXRPHt5LqyS2O2sZoR2YJDth0SRMcNgSt3n/xov
	 KsPMgS6jTaIGvK8LskxXs6MDyWPxcifspQ1UoRz26KxJGMpYmzJCEf+nj7h2+zwxw8
	 xV4+nyY8mbATSpVntKScHfx8puriMd16sKhT+sU+movyq7ahiacg12cKv2VGvnMzmf
	 XkUg3cvwPGzc7Q7UsFfdt0IjFd9IBXhcvYCBLBfzlhMFKlOXpT3umOxIN+0OfpXddd
	 BtEjsBQaqfndw==
From: Florian Maurer <fmaurer@disroot.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH wireless 1/2] wifi: mt76: npu: return rx slots to the NPU only after refilling them
Date: Fri,  6 Nov 2026 11:51:12 +0000
Message-ID: <d6314f34e0965464207656d38a145490b6437aa5.1793927986.git.fmaurer@disroot.org>
In-Reply-To: <cover.1793927986.git.fmaurer@disroot.org>
References: <cover.1793927986.git.fmaurer@disroot.org>
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

mt76_npu_dequeue() writes the new tail to the dma_idx register of the
NPU rx ring as soon as it has consumed a frame, while the slots are
only refilled with new buffers by mt76_npu_rx_poll() after the whole
NAPI budget. Until then, the descriptors of the released slots still
point to the buffers that were passed up the stack, and on the first
round of the ring the slot that was never filled points to address 0.
If the NPU completes one of these slots, the host processes an entry
without buffer, which crashes in dma_sync_single_for_cpu() under heavy
rx load:

  Unable to handle kernel paging request at virtual address ffffffff80000700
  pc : dcache_inval_poc+0x28/0x58
  lr : arch_sync_dma_for_cpu+0x28/0x38
  Call trace:
   dcache_inval_poc+0x28/0x58 (P)
   __dma_sync_single_for_cpu+0xe4/0xf8
   mt76_npu_rx_poll+0x184/0x390 [mt76]
   __napi_poll+0x34/0x180

Write dma_idx after refilling the ring instead, up to the slot kept
free in front of the tail, which is the same value as before once the
ring is full.

Also check that all slots of a frame are queued and complete before
building the skb. So far a frame whose later slots were not yet
done was freed together with the buffers of its first slots, which
were then used again on the next poll.

Fixes: 7fb554b1b623 ("wifi: mt76: Introduce the NPU generic layer")
Cc: stable@vger.kernel.org
Signed-off-by: Florian Maurer <fmaurer@disroot.org>
---
 drivers/net/wireless/mediatek/mt76/npu.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/npu.c b/drivers/net/wireless/mediatek/mt76/npu.c
index c4c7c0af6321..6e503a4a890c 100644
--- a/drivers/net/wireless/mediatek/mt76/npu.c
+++ b/drivers/net/wireless/mediatek/mt76/npu.c
@@ -40,6 +40,11 @@ int mt76_npu_fill_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 		nframes++;
 	}
 
+	/* Hand the slots back to the NPU only once they have a new buffer,
+	 * up to the one kept free in front of the tail.
+	 */
+	Q_WRITE(q, dma_idx, (q->head + 1) % q->ndesc);
+
 	return nframes;
 }
 
@@ -69,17 +74,22 @@ static struct sk_buff *mt76_npu_dequeue(struct mt76_dev *dev,
 
 	nframes = FIELD_GET(NPU_RX_DMA_PKT_COUNT_MASK, desc[index].info);
 	nframes = max_t(int, nframes, 1);
+	if (nframes > q->queued)
+		return NULL;
+
+	/* Only take the frame once all of its slots are complete */
+	for (i = 0; i < nframes; i++) {
+		int idx = (index + i) % q->ndesc;
+
+		if (!FIELD_GET(NPU_RX_DMA_DESC_DONE_MASK, desc[idx].ctrl))
+			return NULL;
+	}
 
 	for (i = 0; i < nframes; i++) {
 		struct mt76_queue_entry *e = &q->entry[index];
 		int len = FIELD_GET(NPU_RX_DMA_DESC_CUR_LEN_MASK,
 				    desc[index].ctrl);
 
-		if (!FIELD_GET(NPU_RX_DMA_DESC_DONE_MASK, desc[index].ctrl)) {
-			dev_kfree_skb(skb);
-			return NULL;
-		}
-
 		dma_sync_single_for_cpu(dev->dma_dev, e->dma_addr[0],
 					e->dma_len[0],
 					page_pool_get_dma_dir(q->page_pool));
@@ -108,7 +118,6 @@ static struct sk_buff *mt76_npu_dequeue(struct mt76_dev *dev,
 	}
 	q->tail = index;
 	q->queued -= i;
-	Q_WRITE(q, dma_idx, q->tail);
 
 	return skb;
 }
-- 
2.47.3

