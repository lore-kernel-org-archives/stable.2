Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202043;
	b=rpNa/M70rpT4NBCvACZDvOZcioJ0BTah37tCnPdRylulLaEkZ3MvAwk6TFzMMKE2e20G
	 1aezU4SYvHHTG94UX0DEIJV0Q9miW9s7cKDLVgr9JmxqexsQeB7UWJ3tejj9dfNZezQB0
	 IE4lv3uUYAg68oor5CM4YF6tBE/kLsDtIVdbrmUWOUjCmxNPKebx1qSEHB8WA8oDqTqL0
	 RlFd8VUM3QOt1mEdyj7mcuHsr39okMYklOZnZrGFiu+SVTVpq05eEBIaxSb3QolySyyML
	 f8vMYScZiyEAYKLLRigSoMm0/B81lySclePczqGOAywCqFxkHygPtRW3qpy2o30yHPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=YjkX+SIhmCFu9w6Er5NTY8ZxVe8WqPbD/o8Zqp+diPw=;
	b=GO3qeXcp8xXAul25CRwHGcuh0v3b1Ffpx02ZxVPw5DDa+lfHq3aMNoobCwuD96kri0Zo
	 VO0Y+zUuyjf8i5SlItT3ZueP9ZwpgsYKbSCg7TNppwWpiLV7xeN5b0Ny/+dUQ3Lhp9Tkv
	 af0uOF33D8u1ouxVEmXTe7uyO70449LzYl4CP/BEEEJZGOOgEvIc0nXzti3qnHP1aACt8
	 FkeNQuv/wQxZggetTdUvBy9UXsxWkvZB9OQRF/L81NqawMmvMaH4JIYka084m4fgqPhef
	 aF+uUkpaVwvyFb+ZxzDtb3p5Yg3QFhTT/KxP2vMpBvaiVdgNwWilGIoJU1xf11NMk0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PgJRtcQR;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1309F60A260B
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 19:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1309F60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PgJRtcQR
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-862a5b64755so781642a34.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202041; x=1795806841; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YjkX+SIhmCFu9w6Er5NTY8ZxVe8WqPbD/o8Zqp+diPw=;
        b=PgJRtcQRkArNOOYJpsfqboxt48e5N/IDxRgf74ME4tSG/G2dNoNtOyV3dsWiOgxXgl
         PUSQlqPWYRdXCcQXJz8EUsX9RtaaOqoEBudK3L09fA0FOgQ0Nh4WdZGpaxzD1dpmddug
         wOn1QWh6l9e46fX+V0uIvBN8ApzRUV3fh6UbAmIJNYi2gca24lBu+hLmTaTBXYwebrNs
         ud8D7HO7SHDQ7f6kpkkADqjeFeVFijW+ZlZWvTOr2LH3BE2SlasKPsysTAp+axajtm0c
         Htw3ZJXpgIbtqRPEO/XR29AWqkFU/TvgEX9lvDDfGwoJ2MFJnDk6VkEj954GRS1w4PdR
         40Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202041; x=1795806841;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YjkX+SIhmCFu9w6Er5NTY8ZxVe8WqPbD/o8Zqp+diPw=;
        b=xgu8blr6FpJAJ9fApi1uDpw9HNfXA7y1ZH4bJIHzWg9i/Lxn6peVoqdNdbfERy971i
         coTc5Dompm9B7KHShvvae0tVleOwiCruBHqQwXRLf8Aa8iEaYfoRft0TbLvifBANsy/q
         4c85znWh+lgvhIEmWp3ZTvNYfbylYGY4ehs9Wx2qKjmCIsBXCWZiIhpBXOboGn6Zb4ku
         r9/jF/UfGY3HMS84c/ahL0kjRL9DZglt9PLR2JfhtDCQA0dJGXBPsDjDwc/GShcFwqPa
         /8eHjLSQdFKek5vQINIJa9GD3Xs5bbJFofCZtv4cwXv/pRZHgQqOce29xiLuxikEMrK/
         aMbQ==
X-Forwarded-Encrypted: i=1; AL+hErHRYGqeJoOOqyOLRxBLGLXYSmELnVz/Z5IXkBnrGGZ/iQehLI1t+baLm1AkOR2aoGY+avb7xqI=@vger.kernel.org
X-Gm-Message-State: APuU4Z80ZxuRsJTh2vGBLUTc9YFw6wO5C1PVx5JsVMLxI6EDLk1hkKF1
	T051GETqs6kSvTe0JVIom7fWGafhGs/An8Sc67bnTPyeBI5xITawvcLM
X-Gm-Gg: AYBFou1q3eML47kN7arbIV8eARnj/OWjVcJc8YjvPGaCXMa0V0limFaXH47eotxm9sS
	rIZWT9XS0OkXYyQlqeljvWdFaBfa94haK0ar/K9fjgTAyPX/UdvlHvWx+AvAf7hruTzfKgqvkxN
	7KFHeypY/cqBRHYRaKSZzl+9jZKuAi+GtYCd0dhj1DoZre45fHwmPp2aaDcoR08ghZ2y7IrjFlb
	8o9GpiH2JMyDhq1C46a1bVk876lBDeqr2VuMa5wYqDGiQGYhdWXXlt/BRtBMVcMxneGS63LpGNe
	xgAoMGvkSHg4qaFA2bQODz/spo+blKABWLbgpWoFo9U8v1fsXZizEPvmjrUlstdpyWe6QIAdrPu
	jcVGHXh3nJAyScT8ykIC4ynwR1xqiI4uGSbmVAROJdb73DUls0CnxZwE0qf3z3/CkJfeUeQsw/q
	b+coKA9XBcytyGShDXcDpkR6aUt7B2Q4hwjrHAMEGMgxYJakg036RuS/KpDxbKDGyo9BuE101F0
	7ttP3bcGeih4XBQ3uFIcjhlr7J97S2ocvvc5g7ORWyTDnBI4wkM4GGSJFnhrMyLlwsbKKRz29OC
	fiyKv4kWjHdo4BE1D4ractPVbiUy30qPVpnj2KBGHkjSI7ZcMU05UOxhSVyNPwexB3VNnmpgrtj
	75miP8arnrucTrtImjCo6lcdplA7iMtyAEZaPdHq+ok+rMLnshO1semjtCi0h8sXzZ8j4T+bWHi
	w3uuCPZCcNRwyJsOnzK0sCkQTcgwjjRwN09KU4EiYLFFj7tvMi8ZuA
X-Received: by 2002:a05:6830:4ac5:b0:81e:b506:592d with SMTP id 46e09a7af769-86315987fa5mr4981894a34.27.1795202040971;
        Fri, 20 Nov 2026 11:14:00 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f3964sm2654782a34.14.2026.11.20.11.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:14:00 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 12:13:51 -0700
Subject: [PATCH v9 1/9] dmaengine: dw-axi-dmac: keep cyclic mode in the
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
Message-Id: <20261120-submit-dw-axi-dma-stop-pause-v1-v9-1-48ab58961d6e@gmail.com>
References: <20261120-submit-dw-axi-dma-stop-pause-v1-v9-0-48ab58961d6e@gmail.com>
In-Reply-To: <20261120-submit-dw-axi-dma-stop-pause-v1-v9-0-48ab58961d6e@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>, Baruch Siach <baruch@tkos.co.il>
Cc: Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
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

