Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727188;
	b=dym34TKJciYjgLfb5xE0NGKMudIp8Tbdo9iDXZAmhgTM1aXjScFNDWZmQa5gkNc28nAO
	 PAK+cAAfpJuoaJ2UH4G+mI+Zr5Iof32seXlPDjAIPeBOxWKJGU+jyNvWNuie/8fcyfILN
	 dX84M6Ngkwml+MPhLH/SP+8p7ZPStzyWC+PjyVS7T+uc3T+OrqQ/4v99j55yMuPDRf7OW
	 mAaDphmeNlGpJ+wR3a1vH683XYj+anl8hnV7pFicunVk2wepbpkbZnof2qA+AI4XzpHJC
	 uM6nBCVYlOvmya/JanYLSOuJmmzMBjFpeUwcgedX3wYkaP89GyUOz07nHrp8owmrNhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=dTZw+th+8Oe1DXeAcCeWuqBX9XGzYLMqzgYNqTgZsHI=;
	b=dQav0993uNTxVpUXOkJ0WRd0Y3AaO6t6lRVIzPE0PVo4sLGH1SDNpkQbvaLUJ5aI904S
	 Cwjfnsx9hR8TkPZAVRyIzD2UXYw0ePbyGPUF7/G2QAvWD314kLrN58VLY6VXgRfL7p9+u
	 8y+fIY4wg7rmW3+I3HS7I4Bj8yoRcS3dIw8y5ejQdLegqhUn5C+y7axzFQxtsW9DycQvi
	 niceOCdAtJZQSlRNBFqdHb9PdQU+14K0KpM6UGwNi9dd+FZJsZG54DnZZGTZm88pxx6iH
	 ZPe91EqnxyBH61BcYlXVLzD3F4K8ZQRV1j3uhPKY92RqZXlDiEodm9HcyjI4pDxi5Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ck/EJRgd";
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F67606A8BF
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 07:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9F67606A8BF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ck/EJRgd
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-71acdd32a53so412037eaf.3
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 23:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794727187; x=1795331987; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dTZw+th+8Oe1DXeAcCeWuqBX9XGzYLMqzgYNqTgZsHI=;
        b=ck/EJRgdKqGC7cXPITkzdHjaQLHvhByrX3uVCO7/7RrT7F8xvaxJYD868XZ5kzYi0R
         08JM4XEK3L6R2MHR4KsC1onDpWWIvEZ3/NWe/HdOTt/zDeIj1SiVLWY6MXYy+lGHWEL9
         C1Im4dZ0EDQ+SzQRHRUe1Yq44tks9mBZRPawFZOB0oL7PgfwxuGyHFyE0014fHiCpgoj
         DFeUj2I4dmwxjaDLgqgcI8ud1Hh37xNgdKtzUzHvsXLeUkI5TGYt/4TPCVi+aRgep75U
         DrQJRsIwwt3H56Cm9edMcuQUGtL11d3OUoROlJTctxKyeqiUtDSy2JV2Ox612UvYj5R8
         lntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794727187; x=1795331987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dTZw+th+8Oe1DXeAcCeWuqBX9XGzYLMqzgYNqTgZsHI=;
        b=dM+JCyEKB8fXdWFw76BodMJJbPbP4eq+1b1QGNueRXV7WlypZyUAkwGoGIQ7pnb1ci
         88wiiMLCK7Mbrh/rau6tOpfauGyTIcr4ncBgiODSY7bKPx8alV3ag4IGuLoGnoR8fONz
         WK6F1ajsx1I+OztwmhAhqX2gPjiuyGO+zbKqzcJNUcv0fB5q/j67Fxpu9yBOhFsT7ivX
         fVWUJzzVUjzPLEJjjDkU0KpvjEANT2Wxa5V+3VIGry0ZnirhtnoJClRmGX3EFAVDWGFB
         a3ni8speRJ0Z4wdrBOAosezfk8GdX8ejk/1dUr6MlsZJu7RkSdweuU8ht2MGey4tBinQ
         8kVA==
X-Forwarded-Encrypted: i=1; AL+hErFGy1ASAHYxJ6Xb9BcWs72xViKTM6T33SgHCtKxOSjOA08npi36XcQhNIl13VGrucoapeqba6Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nyjbD8b5NzM9aHjRNU+K6XHLaeh2TiEaCmryBfYjz3RM3NIGt
	35sSzh5VVeDvrGytBjpIrYTn5GymHjTFrCfgp6V16puCX5VzpIyiE3mkFUeGnw==
X-Gm-Gg: AYBFou1qEEgznhtxz+ebQE6kap4RrH1bReBxGi4J+sXckv9XxVIe1GSKa8YvXHQEojJ
	WpAQvV+oo0RuFeRnAGbn17JkHnQG0XYMp+5lF08wtITGdK4m/SIu+L3aRm01vhY/q3s5os8dLRi
	QWEsY3O3wB7+41AFgpUE1XbtTnrD7nyysrcIUytypzVW/zM9u3TgL12DP4JkDnOQY9ODS/iMrzV
	rHdbLSDUvXOcu8c3Qu7AgvgNp1dj0UIsZ45DNamNAJ9AH5WDnk2Qi4ZU4QH+6YdKpjo8KpEJndE
	qtish8+NPNKeQoBuEIbzdwV4dewYeQlnjXghYQ1tpJGP7XDmPXIdNuNqR5E6jVLYuRB7us+QbOk
	l2qCN3RdLlKzGZo2jTzeahoRa0kxZ8XhCmhEh4yubamuTTraNCMKi+pmQED1rDWgsdcJJe+eIxn
	kbMQBz1cKdOj20fCF4BBzCsVYidnPPAVuYvFJ1Q5WeeUpyJxczTrG/wQBpH5XTB/31cfBdn/Eg0
	vTqajt2vc8SuGtLpawuqHZwF2RDoFe25UscSBk6Sx2HNDR9BT1iU+p2lRAZdSKvFz9cS/lrcvGe
	RMZfm1lNfrfb7H9aD9kQhc8PXNOPMBKcKmUD7NkLPNMM2+YItsc9jhpOUs1HoyFvulayuNYD4E5
	e6cuybk+Mc95iBTLetgVoqC8MkWB1Aqd2TFG4fBm50g16cvD1tz8PPKcU7ZMeB00Q+bUtUXJgyg
	01Iv4QMyABEdqt/mRaRBHnKauJ+j6SdxgT/Py0+k7QYGuX124tShI=
X-Received: by 2002:a05:6820:a29c:10b0:700:371e:ee02 with SMTP id 006d021491bc7-71ab50bdde3mr3199222eaf.53.1794727186924;
        Sat, 14 Nov 2026 23:19:46 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ae860ebd7sm1145321eaf.8.2026.11.14.23.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:19:46 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 15 Nov 2026 00:19:38 -0700
Subject: [PATCH v7 05/10] dmaengine: dw: calculate residue in the status
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
Message-Id: <20261115-submit-dw-dma-synchronize-v1-v7-5-8d58f3d49e4d@gmail.com>
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
 James Hilliard <james.hilliard1@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 stable@vger.kernel.org
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

Reviewed-by: Frank Li <Frank.Li@nxp.com>
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

