Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808881;
	b=spmYXSzTRs+fMfS4pAkBd0DQ/oHd7eSG4fxxBrRqM+u7W6BMWs/0+5lw+lHOcwbmmN0w
	 xTghmfpTxNtso8497q7OzOB+9QsGgFPDkPcp5BX/XZmvyUgPo1JUdCnCt4+Ef4Kf2GutT
	 Ssnpva0OTFVcSP41yJW3BsS9FJAN4T87dWIOKKH6o4BOP9+8RfJ6idJofvvUnd5tBwtaZ
	 M2rmYVljFmuYIvY+GeeSqQU+NwblrpcCG0VGxeUKWHMXpyXwkeVQ5RlMjuxrV5B9Wk9X6
	 MGhPlZu8pLPjvI0vtC9LgloD4ah+panCivqJf6z1KJcCbP2+SoIL+ypE9prK2YZKPHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=8RGDeXbdt83hUd3Brk6p8Eodv6wi4lD1lBh2U2cXcg4=;
	b=1o4z4Xy2VOQr65GKIRSUdkP65Nzz0uQ+d8ShY6dwL7JHwa073cw3fah3N9jWlUPSSHrw
	 N/iURbe2ONmAABLSYGMGxFCZh4vd47XTylmacOXpsNU+KKVbus/GGrl0v2W1FAggedSDZ
	 IMGRvfANPLeDwXxQ/3+5bZfooCH0g+6ow/RXlUaHZS7JNkQWYF3oZ3agBXI+OVscnl0Cu
	 c5hxAtblurUj+KFmj7fatEX/Cdxr8ZdptPM5Jz3S1gLorhSC5ypacBKbROkNkWFD14517
	 cm4I6JwgthqNPmbNS0E04nq3YLfiqRw30W1Pu0YrnsaHBmQjZ/qmWKyDD2/3HTkRW8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YSa2PLI9;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3661606A332
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 06:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3661606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YSa2PLI9
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-8629ef8613aso607444a34.3
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 22:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794808880; x=1795413680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8RGDeXbdt83hUd3Brk6p8Eodv6wi4lD1lBh2U2cXcg4=;
        b=YSa2PLI9ZUDClu6nDGotU8VFw8wtjPXp3RFQfvmYn123apOYjKSvWQnToEiDITw3wf
         JycWpioIx617Nw3gyBalRmI9Q+fcCz1nJ2EhMaKeN9ulQAgTUyAmmqbsRijRHk6PpRW6
         VwI+DaFvRCqTkMhnZt/9vukHDxifYqwzek0WKiXsVXCfNod7Os7mX55dGS53bwH7WhAo
         rkoXYasE1vmGB37nVinv45IIG0ZQGzw9rL2MLqsB/UZu57dIUUh20/lvqZHpTwYgIFeR
         xK1MuxXbR4fLixHGKZoCPBEOdEspDwh8icX3ErEtHg1y0uxypddG9/sC+fS2St8joHLY
         12VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794808880; x=1795413680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8RGDeXbdt83hUd3Brk6p8Eodv6wi4lD1lBh2U2cXcg4=;
        b=KsMMBbudUjgyROxzI4yb5DuiHeLDdVy3E5jq2Ty/m/mAv0RGyFTfdjdiAvChQPBnLM
         7U5oDZw85rz7TwGYDK3LEOKB2BOunH2uo3MhnUQdQV4lIC0sHQbLBsT4tqXePYN+Y5lQ
         BK49Nrhy5ryvIlSxrTJFcgZyoACsBV+VG+qcNIJZtHOGVNcDscibWgYKK53GZeH3VdNT
         lnWP8a4o+KdTKTd9aMSN53Bs0Axd5qH9RGNF7E8twok5ffZeY958a/WBvPaSMW5TJB2D
         KlbiZLiomKPdU/7focyjmYmnK7gTZjSGs9jTF/rW4/TFxe+xxK9uY4KYhhE8/w96ANvV
         9qyQ==
X-Forwarded-Encrypted: i=1; AL+hErFTJtw5gLwE/3NDux23W4pqsNiKbgLDmCboYVcKlRyCj0EgP1qSD1I2f39Yw4MCsRqaG+Cxhjo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+mNvcOnACrapkqaiTbG8pUW32dFPESZ0dev+1ixS8ldg0Xc6bG
	0Egq2f8UElAmt7j5ID0ZzWuzfX3e+9sAEMJ+KIo8inRNhPSZEjADmtjJ
X-Gm-Gg: AYBFou0eteIlascUb41tt/xtmPO54hp1rDejW5CKCFjwr9k4NF4nocUfCutuv6hfFtj
	yddbWPs1io6w75ZD4Zu5YNIEmPtAS/fSXBuicUnbJAdPU10jOVM6Q2SMD/MirSQ+tCN0H5Ye4iB
	V6zn1VKy4BJakJqWrzpDH0LqVoVaTzTwu5F7/6R8CNeazJqAS4SRZWzkxY5GtTate9uJPSaISHZ
	m7afx5mjR/5kxU3f0E9xMXBmLGbAd4ThOGhggDqNR+RVa94jLY+nfhABfT+uYn8AOIOzRUikMt1
	VxOL8zk3INN2hSztIP7Kag+3YxSLoVsdz5L0scqFJENCcH01CHjIaTqlzSfH4OpnlBdQ6Y/S2Qe
	te5bx/gj48NEIHH0FTOJVwpzw28m3/vHJR5e8Yrxj59LL0scUx5cfp1i4eEcxchZFp5oKMhrcA7
	cR7A7i2r8h+YBj7kzV/n8vUK9YOQwH776t+n96/0Ax4t+CedWDj/RZniQH+xkiiY57IQUFpvWnr
	5cj+M55/ya1FF1zZ0L0bCvIKX5uaGj1qtauyByzoxOWsyS1I8uZvm6pOKReN3rp1PHMUBQ1r/F0
	U7QaTFrdmdnGeoWt16UL3/SXdEjaNp7aIyzaHo29SsKKQ5i+ch9Ea10FmgxAFVn/CHV3nVx9Yw8
	x6daMGIVcrjWGzM+kEYvZpd6Ux6AxOf3pQpEo6Y4ZgGbH900KkOxOWGlnEQfb1aXxpLncPjrVdv
	iUFM3hyGNuasRm6uONFeEQve+ERC3ec0aWt8wAptIp+UguWF0saMQ=
X-Received: by 2002:a05:6830:460a:b0:862:a0ce:f55b with SMTP id 46e09a7af769-862a0cef986mr3350568a34.20.1794808879597;
        Sun, 15 Nov 2026 22:01:19 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862881a965esm9375160a34.25.2026.11.15.22.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 22:01:19 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 15 Nov 2026 23:00:42 -0700
Subject: [PATCH v6 1/7] dmaengine: dw-axi-dmac: keep cyclic mode in the
 descriptor
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-submit-dw-axi-dma-stop-pause-v1-v6-1-bcb23d1e7029@gmail.com>
References: <20261115-submit-dw-axi-dma-stop-pause-v1-v6-0-bcb23d1e7029@gmail.com>
In-Reply-To: <20261115-submit-dw-axi-dma-stop-pause-v1-v6-0-bcb23d1e7029@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>
Cc: Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev

dw_axi_dma_chan_prep_cyclic() sets chan->cyclic before allocating all the
hardware descriptors and leaves it set when preparation fails. The flag
also survives cyclic transfer errors and channel resource release. A
subsequent noncyclic transfer then takes the cyclic completion path,
leaving its cookie incomplete and its descriptor on the issued list.
Its zero period_len can also cause a division by zero.

Resetting the flag on failure or channel allocation is not sufficient:
preparing cyclic work while an ordinary transfer is active changes how
that transfer's completion interrupt is handled.

Store the mode in each descriptor and use the completed descriptor's
mode in the interrupt handler. Cyclic preparation sets only its own
descriptor's flag, while the zero-initialized noncyclic descriptors keep
it clear. Error recovery and channel reuse then use the next descriptor's
mode without relying on channel-wide cleanup.

Fixes: 1deb96c0fa58 ("dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()")
Closes: https://lore.kernel.org/r/sashiko-outbox-208213@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 35 ++++++++++++--------------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  2 +-
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 7520c78f55cc..6dae63024721 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -801,7 +801,7 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
 
 	chan->direction = direction;
 	desc->chan = chan;
-	chan->cyclic = true;
+	desc->cyclic = true;
 	desc->length = 0;
 	desc->period_len = period_len;
 
@@ -1117,25 +1117,23 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 		goto out;
 	}
 
-	if (chan->cyclic) {
-		desc = vd_to_axi_desc(vd);
-		if (desc) {
-			llp = lo_hi_readq(chan->chan_regs + CH_LLP);
-			for (i = 0; i < count; i++) {
-				hw_desc = &desc->hw_desc[i];
-				if (hw_desc->llp == llp) {
-					axi_chan_irq_clear(chan, hw_desc->lli->status_lo);
-					hw_desc->lli->ctl_hi |= cpu_to_le32(CH_CTL_H_LLI_VALID);
-					desc->completed_blocks = i;
-
-					if (((hw_desc->len * (i + 1)) % desc->period_len) == 0)
-						vchan_cyclic_callback(vd);
-					break;
-				}
+	desc = vd_to_axi_desc(vd);
+	if (desc->cyclic) {
+		llp = lo_hi_readq(chan->chan_regs + CH_LLP);
+		for (i = 0; i < count; i++) {
+			hw_desc = &desc->hw_desc[i];
+			if (hw_desc->llp == llp) {
+				axi_chan_irq_clear(chan, hw_desc->lli->status_lo);
+				hw_desc->lli->ctl_hi |= cpu_to_le32(CH_CTL_H_LLI_VALID);
+				desc->completed_blocks = i;
+
+				if (((hw_desc->len * (i + 1)) % desc->period_len) == 0)
+					vchan_cyclic_callback(vd);
+				break;
 			}
-
-			axi_chan_enable(chan);
 		}
+
+		axi_chan_enable(chan);
 	} else {
 		/* Remove the completed descriptor from issued list before completing */
 		list_del(&vd->node);
@@ -1204,7 +1202,6 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 
 	vchan_get_all_descriptors(&chan->vc, &head);
 
-	chan->cyclic = false;
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
 	vchan_dma_desc_free_list(&chan->vc, &head);
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index d8dd07efe60f..3c86e5d468ea 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -50,7 +50,6 @@ struct axi_dma_chan {
 	struct axi_dma_desc		*desc;
 	struct dma_slave_config		config;
 	enum dma_transfer_direction	direction;
-	bool				cyclic;
 	/* these other elements are all protected by vc.lock */
 	bool				is_paused;
 };
@@ -105,6 +104,7 @@ struct axi_dma_desc {
 	u32				length;
 	u32				period_len;
 	u32				nr_hw_descs;
+	bool				cyclic;
 };
 
 struct axi_dma_chan_config {

-- 
2.53.0

