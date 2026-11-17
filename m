Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955742;
	b=3fRDenc2UT4M38vDLAQNM4UdJkQZUvsmNInbkr2XWzuGMyGcvyR/dRpbInGRXsJQPPq+
	 MYiqzcK011CxZt4IWwnx0rZxKUH9CLLGf7GpkLZCv52ZkF+fCFFs+dSIdNDReK9pT+6Ow
	 XLgLQ8VhKAwA6b07W6h/sU0DniUnK+qKGM1kSoks6LcH4o/OKL+h0gYRn07Y4e2SL3k+b
	 gCECPgH3JFw7dwASdYQcpxRTr2BPwKbNrexHj7qFNXFM/kGo89sM/ZGCIuxbU6IGW890q
	 a/OVAkjmLy77j1B4mNusNqBHbGPBNWCvV9NycpMDY82L1WNfIup5N9YumeGWJNiEuVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
	b=szsi+FRv4Fd1A0YPXL/w8d0YGpS+F0fk0iM9e7y/uZ+1GqarYHf3b9fxyHNaOMWX4OmD
	 gPSd3yw0NJXJSKGtgAaj3oF6EQij/0FXtniIzEWMbhLTscI8tJPukjOcWknEpG1Cj2cvG
	 PvUdwA4Q96roHF+K8mBYIUM9HepJoAR4nBSOl+c9ODmN8Y4hYKCm6B149Vb5sOEXLzt4i
	 uIIPOUcvrXIjXjdvTkFAvPIe7yb+TVnT9/Qoz9fOxF+6/sEjVQBbrCRKBV3vO9WQrT2kP
	 VmDZ8EoHAvIXl6BfAV1X8EvRXT5KdsLxfE6RtCAk+dVLuF7Sc08lEyND62SytA2bMHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g0ruMzzK;
	arc=none smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43587606A886
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 22:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43587606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g0ruMzzK
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-490d838b425so202233fac.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 14:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794955741; x=1795560541; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=g0ruMzzKPKJB02LGombv7yLKFI97HOz4p6BY+JIZw2mpG37qXNuFOhe2Pu/IVcMllt
         BC3Uqp7Ud2cGSjeN6SSzSGpeflI4x2y0dooeK+rXXj9c80fcvzwtKvKb+bxSzzcHE6LU
         SpXFgtJnQeLt+dNI3rlOHZP1gn7gJ/KufG66UeFOe9Vl/up6aF0NS4+Cwy50aATNaMya
         PA6lrGgBqtuf50+OPs8OyzkcmOb+wVv/f83N6I4+RrCWaqWVMW65XbR/HNGT94JHQQcV
         HTRiDrjKF7v26UQNzn4eGXoI/k3AUyyffd52MiN3f+w5+ib+JMauPCN1r5AhwH9YBFHn
         C+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794955741; x=1795560541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=OuUDrx3kH2/UiXQudDYTV6LJ4S0vAJxEbpOH3cIou0kFWNtOb9qV2bJTLZrs7jSB9Q
         b4qHTk9CLu74EjHPhIx8O0RiOjZLF7YvDdD4268rBlMlw95SmGIHSfYiRRiUGYch7J3H
         tLV431ETtQ9undh1N2AaGCGWsqj5uKBqtJhuZmIko/PF9UCcohzQJSLeWrfS+jxYvOsq
         TjJleVusPBOIxPl1wOLb7i9YydvFdvhiaxEyZSpjUwy0/9QRyrU8UtW4liw4XFhllsVz
         K7D7YWcyEfJrEADrFmWZbWGM8UrA8z9odFbdf4m07WW9WzgKZw/17km+pXCXUtsi9K37
         X8Vg==
X-Forwarded-Encrypted: i=1; AL+hErHwI0CHSNZxmCAMVF0+cuVQi8ES6FnkfhpK5jvOmr64/qgkLirWBpIKhA42H/zFzZbelh+sI6g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xVVnPJ/JZMYjlgvXUgz77LXpVNMZ6MmRAd8uutFHm39Aux+WF
	ygWc+WUeKvN7uG4z+++vxkKRaKf4wtCT+BRvwFzKTZId1pdSOPnFumUD
X-Gm-Gg: AYBFou0LsBEk9mIm7bisCc/fHgRsjeNowlyPYFANTvtKb69FeWyakD/s0rFT5JdIHNj
	UkZzDJLZLpmqJr+KdIoXI7JrOg9wj5KTmUGfzpA3Gqnoa6P+7K95GTeEeRH76nMQQWkak9jlLAJ
	u3c18RGpAzlUjpEUABG5AwvZkew4u4CrQGQo2oJ9ru9ViSypscTzhlNsSqSuvaDoRzH8BUGKnPT
	rY5YAhjFV69X0nb3SnrNJJPEPpCvVy0rjYJYJEz7Ab83uNlaJJFUWEhDFKbprh0/JU/g213OWqR
	JpCVRwhdtxlOdQ6+D9d+ST4kRXWRTTIx2xA4tsTNaIWhZvOWBypg2AYouL+NCi8JVNKwe0Mx45R
	c3aCUIC4kwe8lAzw2DUw7aV2tpt9s/lPuKioopwVPdJ97b+vyja77QOECHXtaRdTuyM8jOlEjxr
	Vw8CfKWRRsjgmWEm5AiCsFX6G6k3vITT5eqS6lStpQ9TiUcholuZfnba8mSlmZVTvPezAQQGPYQ
	KvDpGmHtkw5FlhhT7K5mPx08ZA7LVTfT4ogagKFjiNZAHIWECZsY0vh8bpaPbIYzUmVdQrNJQD3
	6LsqdM9MFzS56tARweZ9mFaGU8XOJuDe1Cd2YrfqqI2a5B8/+5Azo8wYr2VzOcD7VH5VfhziedJ
	0GQuBrsGZXgeoTnI2+Wzh5lzA03Z9yT8QJf8Q8dfz0WKOMEnNvdpC0/0CvhVwd9Js/l4GlH7IMj
	PBXhWl5lfVa2E6kX2Eewjxq8mnvaB/cs0/cTaQGerV3JAJvXpNhfziNjzIDvhKL6K0Umr3ySpk
X-Received: by 2002:a05:6870:6b86:b0:4a9:5d97:bd7d with SMTP id 586e51a60fabf-4b76010e714mr459331fac.34.1794955741115;
        Tue, 17 Nov 2026 14:49:01 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b74560af5fsm583066fac.16.2026.11.17.14.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 14:49:00 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 17 Nov 2026 15:48:36 -0700
Subject: [PATCH v9 1/6] dmaengine: dw: Fix XFER bit set, but channel not
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
Message-Id: <20261117-submit-dw-dma-synchronize-v1-v9-1-7dc066ed0bcf@gmail.com>
References: <20261117-submit-dw-dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com>
In-Reply-To: <20261117-submit-dw-dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com>
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

