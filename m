Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744778;
	b=dVTNmJ8iAyoXpO9sbO16zTaR2672F+KS+EiKHbzeY7246+wnrQ5mEFBGV53pRf0K3kpG
	 Ci5imAG/pjNp2bbtRz+UKcd2W3Aj+8jI7Mzgx8tvGQ53DpPj9elnt3C4wDecobtM+DfFH
	 kXPNi4wrqyQHJQal6ITF6AsctQ6DyB5ARcjexbrsnhFtj1f27rXBKWBCzb9axxv0jptSI
	 pEIAiUTJGsdAIxwQo+hkGlBIexlpGhsV5qKumpak66fEVjcm/+Kc1/A8+xp4jneQJTgtH
	 8ARcgKNWE/50WrIsAoU5LsUXBKWUGK1lbi0W6bTt/irtA52O7+7jXBDJFLxvSzR63Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
	b=XHh5mixhntt5KdoZOQqGTK3rRLInZLukPjnxQFrMBFJ1CxgzL7VY29B23OzJzMgWyvxv
	 +r9COsh3KFbR8A9LTDqQoK6kBKugb6OlpFB787FbrvRLvmHHkq0fhmfHl8c4U76hvPTsT
	 jAKoE9KzQiUNDy26VU/SEoyXQ8OvUJYVr8vRj7CegTG6UTXPPOIlH4d7XlGVnKuOUbran
	 6SmuWMAsrkYeNyVswWOa2czZhTAUVCHmO+Qh1G9ZKWM0iPKCvNVOW/LTBZx2XhPmn3/+7
	 JhkZxPnfq5wXE9G+gYzKA11AECUERiaJ49EVo7aZjwYE9ehAfaxQoEZD3QM5e6ZL6Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WwbQUKik;
	arc=none smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3CE606A334
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A3CE606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WwbQUKik
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4f699fe49b3so87629b6e.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 14:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744777; x=1794349577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=WwbQUKik78jDIWjrBN+nnQlQ8h2Fmd6FieVI4srUDjQ4kET0EcWXa2CDIiGktyoEo5
         GYb6byH1esLZt50+yeCEwRxLs9rz9vNHOfZZx83+Rfj2eEmJ8oW7GvaLyCMkXg2rAv4+
         fuNmNuILlHorwi3AXxBRufDMYflIa5Qq5ErAAYZTTBeyf95knNshSI0+DBpnTl0Iu4xk
         WpoEU6XdFrUvHEW3pySwCNeAQq/I9iAbxjV6jDrt+cSaUkB6xoDGNI4GNjn+49jrUXbY
         zM7Y3m42mJEp1M0aa7CRZ1I39WLAzRG3Ov9st09yaJoUSUaXv6o8vCCA7cWaDO8ylIlB
         jDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744777; x=1794349577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=KNo4/AxQTSujChg8vFTQ4BvcOL3gdt8N55FgSETTxBUYSovu5t3nyhmmX80UYnzoOL
         cacb+apLSBePckZautk2KNlofPh6IBJA0eGXuSRdz/G++o+Ow1QIjyt4xshKtlR7l/ZV
         0+ogt+dQFn7HEfBq5vX3Qxst5jMLzPFLEucjdjiaMji83jY/WrDI6KpGHHPqdezs//dv
         8apu454btib/piTsH/Uku7bWJMWONiNa4Xme1JmUg8axR8IRsgfPhHN6tOqER1+rlKy6
         Bloeq4KsdATlqYyQ4hcClOrqv6QN1yndf96ETum2wAqzzzA/1tB9GCDof+n2LEl5hHNp
         e9BA==
X-Forwarded-Encrypted: i=1; AKwUvBzVQjTptZaCucvd+DT7o6Uryb3AOMStBBUrQMLpWnIc+oh8SPyoVFx+09HNHOH1sAnFuW6Ak0w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/41GST3oLcO0RPU3hrIC7Yzk8sqoGsIWmTK2CGcgZbOU7I5MWV
	1q0zBqI9Mkche5y+lvREii6AnD0Q4UQGEgkwVQxVZWDkoRUIwrRC0/ZK
X-Gm-Gg: AYBFou17+KXKEsNn5wDui1zS6legUlhz+rqUHyeXg88wcxxaAj0fGFlWWDypD78URrR
	ducrB7ay4Z8XBseU5W25EzfrvUgmmJGAUl4/J4zF/iDPU1JvA+X6C7541DPJ1V5Dg7y/3lc6BQb
	bnxujCZ4xgy828hhbNYQkSJ6SnOAtWcTZOGu0XP82tEHg2VQud6fzpJi5Q/YXjdvYa9OUqNoMuT
	FPzEdTZdSEV4L6XyOuu07npzGFO8/Uszoeg/svoQ/j3DkAX76pNFeanZBkXV4WIRLe02kWfnif3
	iR6ljoOkSjwA40/Oi+nujCVhEP//jBEW5x4F7OCzpIGdxVMsrci0E0XcJPm5ehGZOUHeBsPDT6g
	VQAw9ePlRl1WBNJiuVzQUFi+/MCsGjRzajWXeWQCdOhUKDawBmfjxMR85Jg8F95mYN3K3KqA5mc
	P0dZTTHr5fzgLQH1pi/0kGyeaVoGmB9n9YxQgd18uQmTqrJz7r6EQm6UEUWredKLJTzndJIGiiU
	cDbaJsm0HBcMGmx+SUaUKUxIlgXpJ5F8cqRjAaWmB2WNftwmfA8Dbm/oUqXvcyslXw6ifbpVwdQ
	4jamZ0DesrRhQk7v/pbkKm2lwFSguAy+btTLMLLuM7bi3OnB1N4aKucGBW/OJNbinW5OVarYKU/
	Xxr3d2I51eSaNoM3jZh8gzizSCPcveb3DmtCKc15FX9mYw6tOF/58NyJURrcsQ9YGN199A743mu
	vbZfQoSZqJhsDlzWbdDEzRdO1y6xSASCfRl3+ZSJ+yJSO4nmtWk4m52LFxu0RqGVQs6XghfKG9
X-Received: by 2002:a05:6808:6408:b0:4d6:9283:1df2 with SMTP id 5614622812f47-5640de79c53mr9577178b6e.61.1793744777140;
        Tue, 03 Nov 2026 14:26:17 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef58b1sm128435b6e.3.2026.11.03.14.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:26:16 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 15:26:03 -0700
Subject: [PATCH v6 01/10] dmaengine: dw: Fix XFER bit set, but channel not
 idle error
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
Message-Id: <20261103-submit-dw-dma-synchronize-v1-v6-1-2ee0c348224d@gmail.com>
References: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
In-Reply-To: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Dan Williams <djbw@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2

From: Serge Semin <fancer.lancer@gmail.com>

If a client driver gets to use the DW DMAC engine device tougher
than usual, with occasional DMA-transfers termination and restart, then
the next error can be randomly spotted in the system log:

> dma dma0chan0: BUG: XFER bit set, but channel not idle!

For instance that happens in case of the 8250 UART port driver handling
the looped back high-speed traffic (in my case > 1.5Mbaud) by means of the
DMA-engine interface.

The error happens due to the two-staged nature of the DW DMAC IRQs
handling procedure and due to the critical section break in the meantime.
In particular in case if the DMA-transfer is terminated and restarted:
1. after the IRQ-handler submitted the tasklet but before the tasklet
   started handling the DMA-descriptors in dwc_scan_descriptors();
2. after the XFER completion flag was detected in the
   dwc_scan_descriptors() method, but before the dwc_complete_all() method
   is called
the error denoted above is printed due to the overlap of the last transfer
completion and the new transfer execution stages.

Clear the channel interrupt status when stopping it, and keep the XFER
check, descriptor detachment and queued-transfer restart in one locked
section. An empty active list needs no completion processing.

When the locked XFER recheck finds no event, only update residue. A stale
tasklet snapshot may belong to a terminated transfer, and a zero residue
only means the source has been read, not that destination writes have
finished. Requiring RAW.XFER also prevents the fallback scan from freeing
a descriptor still linked on active_list.

Fixes: 69cea5a00d31 ("dmaengine/dw_dmac: Replace spin_lock* with irqsave variants and enable submission from callback")
Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Cc: stable@vger.kernel.org
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
[james: require a locked XFER event and handle an empty active list]
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 70 ++++++++++++++++++++-------------------------------
 1 file changed, 27 insertions(+), 43 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 575b7bb6af9a..2a9db9e39f5f 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -136,6 +136,12 @@ static inline void dwc_chan_disable(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	channel_clear_bit(dw, CH_EN, dwc->mask);
 	while (dma_readl(dw, CH_EN) & dwc->mask)
 		cpu_relax();
+
+	dma_writel(dw, CLEAR.XFER, dwc->mask);
+	dma_writel(dw, CLEAR.BLOCK, dwc->mask);
+	dma_writel(dw, CLEAR.SRC_TRAN, dwc->mask);
+	dma_writel(dw, CLEAR.DST_TRAN, dwc->mask);
+	dma_writel(dw, CLEAR.ERROR, dwc->mask);
 }
 
 /*----------------------------------------------------------------------*/
@@ -252,34 +258,6 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
 	dmaengine_desc_callback_invoke(&cb, NULL);
 }
 
-static void dwc_complete_all(struct dw_dma *dw, struct dw_dma_chan *dwc)
-{
-	struct dw_desc *desc, *_desc;
-	LIST_HEAD(list);
-	unsigned long flags;
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	if (dma_readl(dw, CH_EN) & dwc->mask) {
-		dev_err(dmaengine_chan_dev(&dwc->chan),
-			"BUG: XFER bit set, but channel not idle!\n");
-
-		/* Try to continue after resetting the channel... */
-		dwc_chan_disable(dw, dwc);
-	}
-
-	/*
-	 * Submit queued descriptors ASAP, i.e. before we go through
-	 * the completed ones.
-	 */
-	list_splice_init(&dwc->active_list, &list);
-	dwc_dostart_first_queued(dwc);
-
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	list_for_each_entry_safe(desc, _desc, &list, desc_node)
-		dwc_descriptor_complete(dwc, desc, true);
-}
-
 /* Returns how many bytes were already received from source */
 static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 {
@@ -297,6 +275,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	struct dw_desc *child;
 	u32 status_xfer;
 	unsigned long flags;
+	LIST_HEAD(list);
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	llp = channel_readl(dwc, LLP);
@@ -305,6 +284,10 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	if (status_xfer & dwc->mask) {
 		/* Everything we've submitted is done */
 		dma_writel(dw, CLEAR.XFER, dwc->mask);
+		if (list_empty(&dwc->active_list)) {
+			spin_unlock_irqrestore(&dwc->lock, flags);
+			return;
+		}
 
 		if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
 			struct list_head *head, *active = dwc->tx_node_active;
@@ -336,9 +319,23 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 			clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
 		}
 
+		if (dma_readl(dw, CH_EN) & dwc->mask) {
+			dev_err(dmaengine_chan_dev(&dwc->chan),
+				"BUG: XFER bit set, but channel not idle!\n");
+
+			/* Try to continue after resetting the channel... */
+			dwc_chan_disable(dw, dwc);
+		}
+
+		/* Detach the completed transfer before starting queued work. */
+		list_splice_init(&dwc->active_list, &list);
+		dwc_dostart_first_queued(dwc);
 		spin_unlock_irqrestore(&dwc->lock, flags);
 
-		dwc_complete_all(dw, dwc);
+		list_for_each_entry_safe(desc, _desc, &list, desc_node) {
+			list_del_init(&desc->desc_node);
+			dwc_descriptor_complete(dwc, desc, true);
+		}
 		return;
 	}
 
@@ -384,22 +381,9 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 			desc->residue -= child->len;
 		}
 
-		/*
-		 * No descriptors so far seem to be in progress, i.e.
-		 * this one must be done.
-		 */
-		spin_unlock_irqrestore(&dwc->lock, flags);
-		dwc_descriptor_complete(dwc, desc, true);
-		spin_lock_irqsave(&dwc->lock, flags);
 	}
 
-	dev_err(dmaengine_chan_dev(&dwc->chan),
-		"BUG: All descriptors done, but channel not idle!\n");
-
-	/* Try to continue after resetting the channel... */
-	dwc_chan_disable(dw, dwc);
-
-	dwc_dostart_first_queued(dwc);
+	/* Residue describes source reads; only RAW.XFER completes a transfer. */
 	spin_unlock_irqrestore(&dwc->lock, flags);
 }
 

-- 
2.53.0

