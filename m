Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826391;
	b=aJcNuhRu6ldFe2KkgRJqJGs7hrHRxph3fiqM6dN9XyCTZyws124fPSRjccQDwf+KokS+
	 lRUEgMQ0hqG/SUUB936DCjYvbvCUgnfHKldTLoWptUbSyrcfJZRei05hiPFyReGpdFGcC
	 w4F/TXy7FY/PJh0BK4kZ7r9B9q9OSJT9Q/m9D0CWQShXJPwN0+kAL0eZsiWHWvI+bXU3E
	 SLGzr3Bgs3q0ci61SINHilgC9HxJnAO/VOoVi+f0TJv3fh2V0WSdRsfH7Izq1pnr+MVR9
	 5+YF+8QdKla4toC8mpFUSh8PQOhpnDB2nGCq7U0s9vvNKUpzojK4CvuzjsOR52XoeEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=K0i/xrW+wVH3BjomlRH87KMdUy4LFZjH49JteTT0ats=;
	b=pNDElCWJFVbrEpTsPaGUoyMqfZg0D0eVyTCpCTRorlA9ReafmS5vb4eoTpaeW/KSrbT7
	 28LFJGmg8WsfC9Iv0RGkBiJ86GwNoTzoKgCeVz0OiW5DEh82XVnpO5upivHj9Jd3M34Xh
	 yzk3dW53Iq53vSRN/qACF8mYKnSJmiVaA2GG55WiUDi5BbpqBSGbli/PoHGHJBiEDjKXy
	 7fNm2cMf8tfH00wja9JGPbQpLVnS4UwHaJ7AfkN8EqWtiGffjAz46JuoZP0xE+CB3naN3
	 H66ohcsVctH5KWLTV056Ex8Lu1+BKjj+Ev41O7CW91DLl92VQErYPwXXQOh7mccwLdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GmUsAtvS;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B62E60A2605
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B62E60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GmUsAtvS
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-71ac9e15640so1552511eaf.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794826390; x=1795431190; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K0i/xrW+wVH3BjomlRH87KMdUy4LFZjH49JteTT0ats=;
        b=GmUsAtvSbwsdlAwC1mIYv0+NOcOmgCNdTQjqnO6xCvFfxWZvrT5ezUBenWrx+nUZ2S
         pQuvuU0uFb1KX4Y7THWkOT/O5GYufIiEykMHO+Ax5+Dh/rLaKD8XNa+5E+39NuZp9IQR
         yhPXodfJO+ukZQ6+wzD6iXDQt3/jj55apKGc88eV1j6tjf7gh+aspBXll+lbZ2lbJ+4F
         Pdp+NRat5FEHb85QMI/CSiOAEtoHrc6shQ68klDhOWQ5x2zHp/vi/0iZMtXSbec+iCb6
         RDS2XAr+oc6Crw3yiaxWfOT3S/bG1uB0f98bhoJPkLUgJUwBwapVoPPBy7m8hUPIOz+P
         FrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794826390; x=1795431190;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K0i/xrW+wVH3BjomlRH87KMdUy4LFZjH49JteTT0ats=;
        b=oqtfcB0KRoC9WW47bE1xkJ94YDVInOST6f5j7zDu5tYG0JbHiDwd94Av+zkOHLm3JH
         8mnN0yc8a2xaX11KjAJiPjl2/V3vDC8xKRJ5eWbF0ybHyT8rm5sWGYIGewNKfqyLloLA
         Qpg/rYjCWAGYD6SU2vrWoIp/FTom0pwB7mqFSlOkYqPqglI51g5Y37OFDs9qmaNioNbW
         S4wkxP857SqugyG2P/sDX51BnmV5PfnvJOWZRe5LKCSVV+YqyzS7CNp2cLu79ShmDh2J
         SesCu/9tNr3B2yDVCzYeblMPdBi6RDv3clZXbsjdBOYTvBy9rEFLQj2Pdgjqqmu2YvBN
         3RCg==
X-Forwarded-Encrypted: i=1; AL+hErE7xJtB6TWqobNf0JzJ7OPRD6Rn0hyDihPEq+CG9QY/jB6KSMICnDGv98KNYJRouYkD09v0Zq0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rKN7Yxl2ThJlQWd7f1u9DmiqlYV9SkPnztpL8CT4V3egelTyX
	OnEKnLNqCsFjXjt/CRa0UdZYnX+UMh6TJZtvi+v56BnrAQVzyS1lgyQK
X-Gm-Gg: AYBFou3Khog9xg0duGFWR41iNWQDl57IMGdVFQXEiLflNHbOujkXMzxd2ymNkHWcJIi
	l0exj8QTecB3ADynLnMC3A/mCHSbja9WDkDmMPqgttDSkrYVCcMzXL4bZv2w+l/DYbtbi3rTtir
	olZ+SOxlQk6Dw1wfqiXY8o2qWQsJ/R1Alv0SYqA8jVhPMThA6/1ufqwHIL19YMpTLMMd1nKduBP
	PuYLRhcVN0kzIWwZxwbfJ9GSPYEaZQuRV35P26t65ORMFw7I2UfEUhYTKNUZItjcVL8zeyZckmP
	9FXfg4SchnBGzO0DVHWkAFyIcTOrsg+DV/3E+038qE5jb3yx1B5sNI8IBNIyVmUCjNfPl0oN2mP
	+rNr89T5RylllMW8wtZkW3/OXzUH0DW1LdDnbQv69hxCnXsvJYbvW1Jg5h+pqJk+KxzoJ5QWtCr
	OsmAfIos3bvLMbTUlQ0eADtZt7jo7C36Dc++j0PJZi2AzAD2/r+908x/P1HvaNI8PuOPHTHooyo
	1tSvwIb519RLcjzVU5eWkE0E7W49I78/O4REZl5U8N7P4ah3hkJ7R11qlRX/bZl0KTTfE+Xfqwq
	kxOkdv8AM/o9zoVewCDVX1U5qPm4Mb41rPvAWe6Rcwv0o6fNVkslFrYfUY8HadAq1c2rozTE6Gc
	nGAzO2P3+1fVZZRku9Ss3NrO6czUwn0AvOOxo5yRi1c9gYs9X9i5PZleo5DerejPwSNl+hkBFDb
	dtbxBclGbMewciPQ0mjZKip0jA7Sshw67R3KtA2NEhUSHgkQPLEpKuN3L65IdCJMoxkiafKEp6
X-Received: by 2002:a05:6820:1f03:b0:71a:e74b:f97e with SMTP id 006d021491bc7-71ae74bfad9mr2617887eaf.23.1794826390315;
        Mon, 16 Nov 2026 02:53:10 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862b08b8b5bsm5555546a34.5.2026.11.16.02.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:53:09 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 16 Nov 2026 03:52:33 -0700
Subject: [PATCH v8 5/6] dmaengine: dw: calculate residue in the status
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
Message-Id: <20261116-submit-dw-dma-synchronize-v1-v8-5-4a82d64fcd1a@gmail.com>
References: <20261116-submit-dw-dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com>
In-Reply-To: <20261116-submit-dw-dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com>
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
 drivers/dma/dw/core.c | 49 ++++++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 504b6ddeccd4..565d01c9a29a 100644
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
@@ -892,9 +884,12 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
 	desc = dwc_find_desc(dwc, cookie);
 	if (desc) {
 		if (desc == dwc->desc) {
-			residue = desc->residue;
-			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags) && residue)
+			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
+				residue = desc->residue;
 				residue -= dwc_get_sent(dwc);
+			} else {
+				residue = dwc_get_hard_llp_desc_residue(dwc, desc);
+			}
 			if (test_bit(DW_DMA_IS_PAUSED, &dwc->flags))
 				*status = DMA_PAUSED;
 		} else {

-- 
2.53.0

