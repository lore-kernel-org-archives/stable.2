Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795295113;
	b=Jxs3RHSlXu3Bu6IfUvikQ3tkX4o1lbMWEvjU5aTxd9o3FlwyC5Gs5w+06JodI1UK+0l/
	 Nh15aUi7LF3zVYB1iUl7RYzsaaeJJreBHhXSxNG1iqyYPLfqvTJkND2jPF7AYSIhZyMs1
	 lPjIpEvYCT3Nf7jhYGMOCzwlUMPbD2QmwNhwjlQRCUM0JlpZsCn9SPgLNl8oszCaS7yGD
	 AsjxSLOUEpk/AGOspW987NLE9qCScljbs+mHx2AKmtFqfp3YvqdpZyJCq2CkiOuCqk8dM
	 XHYdo2xS3Zc6NDXnfYxTyxxPjZBKTD4geoMDvnuBrufEddT6R+nQQFYiGPXqJ+684ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=cwro0UOYQ0UfVNk2wuoQ24AVLO12akBtg7QGpsbV4Ik=;
	b=F9ru4N2B83Mquug4yl2BKD5ocFME4RkVYAMYpYlNUG5XAuoL8QrsrlkBVrKlJeF780SC
	 KandDMLZnkdwL/s5eKG5e4+xe87sbH+mXlyQr8xjElF435OlZi2cHV1MCNz0rQ7aexeAa
	 JVQNH2F3IBdbRHHSy4rowHZ9P5g4j76LMx7zQtnPdWGNhVpCXOjcwUf2APDfXbCBvxVPK
	 MnoNkwmhqxn+myVNqp/QTTgPXe78ym46RjgWGhB1LVvpQqToPwVnuIdsGRSsVpIysePSs
	 oJMEYRJ/5G2y+FRR1UrZFTz9f0lNblOF1KMQEq8MNL+O4n2z4+sUkC6wstLi8cLT87A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cErZGLMi;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366D4606A699
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 366D4606A699
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cErZGLMi
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6e560e00a86so1351234eaf.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795295112; x=1795899912; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cwro0UOYQ0UfVNk2wuoQ24AVLO12akBtg7QGpsbV4Ik=;
        b=cErZGLMisGKbZOe4dhg3s3t4ErpTzA3AL2Payj/DvsLmP4xMMy7hLIjdZEXDL2v5Fv
         9K5cRzorsfp/6p21Deb5ASj6xAOsQeIXQhBAEEjN2yuexp7eyWYD9+JF99EV530uq6ZR
         qD+Le5nWOY4aVJ4M7cCqz/Gs35Zn0kXW/K0So9Pard1yrrZqH+klEGghLwsj88R6rpCL
         jTTw65DbJRYwskHrx4U2ZHPrb/U6VK18iyVOUuCxeJJtGyF4UhrPYxub9hlwYoy01nIB
         PFq+DeLMAQepE+h/AkzaiJQe1KegurKjtf6CsZNLIADAbH+SvSesuto8dPhTrLI4w1tK
         StCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795295112; x=1795899912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cwro0UOYQ0UfVNk2wuoQ24AVLO12akBtg7QGpsbV4Ik=;
        b=IZCp1sn8xN6Tim/xNxbxRO3wigZogJGHvuBErweWKe30gi8IDOCFeNAYVKGIZa1lp3
         5LcPLZYD3WIyYejyEULzRZi/f0fPiSHH1CClT3hyLZgH+T0MbrJE1NuFn6BI45urldD2
         j7pvzF+3h2wZOlU8XHjiUMb4WB8u4zpuP7mRV8hgtR7NRDa669gxK//g9zQ7EeQmdizU
         jJ3OhR0Dhc/DzqCbdO5buMLfje0VWfuQbHmgi+XTHW9SO3QStMv+roR3KYEhT6qdR/mu
         4ziIgoSycj/EO4paqsr7wrc8EbRCkTj2bu6malgSPCUXcOJ6hLK2tU9l+ETsvlmtQJi8
         qYkQ==
X-Forwarded-Encrypted: i=1; AL+hErGgDsMPGly8c/i42j04IUA1TibITNc8jT7t/FK5obO7C/p8sIrShaWdyTdZ0IPMM0rdvBpUUIM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SnmreLXngzFOydSBcP1GLXTO3toV5iQzz84Zk/Ov5XrXCgHID
	6WGejxrdGSxyZQwoX7wDtRV2xsYAQiZMatDo7FXRT6OH8hFZcLVWEbBf
X-Gm-Gg: AZFdTZc6wywdBntvOjmn+WWZg8wZusLj8GoIOqcZUMTQQc84JU5NEQ9z8qVBP1UErrZ
	/ruc5HJVbG0FLi2hAYOwEUrl3425cJD5wn2kUUhIJXb+PMHs6bfWMtGoCDR93GdwMgp+y4yq1hb
	fz1iggu0aIyioqrPqrdsyM+uhUCfiMQe3GiARL/KpxLfhbZoWs15H+KH1dgQAQCOs84QcWvFra4
	CWul8PGd4Ks0ZKgTrE0Jekasl1wF3xNrbD+34sBGUIRsnbsDAMvzyUzfm26q4NkMlfQfSut6N17
	Q46GFtGRXppc3nne3Kfc/hod9fMZwXTxiekbLZqzBmRfqGDsQbCUbp+t92pP6vePNKAqmPCQnJo
	Ji9hkkeQJYWCJv+XgL4ztl+zSW5ft5KwcuW0VKB+eFW+u8fuzsXaYIVr9xUdProrFWFnQ2KZ8ZZ
	G6bYSVzuYtEC2ZjPIsDXEF2NdNbtJe33nlsS/7e5xBahsE9n+QghfxDiMRyzHbX1zv2Bue9pj9o
	QS/IXymMKtBWEj9zQIi3c0NwggzlfT1DUsuxtKbYLyGKeJOrEaIu82jkgl4xZRKpwmmaufb3gQ0
	aEEtbNh1XVt6+ug2N0brnwrp1krMNaV9+oJzN/k0t8FjUQKaKWuuKnqxp4DlYyfaxTEpAotTKIG
	ctb/M0aBjTaGPnLHR1TAHru8AHEoh0C/2eDiNql7tAVTFi4zExqaPIc29HK1yhVQkJ4ZBpv7lHy
	9/zMRO7Mq89kK03uQ/12XJNSL5GISx7c9AVWAcnTqnT8zuTBphgweo
X-Received: by 2002:a05:6820:2ad3:b0:71a:fb85:d07b with SMTP id 006d021491bc7-71b3959c733mr4998099eaf.54.1795295112153;
        Sat, 21 Nov 2026 13:05:12 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380e4a6dsm4635728eaf.13.2026.11.21.13.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:05:11 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 21 Nov 2026 14:03:21 -0700
Subject: [PATCH v12 6/7] dmaengine: dw: calculate residue in the status
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
Message-Id: <20261121-submit-dw-dma-synchronize-v1-v12-6-f51eb635209d@gmail.com>
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
index 150823544f40..302ff591cde0 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -281,41 +281,41 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
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
@@ -355,14 +355,6 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	dwc_retire_cookie(dwc, &desc->vd);
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
@@ -969,9 +961,10 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
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

