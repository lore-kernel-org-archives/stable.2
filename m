Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202965;
	b=jrXfxi6JUjR2Dd+a+VZEM/bCEHlJTI6Be9vQThj3DNRjENXQdETJD8Smb7OygnQZhydn
	 O2KLI1aeMCtAOP1zZZBB7/+6PNdciyw869IXdGhnWYCUrz8c+mQuTqmglqgjM5BEPu1rc
	 V3qaIdXbumJW/QnIvrZ2MDLAagHyBMNCX2lzmyjmq/u7U0NMv3oYSBrHiB+a91psVz92+
	 +qoObkhMRErCVTRrx9ZoFPTZGDqA5A4t6+xsgLVVklWcvLH7nesRZTfu1M7bCStT4yGGM
	 0yPGsqPGuitVHwloeC2XOtxuXtJ0Hm6XkY9Y1Yw2v888z1hvy7RcWWIrxHRT2ajRFhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
	b=dbL1t0zUvZXan0S/djWpJuYJM2LyYytrjTWbtrP1C6i6yZusJklMB/vqZI/2+o9Lwgbd
	 BLxDduYJEr0Rv1g2PsPhyrVubGWlssGWAZmoeiWWkSsSiPgQ253XyXqOa7DRMhpaE5Gwc
	 ag5dJpC2wnxu1Uitrs4wSr6CyQQZLfv3VncQRQTllAbCMyARPuisrtagFkcVEFzV6+aTN
	 9Qu4vSz8i5FoLJrbTorbktsA/F0kMeT9zSXqJ8TloQ5w3qJs/yr1xtTnvsLqW08C2kEzV
	 wAgeObDe6gmw8qX7brVgV+rUdSZZqc+IDuvdTw19RnyBy+qoXeXtwh0W5aDsoJNpjzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yxBc0xzO;
	arc=none smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1B5606A6D3
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 19:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB1B5606A6D3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yxBc0xzO
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-490d838b425so678239fac.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202959; x=1795807759; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=yxBc0xzOKmBIWEOBHLRK1tFyhtnnv5644LBOx9SMQWs6sgRS1N+vCo/XDahyFK9BXU
         /bLmFKQqTod+l4OjVGI88MQdPn68K4IbGyMTNytT1zDjjy5HYrGwQjjrgJUu2b6c/jfF
         t1gDrHd2obm8vQdl5RwncEKNQsw/uivdqhVT+cja1L3C9SaNfTTphJFclG4eFWNLpuYF
         CiG88XvqHTRFJVYbrgJacV0VPkE6ObpZnXngLafy6HWUmFVB/mCq/L4V5BBcGN0YROyy
         gApPGjVuhYhnv6QkYNbduMyAhO1E8KwunQxlKT1zjwdK/uSkoJXPkIMK9YruN/RZldiB
         KsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202959; x=1795807759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=jtIsnwyxZTyI6hsoK9zeJ3uevtE17T14pb2BDHBG9b+s693BqTGqL3P4coMeQPKTr2
         Cq6p4kt5XzQupYnZNb7H+OUus5rxfHH5BdYsOKK4OCSm/Je9tlZmSboaeGKTnROP2k78
         IIWLadj7ysk31ig//5qrZRbxFhcRWAYPgXvAWWmYAAykLAnCUFemG3qtoXWlBzhm+8e+
         Ycud4WS+ypLSmOdDBu7IPQIfAaqVe+0yV/Ej4w7ezyZmhJ42P43Bn/bS4PSVJVJRPldk
         AH3lBfRvpPz+meZojJSWNE+w4HWaTQVzz4C71s44swUmG5FROnq17LL7YJSPqBXigAii
         Jf+Q==
X-Forwarded-Encrypted: i=1; AL+hErHWgAWFZh1OHGu6JkRn3Z8BQllisUAsqYzkDxgOwC+UZ2cEogs1R+rbm00UzidcSXDcG71URWs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pRuNROsHBB+XVifp1w/R5/zVMeDO2ZnL9L29KNE/S4uwjFS3K
	Am6NFEl4drbORNWH9T1UjTuHkEb5cCIxHS0gfx9UyQI8M5CN3aw4dtk5
X-Gm-Gg: AYBFou1NQ17bzWtqhODQkKu5PaoxfZhFoZ6/8ifqZwoZwJor5+WygckrppePEh9pdUq
	IoYrqlNK4KL2XI3h7YPo5zHgy4340pFYqz9QLKgKkSkOuwcObWO5LK2RIL/k6ak5XUUwfpWYXYt
	iAmdKpz4Hw3SNpIYt5Pyv/gXG18nFGICBud3khV2Eml6gsBNwHPFVcrL3J3bmblP0McFVpWxp4g
	3nMXhxUy2VrxCfHVQOH753vkJjH9McIxySCP4Phfd5bykmH65GAWEKqKx3WCzw0pq6in7K5gRUJ
	YkHrrrRttAuHrovvgE55IwcYQhdmvMCYeKlmKuLLariiqnR2sjG+WVI3YZl5oDNkgWxQazJkkCw
	srWY7ehcuZLi81H32y4CA3cdWPfoWYr5/Y5vnvqbSti7bQYWACPSVGpkPuWaCnD4SaHvQear6hE
	Cq2ftj4UhfwbxADHHzCgZonVG5AH6LktQ4ZSpw/PQuSEn6VuRVrKj9lwGV5pmYDOMaTU22FPsCE
	KpcopcT5wMTuzPC97TdKnjEiLgEVTdYPiPIeru9/HBhUwcEOHRf3OOW3d2a4FJ58dzz1YkwyYC8
	hONHmcimujWfrhKUBsMs5qTKQTJmljfVTRr78bFqwbYBWKMT+YlphXMt6Ae4jGaw4gqTXqohypM
	R2xKhPGnHgaRyryzFAjX7GzIOohwUHEOy6HIwuiHA9zKHR3/1c9/nLcuMHSfNe120QiJiFl/YwX
	sfGsItdunrypo97T8h++044YOzCF2Kmwsm63wq2HTrIpPzj4Q2OOAr
X-Received: by 2002:a05:6870:e0c9:b0:4bb:3128:ada6 with SMTP id 586e51a60fabf-4bc803ddd0emr3956657fac.9.1795202958656;
        Fri, 20 Nov 2026 11:29:18 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5f7ae7dcsm3434498fac.8.2026.11.20.11.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:29:18 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 12:29:07 -0700
Subject: [PATCH v11 1/7] dmaengine: dw: Fix XFER bit set, but channel not
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
Message-Id: <20261120-submit-dw-dma-synchronize-v1-v11-1-9b9166bc2cc7@gmail.com>
References: <20261120-submit-dw-dma-synchronize-v1-v11-0-9b9166bc2cc7@gmail.com>
In-Reply-To: <20261120-submit-dw-dma-synchronize-v1-v11-0-9b9166bc2cc7@gmail.com>
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

