Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955750;
	b=Vcry6u9fKTBdmuK/sBFWyD2d6pwO3YsCdcwUIS6hX5do++jarf5hBF2P+45f//ogYnd0
	 kuNv+/sMdMgH7jvSzMVQCtxuWu4UayHDMQfCzcWY9LaVNyA3S5G1Qnd1vS2iPPLTSySnd
	 pe1IoKXicP8LcHGBYMTFRP0Sjsw4OlQOH6ccMERb+gLgmOkGRU4OZow3z/gX34Dd/7ZHj
	 wbtHI5yFLevEVP2w/UyEBmv7Nf1is5S+HyMznz36UCWyME4UC9bONY5DlA0v16BAHBTRD
	 W5ZHrdS1mkLPzLdo4uVdxuHzZ8/+qC+6bASesC2d2e8nkzT/kvZLrNBdspUs2WvBPmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955750;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=zxc17WVo0gYUnTOtZw1pyN8QC3Vommte57dKv0ZbhgA=;
	b=aJ7m4RLHbptY2tA+HA9anJ5urAEbVOiszglalT1avVGAoEB5MZ5j/KRiSQXnqF0OtKlC
	 37dlQDWd3yzqHDxC3Ck6K2QSNVSekT1silca7MTKgOhekCbUi9FgJUbTd5o4BsBXJupOT
	 2+m9oxCKUcP9+hNZ59yoGj1IHR/Id5hw3fYB8wPJO3+xpKah8KiZaVBZQwz2hmdSMJnj1
	 eklyRLosS55JhxTXhPMGKc2Zx56ghD5ZeWExI1f4JRf16/YvUG0OMo/RVo9PiKSAJat7B
	 UaZFxxk4f7w9vFRAgMwSFoLw1JCGxRqoHO+5wMMAU6NGP3ZQiseHO3ygxz6BR6mArpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="tCok0Ar/";
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FE460A2616
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 22:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0FE460A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tCok0Ar/
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-71ad5f20016so312608eaf.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 14:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794955749; x=1795560549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zxc17WVo0gYUnTOtZw1pyN8QC3Vommte57dKv0ZbhgA=;
        b=tCok0Ar/JeKM2kOPQ/6MQ9xT0UiZ5MgjXtMfKNPMMawSO2jl/jdaEBKRcchyPk435x
         w/JMWw7I+PxT6Py8cy0uhMaBI4xe4/Bk2su3tZC0a7h3Q8foasppdZOrLkq2UsA6qgbk
         W8a62ol9q6gSVmHxcYWEA1Mvsw0HRNibTJmrGg65+4jcvImB8I13iCDmAt8atape8/LQ
         YmnQh/1JzJvL9yrGA9kPAr+Lau5zz4dsclfevCazeZCYq1yG+qSVBWgsWjqKmY3M7L99
         //P4Km2IoaF6Be37pzEfNhKG3iTm94aGpxX7ecqQFPpS+sydvmYeMkpgjCey/g+4EvnS
         0P5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794955749; x=1795560549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zxc17WVo0gYUnTOtZw1pyN8QC3Vommte57dKv0ZbhgA=;
        b=kT3sd0ZqRhwc+ZwqivHRku11bfwNWRTZqxtjYjfxB80vgyX3hBQpcnNycs1fxt6N0E
         r7NdGjw+Tiv8PbFJRsxe/iMcWNakolDiw1yDePQWIdvPI5Lp+H0GA+tVbxy+7PJyGmiy
         WmeD16AzJu1ahxlVmzHgYLJaDPcC4PQD8ZB9nMMAP4a0RouPizB1WxY9AayJZjd+hip4
         9iY1AVIiGSVS+F831WZNKHohO2SYK1VkOoBEWaCq9XBhJHjDyhgc1f0xqrl+vfuPQ/ie
         O4PY6fPI5NQgqW+JsGZD7uaeMKeZfPX/Uyim/8PqIIot98M7aPuu6Y+FgzCzHyKEBi1W
         EmBA==
X-Forwarded-Encrypted: i=1; AL+hErFLz+ORfcmHv1omDOjX09S8vtyRGJgu6K8rvu+llUT0myISS2e0qZ0ZhjtBILhiC4mqNnzfLCQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NTbqBvgEsJfLow95A0Xri9V8jY+CCGsVomWEYU1JV+sD8F+hC
	NeGwJYkbT6vHDiV46u6Otolhq1YOEF/4LdQEL59s5ALe8vFPdY7U2aCr
X-Gm-Gg: AYBFou1apygHjgOiZfATtyhZCSZjJteTivwWeLpz10w3R5iGgnP/xSP6W2V+LTQGDF3
	Nw36P+3zIudeiQfIYdxw+/+Rv46wItc/WTAsWbW/ZwKDVwop1QeCDYhX3GAI7TuBLar8q/Izsve
	pnTGpqfhn5VY1gnS14V8uPXBU7+CrQ+Df6rmiS2SDX26O8a5G2dvGR2e3YGvSPhcTbBsWOxDxpR
	JwlM/puqnCGUbvD/PgKInXEPXFKzZg6zg8o7xj8GqpOAdlJ9hpkkcwU89AyyzkB+JHRbw/evCKQ
	S7TizdZFdl3re57JFdbkiBkAjRtajtKUj5gt8+AQYTicacqwhhRzVk/aK1jYrDkgLMA9YCsc7FR
	OtGSkOlKSxi/mYka0Pcn8ciivSyZno4KpdB0l6Gdlrp9JlQHUkEMyJR/+gt7u8IW2tOo/28OUI8
	pO9Fi7Be4jvCOfdNefMZaB2yjGafEIC4eBJ/w5q5UJrF2vFaXTaTSnSUqFFsOb8SVBiLt27/I2j
	5DcirSQwFloN0lH/UovAAV0NaMuRsbNo6hCyPtothEi790r8u2/QDl9eBPbRzK4kd1A9tqpDeY5
	XvzG4hMLOaXbWImRxq7bUjAcioLT5LmCNCA2ATa96J1qhsDTFoJtc4se6yyxf9UhMBu9W2U9zQ4
	NVm2ecXzNCgR3h04wacQHxdEhjTPG222xDTJBtgS8vbYv42TTAHwBrTP5bfDwBiv25HUVfmIR+4
	Bva1uVWIgNr1YyaUWZ5CGbWatKpjlBuTOnKFp9ZDxkaGobpPRNux4=
X-Received: by 2002:a05:6808:c133:b0:568:3866:d1c8 with SMTP id 5614622812f47-5774122a39emr1396230b6e.42.1794955748915;
        Tue, 17 Nov 2026 14:49:08 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b74560af5fsm583066fac.16.2026.11.17.14.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 14:49:07 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 17 Nov 2026 15:48:40 -0700
Subject: [PATCH v9 5/6] dmaengine: dw: calculate residue in the status
 getter
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
Message-Id: <20261117-submit-dw-dma-synchronize-v1-v9-5-7dc066ed0bcf@gmail.com>
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
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev

From: Serge Semin <fancer.lancer@gmail.com>

Calculate hardware-LLP residue while looking up the requested cookie under
the channel lock. The descriptor scanner updates cached residue only when
no transfer-complete event is pending. If a status query completes the
current transaction and starts the next one, that new transaction's cached
residue has not been initialized and a query for its cookie reports zero.

Have dwc_get_hard_llp_desc_residue() return a local residue value from a
fresh LLP snapshot. Keep the persistent residue field for software-LLP
block accounting, subtracting the current block's progress when reporting
status. The descriptor scanner continues to advance software-LLP blocks
and complete cookies from RAW.XFER, including for polled transfers.

Fixes: 4702d5244ca9 ("dw_dmac: return proper residue value")
Cc: stable@vger.kernel.org
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
[james: retain polled completion and software-LLP progress]
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 49 +++++++++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 504b6ddeccd4..c138008d7cb0 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -214,41 +214,41 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 	return dw->block2bytes(dwc, ctlhi, ctllo >> 4 & 7);
 }
 
-static void dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc,
-					  struct dw_desc *desc, dma_addr_t llp)
+static u32 dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc, struct dw_desc *desc)
 {
+	u32 residue = desc->total_len;
 	struct dw_desc *child;
+	dma_addr_t llp;
+
+	llp = channel_readl(dwc, LLP);
 
-	desc->residue = desc->total_len;
+	/* The first descriptor may still be waiting to be fetched. */
 	if (desc->vd.tx.phys == DWC_LLP_LOC(llp))
-		return;
+		return residue;
 
-	if (lli_read(desc, llp) == llp) {
-		desc->residue -= dwc_get_sent(dwc);
-		return;
-	}
+	if (lli_read(desc, llp) == llp)
+		return residue - dwc_get_sent(dwc);
 
-	desc->residue -= desc->len;
+	residue -= desc->len;
 	list_for_each_entry(child, &desc->tx_list, vd.node) {
-		if (lli_read(child, llp) == llp) {
-			desc->residue -= dwc_get_sent(dwc);
-			return;
-		}
-		desc->residue -= child->len;
+		if (lli_read(child, llp) == llp)
+			return residue - dwc_get_sent(dwc);
+
+		residue -= child->len;
 	}
+
+	return residue;
 }
 
 static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 {
 	struct dw_desc *desc;
 	struct dw_desc *child;
-	dma_addr_t llp;
 
 	lockdep_assert_held(&dwc->vc.lock);
 
-	llp = channel_readl(dwc, LLP);
 	if (!(dma_readl(dw, RAW.XFER) & dwc->mask))
-		goto residue;
+		return;
 
 	dma_writel(dw, CLEAR.XFER, dwc->mask);
 	if (!dwc->desc)
@@ -287,14 +287,6 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	dwc->desc = NULL;
 	vchan_cookie_complete(&desc->vd);
 	dwc_dostart_first_queued(dwc);
-	return;
-
-residue:
-	desc = dwc->desc;
-	if (!desc || test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags))
-		return;
-
-	dwc_get_hard_llp_desc_residue(dwc, desc, llp);
 }
 
 static inline void dwc_dump_lli(struct dw_dma_chan *dwc, struct dw_desc *desc)
@@ -892,9 +884,10 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
 	desc = dwc_find_desc(dwc, cookie);
 	if (desc) {
 		if (desc == dwc->desc) {
-			residue = desc->residue;
-			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags) && residue)
-				residue -= dwc_get_sent(dwc);
+			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags))
+				residue = desc->residue - dwc_get_sent(dwc);
+			else
+				residue = dwc_get_hard_llp_desc_residue(dwc, desc);
 			if (test_bit(DW_DMA_IS_PAUSED, &dwc->flags))
 				*status = DMA_PAUSED;
 		} else {

-- 
2.53.0

