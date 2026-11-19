Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082556;
	b=pIgWHlJbQeGwJ8HsfQpcmSR0Z2i965H5AwNBiFbOO7KKmVnIHufnL56uRtwYydSoXee0
	 zJLcSX9gIZfHO6bvYzfvM4X/gBU2+U4LhWttszOB+6P9qVgyfGuez/Hb38RGfR8CyfWEQ
	 W0BiGm2X5aUqzoO36SyrqlmrV7WTcl0ysFfmOerrGChNb4H71CXRyrTBpoIu7Qluomi7n
	 hjzeg5xAEwGVVu7vUYiZOfGquetWRh/8LuInw27AQyUMqv69DQs38/lf47oB3beJ0/Kdf
	 I4jmZkLCHmwzRxV9gaAVgLSRpiUrVPskS6qAq8xw6Ezxmix0VjGOmM8seCZo6Q7estg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=6MNqx8SelieMagco0tCtX+Et6uyqf4e8xNdGXpW/e7g=;
	b=hej44Ki4MSF9Kl0icQU/mCN6KzonJuTdb6U9NQhVJwVLQQdUjpzPlO8jWfX08Y+ScJMo
	 cbjtBYlxWs6MMEJi6G4mBP7u3avGwB32zrUx62sYL9gf9VEvUrL9dah6LWEH/KcgbGfBm
	 givnTVFnHE4f3ryVFtZ94iqhzY0+ZMjrC2s/9k9yaXmXlYZxJvzr49Gc1ZYCARJkvuMLx
	 kb7OHL44EsAPoEP3lAH304jYFH0yu436UekjI1giVTcIN6DVSU87ZfkpACv1x08B+fbId
	 ziOiFhWdWGleTf35nlvRPhYECpUWALXusqMe/+yP7n9cXTIjYTsKmuQRolNSRhRNCzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UqKCasXB;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DA760A262F
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 10:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77DA760A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UqKCasXB
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-703be215729so990368eaf.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 02:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795082554; x=1795687354; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6MNqx8SelieMagco0tCtX+Et6uyqf4e8xNdGXpW/e7g=;
        b=UqKCasXBDO0hLpycOtrLJqwUIDTf/hQ6qud9KSXX4mQviejJB9wmD+uX3qhmUW8hPS
         8vjLJEKhzphDLngcZOvczQ2rG0Elta2BtCDAVMiL1Zkovx+K5kkTBj7ksSJiEV2TRDgj
         eCq+v6N/8VRgxfUqGxeAzZBjcXOp1tpmNE0RteZpSsZThgOBrMsA56T+CSUJDMiHTySt
         PIdBQn+dhkAujUG/2xTDFxHShwyiR63D7Y1S/G8GvO7lXm9XZ2Jfs10Ky5r8nBRxYCaF
         hSkDCKK81qqsPmi8UsD0W0ACucUo4c/sm20nkaMMRjyIjXIjUGvn6jLAvwD7LfqN1jDc
         ow5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795082554; x=1795687354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6MNqx8SelieMagco0tCtX+Et6uyqf4e8xNdGXpW/e7g=;
        b=R9FuM1LCpc/N+q170/TLPJq346kTRCMTodU7R2/7V42JwdzhHNBPh80z5kRVBl8qFB
         i3OJ239ZdnfJly0wxxE+ypM+/3kdq8c4SHM8zH1+tFInhzOX732Ua0zc4W6OOlXY8z8O
         /i+2wXi3ioy7PuW/nSP16NPymGlAFjVmRBdsloXtSEItpNqbBSrcHoQjn2i0luyM0Nmk
         7HvcVEwXMR3efw8NkQ52QI1ePUcBcFoGXH/1DnZBQPQlivgM2Wer76g5PyriLG7eIS8+
         wkAYOM4bO0p30HBMJ3ckgIgA1VeSNUsExJR3hiiUexNywzjPsjP3igcXr8yzxAucsBWH
         MHag==
X-Forwarded-Encrypted: i=1; AL+hErHhIDvxqS12xUXQjNgCtuNAVJXFc1Es9dhj7TSZ6K/2AN9HrvuZRXe4n5M8yE4UHk14C4Z+yGs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/YtUY7irEvibtYTLIVu+9Z2i/PqzenFLRCUilTyqUfShqZzrs
	l+jq82ENWBkXNjXToMCj/PdTzEKBJeAZ8B+13M90Q1ofjwqtfB5QCBOx
X-Gm-Gg: AYBFou228a6VpkfSgfbtt4fSSvo5qyB3GJCnJKHmQx38PjdaiDkd51JCRUYg/oNpIol
	2wDWo1/TbSBo16mBG2+fhLXtptQbSoqm2EwsFcyTsseU72fIsgHMxvofdBoLODw4jnVtW0Rh9Fs
	iRFp+sDPHruXh1lMX3XJTI4xMm7ZydEjInGceGOdaCHNjzsOygEq5Dy/4xBaZwpmB/ebj13ey+Q
	uY04piv57dnw5kgvTKNXDnhMDzCxOiLMkKQJT8Qjlbd2yOHA+k7Ici4k3DuBVIoz+eKn6v3gqHy
	lFP/f1ZHDRMPjlVjDi8dwrIi7Phk8kmX+F6i1lBMk23Hsun7PemKycZoUxspqnjTQzGP+c75jB8
	c7MhgQYqpiP3h2Mk0phDTeGopMTH/N5ljdVgxo2KfaCLDbdAP6QVvh8H7bpbZ6yBHEp9NJyba0m
	UdsoVGm1UUEUlFauJKIyZUO3kYNCvq7kDQUEMg4pF39ylEsLty3uP61OpXvb+cBe509xBnKgRFg
	4HClInEcBqQfalNvV0zJId5UFybtwQfmxv4BTIm4843FfI0GXeKKOR9femy6Bfmw8on0PbbsDbW
	aNRtIFPnAVCXlHJhopqED6Uw6HbrU5aeOJkJM+AXHHhx6etNsGH7wp+dTz8xNzS69oglwp8iaWK
	Euhq7jxO75htGSc7GVCKD/uvvPi0o9DGJ8jmJpmqTh5egg8C38rj15D7N43q6mlkrgStq/x2ju4
	b7KNxQaiG2c/OHJHmCYKRSgd3Sf9vMC1NxP7mTL1gx57WVGXyROQfr
X-Received: by 2002:a05:6820:16a1:b0:71b:1c49:5f22 with SMTP id 006d021491bc7-71b1c496c08mr3044704eaf.42.1795082554397;
        Thu, 19 Nov 2026 02:02:34 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b18fbb9a8sm3906194eaf.0.2026.11.19.02.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 02:02:33 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 19 Nov 2026 03:01:40 -0700
Subject: [PATCH v10 6/7] dmaengine: dw: calculate residue in the status
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
Message-Id: <20261119-submit-dw-dma-synchronize-v1-v10-6-3a737597a0d1@gmail.com>
References: <20261119-submit-dw-dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com>
In-Reply-To: <20261119-submit-dw-dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com>
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
index b556a39a24a9..7a66dc75c546 100644
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
@@ -967,9 +959,10 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
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

