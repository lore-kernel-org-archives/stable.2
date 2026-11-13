Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562601;
	b=o+cEsaimsQ50/JGhkkeoIzp25CvZ2dYknyvZZvfKC0ef5ggBxvN342GYCatIqJvEuwEL
	 58tlKIK6XZY/eDlj4bPQ3QmUCTecYlgDXQ8/uWRduoEQgW2yp8LXRSwN7SfTIIgVyLDqt
	 SzKMcTeF0pnnnucir/QAON42V9lC+Fcq94iMPMeF5xR1VlLN9lV0Q/RPu0izqt0iJEMlf
	 YI6GkfyW27H9msxChmDVf8+W2FJZAv3KkjbYVIu+DagEP932RgzYcxX1g4zJlWm8hnDhX
	 6FepSyBrFDml/lzlfcztqENlQlno01FfjmamTRsIRmPVKp1wuO8v0fkGjaUf9RtIpHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=8RGDeXbdt83hUd3Brk6p8Eodv6wi4lD1lBh2U2cXcg4=;
	b=llE/NrFzGHho9F1TBI5XuKzBBYRCpxwnJg30WozcbQgRckF3WALaZnoMHywcURPUCAFe
	 QXYG/x4TXnnsTlqgaFFbNO9gr/QlXVjIdPT+jXTQg5h+T/wunmny6d56yJh3AiK9dHe/k
	 9MHCvHSi6bYLSvc7GxZx1lUDt4kuiNONBdpL/A21nsOGKzwkrp8/rerdCDFEvuwDMAoP2
	 vjW3S3znodQDA4Y2jxG5sJYKMwhHyaQxYVqR3VzMX7TL72MxWu574rftndsvupVaxAIa5
	 aZggENc+q2ydhfyL/RIuJiibEGqzhmBMyf7DqhCIxMBSNa0SOUf+B5PDJxOfOpKVfiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="tf0zc6/i";
	arc=none smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851B6606A899
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 09:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 851B6606A899
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tf0zc6/i
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-56431524c22so228461b6e.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794562600; x=1795167400; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8RGDeXbdt83hUd3Brk6p8Eodv6wi4lD1lBh2U2cXcg4=;
        b=tf0zc6/ihUlB9o2k5KIi4wlybtze10y72hz29w4B7FTwmYC9G1c1zPGPPzw88VbADP
         oFXuXhEfxivmWgeexwv4+BPp3ERriMPxx3uJOOQ/Mg12ABrCFMH9OKag9U3V9o/0YYye
         3i8t7WuOvFfnwc1FJNNQNDb6Bj6c/wJ14jxEfJelb7ibQJLan+sFp/bOYwNtU9ebInnD
         5eB26N2XBxvbrWH5+ynf33ywYkH5Q6Wb24csxQKU//5wp1huffZNup8QAqncLsoYYEak
         rE1Tdaclcm/7S44OoUVt2ISoRqR8kBtJtEhm6ekeUvdMCbotzsNbeAn2l8im1ZtPcAzi
         jxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794562600; x=1795167400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8RGDeXbdt83hUd3Brk6p8Eodv6wi4lD1lBh2U2cXcg4=;
        b=Qm+gvYRthRUfL1PNnWwHcpUgylA6AQU3rh3Wcr2AzvwZL/yDIXAnm0yz3hLKDaVac7
         cNWQD8XJsvUcjU8FLBd/oxZwMGUAolcQ56KyLFivffLj6A/xETrCtdbdDqsgKk80g2lO
         J/Dyg4csD4jsEt3bUeHXN/2fr2mnR8tRLkjYn9euneD2KA40k/Bui9f86e2ecqel+6TR
         pCNee8/023MovbVfU1Yu1yGvcZcrxhhk8sMXSz097cYNUEQaxftJapdm1iqZ0n/ndgw/
         GzuqwHEvNmttUd7EvGokKmJ0C//a3f1Jaw9QPolmAlr9n75p3oQXYlwAjdLGiWoAVKGU
         h+6w==
X-Forwarded-Encrypted: i=1; AL+hErFwMzFi/H3dffHYFixxmTNNDWEP0Pza5wIVGVNVO74roE4oGkANX8EMO7JeF0ZGlabilxW7/WQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rg9bd+VC2yFt9tzXtsqh9/KfdBqBD5z4lI6L2dsxOze3xnsGu
	pNjlYT8WHPYVtJpi9sUDbyt17gMCQgbJkIfqKP31SRu7EQzvxHg/3smj
X-Gm-Gg: AYBFou3n9+EcIJ66JoJKLXqiHulczRgam2DcbAJzNpggVSNA1qjoTEkJh860eaY3rcQ
	XBVORT7bLgBx6FOLnpLQwusXjasQ9QvVLxMoFzXyNqqCYR2fFl4cTVR+LwIHnfpZ/6atSogZ/ZS
	ziY9LDCKswk0/lVEXABuZf0BGTVVvoEvSVqGrZjgxfCf8ZrdU0aUDvcI9UYcUtkEWIXxXLE0INa
	4vy6TC25FdyOd8jfxqQmikU3wimn/s2F1aLpN6B5mRwI71C3oTs1ZhN/TI7n1DMgFjEfgmvauTv
	JGpIlQbmSb1XKSaeotlD3k+pH2OXr/lAw5+TbAHGfN9FGlxO+ZPqaXZO2+dOF3sVuoOInUe4eGo
	wRDXb8y3YYClQpDNeenTLnEVgNubdvMqzubiFWFeykTkw+oP54iW6lRCd4yku/SZ6g89YFdUZop
	/CBJSi6Zc8EQjEUj1FZOkrYu77D3ALHs5NzTieW4AzTQcbdygUdRK2Cp/X8La779NHRGE3dnCn0
	sczXsjYXGEJrU3FEMqVr1cSU8HztchlkfGmkdUG6zCjb61hFq+x4bxsEqmUeq4LMx4e9lX1LJOG
	u628MfADtB2o+248OoisjIcU2WcEHVHUTARyRXdrjG1jUGr5PAeAHw9DFfA2zMiiOoZZc8ms3KF
	KoEf3ZnvA9h12XVurtzdNrmPT9XMV9KuqHYqwxqWJKVIcn5a1nNgKSD8gwqbpDi9/fa7yWFvKTt
	tw6JKks+njcVtWPxEk1ErFpIUBN7f9LtprKMKg4t/DRMVZp03wY9jQ2g==
X-Received: by 2002:a05:6808:1713:b0:564:b24:af6a with SMTP id 5614622812f47-56e647df2a5mr1662991b6e.38.1794562600249;
        Fri, 13 Nov 2026 01:36:40 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e6fc42a8asm1627607b6e.3.2026.11.13.01.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:36:39 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 13 Nov 2026 02:36:34 -0700
Subject: [PATCH v5 1/5] dmaengine: dw-axi-dmac: keep cyclic mode in the
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
Message-Id: <20261113-submit-dw-axi-dma-stop-pause-v1-v5-1-8523a27b5788@gmail.com>
References: <20261113-submit-dw-axi-dma-stop-pause-v1-v5-0-8523a27b5788@gmail.com>
In-Reply-To: <20261113-submit-dw-axi-dma-stop-pause-v1-v5-0-8523a27b5788@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

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

