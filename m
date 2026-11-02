Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648065;
	b=JRhOZ7SzNzNMd7bmHjTJZOS6cBaNBEa3Q8yPs8X3fXly18DJzVPgDgOpEU9GchZ1WmfA
	 T+EIRrYCM/Lv+T7WkcBLGE9fdjZzF/brdM7X+0ySg/tEtM/5ETpYMB4Cm+Xw7jP9dSw1o
	 Mlo5GWK3Vqt+9qAN308YRG8YiIvl5nbLy0nIQ/MWvELS3egORSC2OkjmvCZNNcwmLcbun
	 y4GpoVjZ2aBNPUH/ugumaLfQXFo6t0zU5rmZNpMoHtn64Pn7wqi6QSwNx7AzVIDpVDR7G
	 FeX6prXGkkWz+IBmb6h1OAkFFId6Eb9WmFMwCzeYvnHyl1+/Ng+WKuVW8FEVW3RKPAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=agNDJFmBlWFHJhILToH5SF3NXKWRpvo2zlMNjhJMbMs=;
	b=OiyFfhaksp538Uod03cXHIQwxGnMXlk09tod+O9pekdAS+eUt++Fc/WlOU3RT0rFsZ0F
	 zyCcOKDBKS4/EWUEYhR4AjTvYrpQ+h8xsdVD4Etmb5WOYGXpt/+DsBxn+tcKQvJsQJzy0
	 4BdOkTZkJkHrcq6eAM5wB5cPmWkiz+6hFaHKlbLnxArc9mNWBCn9jeRAeZoQUED4LO9Mv
	 bcY8Qb9zobw69jEo6/bpcntEyDsNhOBr/b2XJ1F6Rn0x7XqkYnVKnliKLkZ8lncU4R88o
	 K1NO8VZvtkaHwnT8A1FfpuL4xzPJhHWjVc9ckZNlkv3cWuwI3YRAH+X8gIFhW07tkFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BqaUjlDM;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493EF606D83D
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 19:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 493EF606D83D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BqaUjlDM
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-845788309b4so1570270a34.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 11:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648064; x=1794252864; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=agNDJFmBlWFHJhILToH5SF3NXKWRpvo2zlMNjhJMbMs=;
        b=BqaUjlDM6OViKO6/VVgcXKROePzaH7UZZ2A3iXotgq8gkMk1Xs657geU2m42LDYKKj
         jYznvZqRbRs8KfvMvOXIuaxIvgnrySAB9TDWSmvM8aMPtXlloxmG6ERM+QDAIQe8RSkl
         Vm7W99mYxaGWYYDMI8WyVC0qHFjlcLYZerXC2fTYbeU8tPqQ9FUQiIfMVt9mpysUs7pI
         PfK+kiMvx2r0sZ7eaORG1pxgCAc6FtGzkvwb0aouCae+htjhne7rl7lOLIlzxsc22QW/
         JC8o1az6hps29R4PERGirQ+eXVCpUWHiV4ljPBQ4U1amGF2qJYzbz5Vk+J3oBj2Rz7GB
         xhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648064; x=1794252864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=agNDJFmBlWFHJhILToH5SF3NXKWRpvo2zlMNjhJMbMs=;
        b=rc4p1LngMcQZCG+SwzHm6rot3/m8ffcWXC56WR5oiMgVu0HThbk2ilu26PrwNdFYLp
         QgffkTKbxQnVuDMN3KCgF+SfIPxAF1eTOquZxIXJpqMw+2RfdcW6ULJlhV87qb0X0FbB
         UOAmfvb+/nCoXDMzpGfZH9SySujFt5wLFmdkqve3vl6HZg40v1OtEHbrMPHdPfw5YaoI
         dbEjkzBdcmlXKvLlo2Pr0kMf2O+2LvsQzPYd24yXiDHPv7J2A6Pb6+nLJdblqbaMrEqO
         uPSaTx0bgcHvPIdb4e+1JW9Cauu8Bn+qk5LtfTMEeoMVCKjasedGcpCPBB1Z268LUIcf
         pccA==
X-Forwarded-Encrypted: i=1; AKwUvBwGMHspcgLCoi36CyOE9ObkwIJ76l1t8eZHST4NVGTBHy1fpfCcP2AwikQNpw+g8AhY33BTddk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGewky2j60lunCHO2/rW627XKARqq5wUZFfBoNH2WASpO+XBHW
	NDSVxcRR66hCe7hrqC6HR4R2RXsXAKRPsLz0zaKlviwti5ccyTuXXxxihmCOTA==
X-Gm-Gg: AYBFou13PGMxw3otdpv4FFY3OoIsS0yo0CB8CPEPRhy27AHSwkaGMNglFVyVwiYqlCM
	gC6aDlYeeXvQJUJrLRJk7Gmex6peNwPQHb4gj6XcoG6h+sPyEuGE7ONy1V5SNjni4rGvtmfDH42
	jP/gzoBzJY9xbfc9gN4gJglj6iaP2ZA/XRdnzqwpQKdKwc3i9F6hz8AqytkkeO80lzaK+7R8qNh
	CEYf9mWqy5y8z6U4DpXkG6vQ3/aV8217mlH2hyJ/cI32PRhkx87fxuO0gSZdYaG1Gi19ci6Jvdw
	7TgewItHG8SUKh6gSVVoXqaco7Q7BH43RBwTgUw4b7A7ksenjPXE/A6xW28ZY0gbhfqItYTSZTU
	SnCcMFMHsnxwp9cEHBrvtTHmjQYaILtj7SUBNtkpQMQE+TJuVtaQ+TNAdnPNXj4dwmvO9QIMMd6
	gSIvNhTBYBDD75o7k6jnWYIWYBw9+PJpgP3JPhZj0gd4XdQOfjzXFwJOzQlI0tYmt1qhLtfzcKw
	a7xD64VjOR5b8IINmRRr/zAngkDCqmKCoYmHhW3ACAC8/uXV2UKCZ7rjzIvdL36hulyT8Mv+7Nw
	j6aTOwxnmL+i2Jas8okK2vwRzWoc2YyEkAduMeRb7InT/r7puwM5lkEM1Rj940gwxABviQ/ZuyT
	ZIC8r+1FQTVeSOL6FNKNjMqpirlQZgkcFzzGu21Cnsb5lA6BSxJIJcP53P1b5CJkYpDha4Xktt8
	Qf9rE7F9R0T+VTb26LiicVTFN9PD0Y00kM63xkQz3xfM558JYLIYcgAmGASmu1ohWzsvNxTlsk
X-Received: by 2002:a05:6808:3206:b0:522:1ac7:a573 with SMTP id 5614622812f47-5640dddbb38mr7810512b6e.43.1793648064189;
        Mon, 02 Nov 2026 11:34:24 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd93451sm8558249b6e.3.2026.11.02.11.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:34:23 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 12:34:17 -0700
Subject: [PATCH v5 05/10] dmaengine: dw: calculate residue in the status
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
Message-Id: <20261102-submit-dw-dma-synchronize-v1-v5-5-d3207758fbf9@gmail.com>
References: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
In-Reply-To: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
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

Changelog RFC:
- Instead of just dropping the dwc_scan_descriptors() method invocation
  calculate the residue in the Tx-status getter.
---
 drivers/dma/dw/core.c | 88 ++++++++++++++++++---------------------------------
 1 file changed, 31 insertions(+), 57 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 5a1caca7ad68..0d6b5bd8ea6b 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -267,41 +267,8 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 	return dw->block2bytes(dwc, ctlhi, ctllo >> 4 & 7);
 }
 
-static bool dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc,
-				       struct dw_desc *desc, dma_addr_t llp)
-{
-	struct dw_desc *child;
-
-	/* Initial residue value */
-	desc->residue = desc->total_len;
-
-	/* Check first descriptors addr */
-	if (desc->txd.phys == DWC_LLP_LOC(llp))
-		return true;
-
-	/* Check first descriptors llp */
-	if (lli_read(desc, llp) == llp) {
-		/* This one is currently in progress */
-		desc->residue -= dwc_get_sent(dwc);
-		return true;
-	}
-
-	desc->residue -= desc->len;
-	list_for_each_entry(child, &desc->tx_list, desc_node) {
-		if (lli_read(child, llp) == llp) {
-			/* Currently in progress */
-			desc->residue -= dwc_get_sent(dwc);
-			return true;
-		}
-		desc->residue -= child->len;
-	}
-
-	return false;
-}
-
 static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 {
-	dma_addr_t llp;
 	struct dw_desc *desc, *_desc;
 	struct dw_desc *child;
 	u32 status_xfer;
@@ -309,7 +276,6 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	LIST_HEAD(list);
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	llp = channel_readl(dwc, LLP);
 	status_xfer = dma_readl(dw, RAW.XFER);
 
 	if (status_xfer & dwc->mask) {
@@ -372,27 +338,6 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
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
 
@@ -975,6 +920,32 @@ static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
 	return NULL;
 }
 
+static u32 dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc, struct dw_desc *desc)
+{
+	u32 residue = desc->total_len;
+	struct dw_desc *child;
+	dma_addr_t llp;
+
+	llp = channel_readl(dwc, LLP);
+
+	/* The first descriptor may still be waiting to be fetched. */
+	if (desc->txd.phys == DWC_LLP_LOC(llp))
+		return residue;
+
+	if (lli_read(desc, llp) == llp)
+		return residue - dwc_get_sent(dwc);
+
+	residue -= desc->len;
+	list_for_each_entry(child, &desc->tx_list, desc_node) {
+		if (lli_read(child, llp) == llp)
+			return residue - dwc_get_sent(dwc);
+
+		residue -= child->len;
+	}
+
+	return residue;
+}
+
 static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cookie,
 				      enum dma_status *status)
 {
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

