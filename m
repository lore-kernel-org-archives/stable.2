Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795295106;
	b=mPoSikXqmh0CdSdmF1LgKYKV+gP8Ctz65BpT2toGXmEtl132IdouJLsH3SOI6ARWyjPq
	 HA+6AzE2llLSx6NDnzXqCPs6H5tI+BhhGkD2z45Q9/rDEDfcricuTdsDTK19yWEy3TKaB
	 5XY1/TTBMlsLc0KB0YWzyavoCFjU22NAhlZpGd1GrC8PQXcsN7tjm8hPlawmNhJiFbWyc
	 4NS/HaNKR6a7PC4vxc/ZO2h8TA+z+R0w845KhDrdaEKbL2K7RyvFUsRH55e30F/oGA41m
	 ovrk2ALX2bHTH6p1HmMoO0RtyIdPaSu7wfiGl50mb/d5mSDdUSftZnk3sIG4Jot+5dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
	b=oJ1HrUEVWh+DTZdvUBkuKs6b665+h9Nt5NUAf9B2Hk7AFH5Oim+MrCBlzmZ4mckzjkRv
	 LSisKtGyVAR1tcTmV+cSTes2nl4GrkfT0bYJsqXIy3yXaRCLFqIIBWUX3439T7m83rH02
	 Pt3yjRe1xGf06Cva4/zf3jDePJU0LSWu+NHDAnHR2IbjtiopWpgnYA5fRvRJ1WfWRtO/R
	 CvAp7p3MUlcVC0tk2REYDP8fW58NG9CSwk3gH257jIeouoNizu18j3XtpYV199P4Df6sU
	 oXcNA799DgXtBF4ZaN48cyOsMQo6/lyg0ifi8d4EymEqjiP3clzXT9JXCZ3BSweifTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W66gkJu0;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B463606A331
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B463606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W66gkJu0
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6ddef424972so1719309eaf.3
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795295105; x=1795899905; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=W66gkJu0d6mQpLuxKctMUJD71u4yIzfy2caUI62PP823Ntvzn4sVFquiObAUYkq8gy
         9qyDNCfXpuqmwHdxN7hobXWg63PYyHYlxRHzlRJkdhWxfOWZuLKDN4L7PkL4HKr91pEr
         SVTmG8P2td0d6ev4OXR73UulKBdKcDv+t1w3kBzxEQQpWLe+YrRDfq0duVfSD8sEnZZ1
         /4HYc6IGVK2Xo607UIQrPsbwgaID2TvXbV/CQYq9h287oLZQn3Mbq0mGjqPPBPRIgMp4
         AHiVT7ZUAsGOf5ZQ+TzSbsctiQ5ffEfoHfmkfD8aUYAiCU6yhHPqQZ9RHNG8CNX+fIBz
         GZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795295105; x=1795899905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=x5mipGXWtEhteRbXvQ9x2J2ZXVjrxFRCor0xjhSZ1u/xMLdv27ziMTYPGaCShgBT4F
         M3Vr4BLe/zAZ3Wi/w51Y4J1ZARsb0vYoT1Uf3FWp8k/OJ+Ob0W0FUuSdS2Faf7LVQhIe
         UMOsnIiz8CuQS0KszhQ8DpLGut8SbIb3ySacDpFRW5cT/zZzd0P9jErevrCDDw/RExOE
         DLQUS7Ahki1M4HwcRLkkd/vGeS+2S4ea9ufI+ehGCk4c2bqT5yQWqjy5dNOCSob4QVeY
         LWfG0mHAFh47ySsTaCQj6bLLJkpzwQdaTrATcVv/cZGSHvJv7ep0DqrhANxu9TNL0rob
         P+eQ==
X-Forwarded-Encrypted: i=1; AL+hErGliyMMen0rQDQs6dh629TdTXxetKcYW2j/6y4xg5ldEtq1xN/DMy3k8bQJ54G+rV7dNN//r2w=@vger.kernel.org
X-Gm-Message-State: APuU4Z+EKkUK3TMsbL7HRuyc1AqBgRp3Z8SoXbxE/Mx1LT8q/GDLoqxa
	o3RoTdZ9o/1M0lLu7nFTo9/6TA9zhJpmGvAFaQppmRSBrKqDRJl3AkBR
X-Gm-Gg: AZFdTZcnJxqavWai2hORU5Y9BVc0Z5xwaSBVuGnHiJlQ+A3Q0Oa7rwecYKtrBioOSEg
	XG/DF2K6nQdxk5SXDYluFKZVbBoT5IRcQ8cqNkWa8MJJc/PyVVwVsms88s3WQ0R5f+1TbgAE6Ls
	nO2DUcQP+9yO04KfjnIVHdI7oHGUtuYn+mBrVjPtUCSPkZUKcMbFfDDUeOQY3xHoQIUY2dVmbfx
	fNGUrGLb1ureo4xcuRjRWVtRdL0ozrrS6mnczdFYO6dx7xdafQG1XsDXDZuI2/l0+ko4sGxv+Cj
	wnzq7Q4YMUtcz/GAdBQYXqTatfmqxYBzG2uZQUc7/DbZ29xFMr6OkV7a50+hNtbR9XfyHHVffq6
	rP/Sc+lBdFd39vK1xVKGk47MwMwHmXetNL+4NGtPhsgoLTATIH4w566tGVqW7Y+0c4yTPUbFv4P
	n+qHV4X5Lt1LlfzXGJEJ9RIb8LCIGGDHqd+8S6nu04WGBQbSwhT/6XbcsKd0tChGrgK7K/K6cOJ
	u3lz6gk+2w3SHP0VXf1pCT/SLTqDsNgRVUXOc5+fgAy7qmDCbWflSFMHwcAYz7S3YZ5EsaaI84I
	5n2+k4uXQt+RIOidDv7ur6Ew6dzsjEW9NJ5QJkAoInjN7ojrzd+E8ctUYtm5ko54+dRqssPnxCt
	bIXyXIyd1Q//4477QO//JxNn4iQHWaOpfwsx/QWClmYp5MnM9bGuFAJ58oh0knCLP2QgRRlEaRM
	h6PF5fuSRDlUPih6uOvrp4tizm/uRgRovpHw2C/EmNFLj1KYD3uLZr
X-Received: by 2002:a05:6820:a501:10b0:71a:e6e4:553d with SMTP id 006d021491bc7-71b39563ba6mr4471138eaf.69.1795295105432;
        Sat, 21 Nov 2026 13:05:05 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380e4a6dsm4635728eaf.13.2026.11.21.13.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:05:04 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 21 Nov 2026 14:03:16 -0700
Subject: [PATCH v12 1/7] dmaengine: dw: Fix XFER bit set, but channel not
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
Message-Id: <20261121-submit-dw-dma-synchronize-v1-v12-1-f51eb635209d@gmail.com>
References: <20261121-submit-dw-dma-synchronize-v1-v12-0-f51eb635209d@gmail.com>
In-Reply-To: <20261121-submit-dw-dma-synchronize-v1-v12-0-f51eb635209d@gmail.com>
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
X-Mailer: b4 0.17-dev

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

