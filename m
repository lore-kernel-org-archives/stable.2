Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744783;
	b=dB5GaYkqutPQtRk3K3bsBcCCpXSIvxnXkLGMKjaWDQahm5ckcYpuLuJQcRLV9je7Hf5w
	 jBgzcOI571VSKZKe9a1NbdXlGiDyzNBwnSo8ashnQsAP3c2kNxqba3fB60Hx60QyVFEDd
	 8fv3+eWxd6ig+6TieSYZl9kc1OmvfNWJYIzIPkQm3wa4XYeEEhzvaX0xKfdtrdFEB4L9i
	 c1RTKxdfdVfmqWfiLZ+X4NymzN9alFKZHQxTHntj7sKIYQNWpMdMKowdwpAV+qUabmlUh
	 DiuUqdjDa/DmD5KqYEi3NM8O85HP2cxC8PBwBTkAy0VLdc3ZyB9KGrvRZR9/fKJQP8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=NThV1TPzbyl8VwtDNaRPOEfbfjp++pfmcEFzeBnkmuo=;
	b=F2nO0fAV+zul9/xQbXLDoY6R9+85bwKqh99KEmpPGgJdScBvmPUDFtYPf92aKx0vQyWW
	 UNmPsqVsM1DUxS733KUnrnzfvK40uBc6cfxbwjHMykIfjmadPVhVjOq52LfN+gWUYTbaC
	 aA6/mttznogOym5Pp4ZtW3FRRp/nwtKmeDX23KKwtve3Lb3viNVeGlJd63DtGebekyesQ
	 z+MsZzscRWbfV713SGsdaQv5Dsi/Ik+RUv0slcShCmYfMAvYBGVCO0YVV0P3qjXhQIYpw
	 YYh+hcETE8cnxGEB0rXwKFGIVXwKoxXACR5Gz/sT3rxDJsjn08XQOIwnVNl/ZgbRA8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RcCVoY1+;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E9B606A33B
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8E9B606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RcCVoY1+
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-854b6e2e41fso51072a34.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 14:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744782; x=1794349582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NThV1TPzbyl8VwtDNaRPOEfbfjp++pfmcEFzeBnkmuo=;
        b=RcCVoY1+op2uWII/J+lWXIqcTV1rWYFPEaGfvOByppSNijrTg2ZeUVrs/MhEeUTjge
         Ikcx/UPolZjb1zOlDimmdn8z8JoyGOD3VF7wd5Vjzr6GU8ebSarflkdbxGkzADBbxLFZ
         2JUKonW8qNbdrVIAJKCV1vj47aAhF6IdIN8KOzNiZgzrIypFVQ9Ag/watlaG7mRySRHd
         Mw50j84JZEEVtLlcGFl2hgU4P8xvqEGLfuk2DgkX0HV0HQDeyYoG5CMRj5t/rIueplE9
         en93CG8vue+3E/hQzAN3sh8XKu4qlSMRdz1jD/yF8QK6JYG/Bku4Q2YcFn6KWNtxxdQN
         LlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744782; x=1794349582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NThV1TPzbyl8VwtDNaRPOEfbfjp++pfmcEFzeBnkmuo=;
        b=oT0YsQHVmQaZmNQs4vkx4RLVwiJZuEmRq4s9Qj+MZfXti0+OoP59TnkvNCrG4wiZYk
         JB/iFiBfDYkAn88GeVQ0A30+5Iu2G34C9Vq3Js8y3MQO0QLaM/gRVjiqZzZUDiayR+97
         iTgw95GnPwL4Hjj56qRZd01ZXDaJlZXF3i4pnpxjmSQg7qXeo+fTCSV2a2TtGRQuYUCq
         5LXya6c1uedB01MesndWVtTHUFTIi2ombBeKomFZmpGe5zgAPOi5EYn1IVeLvnme8Y0J
         fyRyAEkc4sUdt1hHdVBJJ8UysTmRlPhDAIKrwsji3fpnHu2ycSWp3rji3J19bhZsoOP+
         cz8A==
X-Forwarded-Encrypted: i=1; AKwUvBz/+mSiLcwK9m3agTB4ldGIw063Z9wbfK9u8C/0qKktERm1Y22yhPvJY9FkRLMf8Z/qqOUBLY8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9CEMczZnjGBMxjKT9HAn3owXYgSgW6f/byacf7chIb1zfazX5C
	AhhTCCJhxNbG2XoDsq0hFNvF+QWj+8/ZDmicqY6DX8A7Qco6xIzpYuDA
X-Gm-Gg: AYBFou2mmHKPNmjnkqHxw9sFym9EVXHOs3GkhMuedLtPbNhzUsNivmgcKOKwvR9Wfaj
	cFOiQfxMkwNHfezJQ8BdjfHcB0ChaZMCJ9L5TqSgW3DpBRphLmXAs+gm9FNWCdXqMibsSBCuBZY
	AbuXqiZKqq+tWpT5lka4wxtTmBY8YNm9gndiiUYMuFOQtvOGVM34wH7z8eWtQGqE6Dhu/gOs+P7
	AZOlwyImACgfO6EXRliCvGYHzDFi/kFix6Yu+LFChZAAVDRdd11wbMo+0NnBiimJhU1bHA1xGDp
	IFJfJgsaylX/VXP6Xl4cskF7sYdtFRyenYCIgc65uKzvN3Vl8L5VvGLmMROKlkuZNJGezJK6Uaj
	0crY1UcAusOcIhjfND/puoYzm1zFBkRBav9XJUrXcsiD0Opnau1DbbLAEdWUVA/SEjGxbB3tKwX
	TouOp6irOue0yjULvS6TR/MpL4yibgb+s7IVpH/GtLIK1Y6Qxgc9eIJJx7Bwl0L9czsS2jSE5hD
	gQhnn61GplO/M1JRdXbsxAGSric4yN1A1FA2EglzuiPTnVWMlhw5BpD51h/BNKSYAKp0GGkvXoA
	FRgCFEykUl62Ge6CVZLRUdBRBPbMUtN2t5vPVcBdoF9A9GiAYSX/et2jJXcLxZaUebRpSrbnLOV
	qysxer+NeajXc4bmwq22HcBHcgayifpWER/tsLu5qeaS3U8fU2tKHXk1B+6PN+44HA8CvnhU6ii
	zkRUwP6Gpg2mCvn4jDEQlacuL8NturwB3pvPozWyNQ5FPd5qK2uO8=
X-Received: by 2002:a05:6808:1494:b0:503:8f9d:f11a with SMTP id 5614622812f47-5640dd9c1demr9657792b6e.29.1793744781799;
        Tue, 03 Nov 2026 14:26:21 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef58b1sm128435b6e.3.2026.11.03.14.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:26:21 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 15:26:07 -0700
Subject: [PATCH v6 05/10] dmaengine: dw: calculate residue in the status
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
Message-Id: <20261103-submit-dw-dma-synchronize-v1-v6-5-2ee0c348224d@gmail.com>
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
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

From: Serge Semin <fancer.lancer@gmail.com>

Calculate hardware-LLP residue while looking up the requested cookie under
the channel lock. The scanner and the status getter currently take that
lock separately, allowing a descriptor to start between the scanner's
residue update and the status query.

Have dwc_get_hard_llp_desc_residue() return a local residue value from a
fresh LLP snapshot. Keep the persistent residue field for software-LLP
block accounting, subtracting the current block's progress when reporting
status. The descriptor scanner continues to advance software-LLP blocks
and complete cookies from RAW.XFER, including for polled transfers.

Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Cc: stable@vger.kernel.org
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
[james: retain polled completion and software-LLP progress]
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 64 +++++++++++++++------------------------------------
 1 file changed, 19 insertions(+), 45 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 5a1caca7ad68..d9127337c849 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -267,41 +267,34 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 	return dw->block2bytes(dwc, ctlhi, ctllo >> 4 & 7);
 }
 
-static bool dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc,
-				       struct dw_desc *desc, dma_addr_t llp)
+static u32 dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc, struct dw_desc *desc)
 {
+	u32 residue = desc->total_len;
 	struct dw_desc *child;
+	dma_addr_t llp;
 
-	/* Initial residue value */
-	desc->residue = desc->total_len;
+	llp = channel_readl(dwc, LLP);
 
-	/* Check first descriptors addr */
+	/* The first descriptor may still be waiting to be fetched. */
 	if (desc->txd.phys == DWC_LLP_LOC(llp))
-		return true;
+		return residue;
 
-	/* Check first descriptors llp */
-	if (lli_read(desc, llp) == llp) {
-		/* This one is currently in progress */
-		desc->residue -= dwc_get_sent(dwc);
-		return true;
-	}
+	if (lli_read(desc, llp) == llp)
+		return residue - dwc_get_sent(dwc);
 
-	desc->residue -= desc->len;
+	residue -= desc->len;
 	list_for_each_entry(child, &desc->tx_list, desc_node) {
-		if (lli_read(child, llp) == llp) {
-			/* Currently in progress */
-			desc->residue -= dwc_get_sent(dwc);
-			return true;
-		}
-		desc->residue -= child->len;
+		if (lli_read(child, llp) == llp)
+			return residue - dwc_get_sent(dwc);
+
+		residue -= child->len;
 	}
 
-	return false;
+	return residue;
 }
 
 static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 {
-	dma_addr_t llp;
 	struct dw_desc *desc, *_desc;
 	struct dw_desc *child;
 	u32 status_xfer;
@@ -309,7 +302,6 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	LIST_HEAD(list);
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	llp = channel_readl(dwc, LLP);
 	status_xfer = dma_readl(dw, RAW.XFER);
 
 	if (status_xfer & dwc->mask) {
@@ -372,27 +364,6 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 		return;
 	}
 
-	if (list_empty(&dwc->active_list)) {
-		spin_unlock_irqrestore(&dwc->lock, flags);
-		return;
-	}
-
-	if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
-		dev_vdbg(dmaengine_chan_dev(&dwc->chan), "%s: soft LLP mode\n", __func__);
-		spin_unlock_irqrestore(&dwc->lock, flags);
-		return;
-	}
-
-	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "%s: llp=%pad\n", __func__, &llp);
-
-	list_for_each_entry_safe(desc, _desc, &dwc->active_list, desc_node) {
-		if (dwc_get_hard_llp_desc_residue(dwc, desc, llp)) {
-			spin_unlock_irqrestore(&dwc->lock, flags);
-			return;
-		}
-	}
-
-	/* Residue describes source reads; only RAW.XFER completes a transfer. */
 	spin_unlock_irqrestore(&dwc->lock, flags);
 }
 
@@ -987,9 +958,12 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
 	desc = dwc_find_desc(dwc, cookie);
 	if (desc) {
 		if (desc == dwc_first_active(dwc)) {
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

