Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.21.23.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965915;
	b=sxxv+cknWezTGnvTMCVHNvJYNmL0bhqB5UCOyBiljI11n5ugSeRQ43p/En4PCzr/cfa3
	 qhs0xzupyjeqvqyFH/JnzGongru24qTghzZORAd93U1GhO78fJ/497OV9to/1hCDR5G2V
	 hal6MTGfnG9yvbhz7hyTcPQU/1xSIiHCj7XxOoCqiPTXwBOGS3q4dgaQzUdMLwmSs4qcP
	 WNkPVX70xy/ONWyq2LwNdF/R4+3hXoXcfIoTaN1nQ5eBc9UmipUv3wjZ/UCvenaV7sp61
	 ankNNv4y/DRlq7Uemod9vuJ59ToWv2JAaPSOQCAFZNdzbrIbWFBuGSSwd8bZUaQ7MSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965915;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qNCPz1qS0WlotHwtOcXkBBv1t3RqQf7gB9qlyBr1wno=;
	b=01oxH5tA25Xd5bVvjQYNZxcDjr5N8KPTUmj6ts42fCbesVcd0cYT5JmIjjWl659Oe3p1
	 D/qWw08rXPly9vdGWchJJFLZldQRXQXdTx3TO4C63yRcWOTnIJkOXgOOnnaBceUA8IH1U
	 3DjhES69LaI2h4dKPBF47J7AyQE/UKElaS5cMofvW7nMdTQAyEplNjRyv/0xTTny3ene7
	 XB9U6JVO/95Us4f6iizobXuZ4lb1PReTSCdFimUJI2aiylKczFEoCtrd/n1vWQ0S4Q9Ig
	 1sjqCcndNxZblqFDY0F94TK3oErpz16CjicNvtd8WOW/f2dVoNXegM4otS4fsrhRr4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=disroot.org;
	spf=pass smtp.mailfrom=disroot.org;
	dkim=pass header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256 header.s=mail header.b=CwUbqx4K;
	arc=none smtp.remote-ip=178.21.23.139
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACAF606A32C;
	Fri,  6 Nov 2026 11:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ACAF606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256 header.s=mail header.b=CwUbqx4K
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9FEE080715;
	Fri, 06 Nov 2026 12:51:52 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6S4EyYb3b8WD; Fri,  6 Nov 2026 12:51:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1793965912; bh=bHsCy/8Mgc9r9WQB/zRflWkg+WKF0J8K86mGDeLdTFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CwUbqx4KL3V7ac6SIzCcniXy8SVsO5VFRL8UisBs3WJEpO+8M9xPh2KgmwI5JcGua
	 AgMR4n1nsvsK3TTUOv8glUDHgxFT7dVgMcR0cNqoXIvxTnZGiSZLnb+SbtoBsJWePb
	 ELHzQakKZvU5HwhFWzF5EcB8JKKX1ltIWNaUipY8VwyIHt7M7RXhya1hi2v9MuII/n
	 dXObC1thwjBAgz6j4at3umszIEuJ5yHq+tFvAdcSJhc76ddj5z6n62z7oDzZ1VExlA
	 eP+soAoouAFcYRmMkS8Z8ALkVeoqwZxaWRYYv2Wj8YjltKXdnbScEzIAYNegngb4Ed
	 D2i8oKlY5LgvQ==
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
Subject: [PATCH wireless 2/2] wifi: mt76: npu: read the rx slot count after the first slot is complete
Date: Fri,  6 Nov 2026 11:51:13 +0000
Message-ID: <653d93b3c35975cd13dd6b33d76ea6517b55be91.1793927986.git.fmaurer@disroot.org>
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

mt76_npu_dequeue() reads the slot count of a frame from the info word
of its first descriptor before checking the done bit of that slot. If
the NPU completes the slot in between, the count is still the 0 left
by the refill, so a frame spanning two slots is taken as a single slot
frame and its second slot is parsed as the start of the next frame.
With mt7996 this shows up as bogus tx-free events, which hit the
WARN_ON_ONCE() checks in mt7996_mac_tx_free(). From the code, such an
event can also release tokens that are still in use.

Check the done bit of the first slot before reading the slot count,
and order the descriptor reads with dma_rmb().

Fixes: 7fb554b1b623 ("wifi: mt76: Introduce the NPU generic layer")
Cc: stable@vger.kernel.org
Signed-off-by: Florian Maurer <fmaurer@disroot.org>
---
 drivers/net/wireless/mediatek/mt76/npu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/npu.c b/drivers/net/wireless/mediatek/mt76/npu.c
index 6e503a4a890c..f00ae683a7eb 100644
--- a/drivers/net/wireless/mediatek/mt76/npu.c
+++ b/drivers/net/wireless/mediatek/mt76/npu.c
@@ -72,18 +72,25 @@ static struct sk_buff *mt76_npu_dequeue(struct mt76_dev *dev,
 	int i, nframes, index = q->tail;
 	struct sk_buff *skb = NULL;
 
+	if (!q->queued ||
+	    !FIELD_GET(NPU_RX_DMA_DESC_DONE_MASK, desc[index].ctrl))
+		return NULL;
+
+	/* The slot count is only valid once the first slot is complete */
+	dma_rmb();
 	nframes = FIELD_GET(NPU_RX_DMA_PKT_COUNT_MASK, desc[index].info);
 	nframes = max_t(int, nframes, 1);
 	if (nframes > q->queued)
 		return NULL;
 
 	/* Only take the frame once all of its slots are complete */
-	for (i = 0; i < nframes; i++) {
+	for (i = 1; i < nframes; i++) {
 		int idx = (index + i) % q->ndesc;
 
 		if (!FIELD_GET(NPU_RX_DMA_DESC_DONE_MASK, desc[idx].ctrl))
 			return NULL;
 	}
+	dma_rmb();
 
 	for (i = 0; i < nframes; i++) {
 		struct mt76_queue_entry *e = &q->entry[index];
-- 
2.47.3

