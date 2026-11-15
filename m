Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727182;
	b=zvGxrsVrCUqi4QqoZOROd/h20zbV+9CBGxd04Wv747dXnd5SEdGuv2ZIbhXEbUnFc3Za
	 76P5XnXziTRdd08DZfB/6obk2dV9+NiUKJMHfY3jVZUVO7FgTLm65LnAzjkBlya1aV4a7
	 tuz0OgZkg1S3nysmAXnxzOsmDN/8dwXQcQJFcqpcYPvsX0dxPNXWXvtKJQxvBvtDPu7gl
	 KAnXFrOF51zcYLqxfzmgMU5owFRw5cTL0lXiD1AuouDxXIkb+DcM8ZwUxgrRwl3nzv1By
	 5rsRQLZqhaFQZXF2/3XM/BIqXXFT6mfRJWKszhFeO1Slq04ABBGArnURshMhlysmC4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
	b=U6ACKH1guJtM2A7h3ZLls7QyQ/AATo0a2H7zf7lZaOViONE8UEbPsRN986PMaGTNpolM
	 l1F2uy5TChXncd1P8ZvdM7f2tNGrneFn00zZYQI1dY+wZMJGEk5UQOAdZlBH+iJtpLpaU
	 x7v960vRN3h6S1CzwGWTl/h8TZopRe3QuDpDOIeUhHDayHxvCUetKKnKYuIZm5okrULNE
	 83+7h67ZIUZ+XdNrrtSOG4EWtnfJTcOEGFYuyYIFQqg8upYNQUeyxadrQH91pumCLn7bw
	 HkKQsmws/crNphyMRhfW/6vZe0eyto7EZR93uDWABy+GWbdEugq7m6uCqEWJvJiK1vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CkUE5Xf0;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530F1606A336
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 07:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 530F1606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CkUE5Xf0
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-71ad099391dso330221eaf.3
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 23:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794727181; x=1795331981; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=CkUE5Xf0RKZPU0t7sBntWYPolbo03ZSkqenXAOOpmmSR99wEK2TSjY/osLh1drfDtS
         JVgVl2VScphUySm1r+PyBVq4np9+t+7JJKAoD3weRgwwbNAiPD4jR4ub7V77890LAXUA
         3eD6SU1y6JSzbLPtVt1LdWJmuCzsscZKmzoljjL2+KrsYAB6yo0hqIWBqEjB97XDF2Jw
         9HwzjsJE2RFVHoenXYZnpAUApnmDB9wq5rtdPuRk0R0QVioxA80E9zN/kb/ZByOHu/IH
         UxwvdlHEkVhXwetEJivs14ikbkxwDKgFMEUIf88eV2DkG6gP4KBQwLKfBgn0ubOWyAZM
         7+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794727181; x=1795331981;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=ACOH3PSfMCTisYR8YpGSw1dCU4uovTxSa+Wun0TZlzOPX9sXx+GEgDGfH64uLPUvt3
         BOeij144Q1PJri0M23R/fx28Q6tfb8kgXQA5f2b8xPLL+LltFDwsAyxxOjGYw4tVbo4N
         LYxC5OyvJPjn7daUZBF4VUVUSan49gv8UtpwVmxJXb49s4vhdpDdYzmsjYCrA9QhqXVy
         cBNsLT0YTzGrUOw6wkwqw1pgy2Hr2uuWjrXDGbz+LMfROIta3h+ernzyjW356tOEXWE6
         seGFLqF3ncw7BUjSHylhJaYexbQtaSqdqCRvX5PxzhlWxLQMjW1gTRclRj24g9DwxYKH
         oNGQ==
X-Forwarded-Encrypted: i=1; AL+hErE6sNI3T2pqEHWQ+qIAX8U6RqLfamDhjEdtaR+y+kuo65FhO8L2jTgFSYUsF+QQ2SZaVbUO4VU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HDUjE/lk05xuu4z4NGQG/XE0QOyn0uTIhgbmYo1EhOmHGr9NE
	hM6YyHEJhaU8wvUalXynqp9HsthH9ZdEZcy2CUmOWjy1aEsGy4ATwycW
X-Gm-Gg: AYBFou11sY4Brwrq9+/C0OaLkCmsXZnz7U8r8R+2PqunHG0BLZAsKYjMyoVdWFEILDG
	8okl0rqZfNw6rZhEcevhAmIZy9xQFgUK7s6sZ46uKMurDvk0sbjA6ewsWBqQ3I5JykDxpiYMlr2
	Ip2DBoGMZe1p8DAwwgLJXugeUz//mdJp9BkaImSiQkh60cTk9NEzEnJrxoUSbretz1TtRhmjZge
	R/o9QhveYgeWpQDO07cFl4yqg1zmLz5jMmIso2OuVTQ0qt4GTlqTaf+3eVpLfNFPOd2U79s1SuS
	GDdMRcGov2bSgMyMuFx/GHsAjeeUFPAbnW6F6YcuSpegBZzNEyCsU5r0tTIExlh0wnDhjzVNFRp
	NCGuJj4nsj7sDYrTB4bZiwAmgiDuHD2hWVs2srVldZz9VnqID2Q8Xyyi7SjqW0+IaorV3v975kJ
	/Etnt7+vNVSu/sbDQsjbbVYs0SSXYPNvPgzfBG1JW0DX1FDOKyBPSt/GPxl5ii0JJQsU0aAZ5Fz
	8ifTsmoWFNedMRKxzY3ZLJ7Cbu/j8xeELgp8xF21GpkZvrM955w0N12X80NQu8Ct1DcFKkDq+jz
	4p8TpVulJVzOFrXbSfxrUGaHi9MDxk5GUApuxIB9VvuPAdqhmCCG/15jH3VGND4N9iHnKxvSbD8
	6KPMejtcGfh+zeoJGKcMnSNGmWGxowY3xPG8O7svQ4/CkotfheqY0IxtxT3dRjFZDuT0dUjFnHI
	fJ7ozZQXqUHmag/AihUwVGV0TLsHVQWEEYqdnRZhI5djm/i5PMGgDCOZn+YWzKxmayvi35zzZ2
X-Received: by 2002:a05:6820:8592:20b0:716:c93d:cb39 with SMTP id 006d021491bc7-71ab5109a89mr3057192eaf.44.1794727181155;
        Sat, 14 Nov 2026 23:19:41 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ae860ebd7sm1145321eaf.8.2026.11.14.23.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:19:40 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 15 Nov 2026 00:19:34 -0700
Subject: [PATCH v7 01/10] dmaengine: dw: Fix XFER bit set, but channel not
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
Message-Id: <20261115-submit-dw-dma-synchronize-v1-v7-1-8d58f3d49e4d@gmail.com>
References: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
In-Reply-To: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
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

