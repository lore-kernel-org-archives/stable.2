Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744789;
	b=bSa3upk4JbIecNFEu0HNHi6O7AawKrOzenwyq6t/Se8CBbtgf6I1vlOy3mxbgvf8w611
	 LNIWPM9PHJ4YJZCawOgsDBcAV0PILOYksbWJ6dwrO46P6YhzSeoAvG1xpYq/1E126MVoI
	 lR+Ysgvu1Y8RUDH8ntJlVUFiLsnjyNRqG8dyym5PtbbwG49ABBGOVdUi+5Ghrp9X4Kz/f
	 omT2UIJp+0aSMFTYAKqsHHjgSdKhromLDelJSsSoLwAfyb4zJrjzk8Xo7XTmko1WEbLVB
	 ZpuoC1Hpid49iu9cF8qbPLxE8KCDyg7Z3MkfapcnXsGGKkV/bZrkXQqPnIeI/eFaDXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=doROU71wMgt+NnFj8nFHCztOldCexP1j58PXMoDruN8=;
	b=L0fy7W6l9P+vnbLw2eg6Qfws0U2oswQD06EQMlfX/xkgD7gUNm78TA88CY4M5QBiZ9ZC
	 B0xD4JvN4T4SqzoXXu3u1L0EixWaxgNP1jGD+iA/uTOiZASneMKxzIHZtk4UHhGXwRvSe
	 Gz9PkQ+KI4zbEIkCwBIbZCIt1WjJxILaxauPvd6RYi8hUK67Ugq3ufeD17LMELrl1e/HU
	 LoL+TrDVa9ChsuwQOcaxAiSG2pdz3J2B0igpzaPejk1SKH2/tXlEh04U8WsMh+4JTF/7L
	 HCH7AzZgn6MojU6QfCjcHbXXV+lNPYnP2XsRr0Oiijw3o92FVcwIGGeaA2lHadI5XcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EgZBuqxw;
	arc=none smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3B7606D824
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D3B7606D824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EgZBuqxw
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-53dbe9b8d6eso928359b6e.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 14:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744787; x=1794349587; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=doROU71wMgt+NnFj8nFHCztOldCexP1j58PXMoDruN8=;
        b=EgZBuqxwhYG7RiyVUhzhcIe6NxQPwBBGxNuNr7nNVAAykBvhviDZ3r2D39qYG8eB0P
         fQAwsejyQ/Xy0SjFm9VbOlXY7oJm0K3IaeRefuDVtbiE5A8oI8tbj71lkHleDsCVOXv1
         4lWy6scE/mcn5ItDlbxZ76MjTGZojcA/5IXZQULk8vELVYYb5aRy4huauQERqj5EDd7h
         IpPv7dHybfydO33tk2FKQIN4aSKP4YhooM24USafHcORM1SY1dT+JE33JzPhzQcDL0kb
         pZabErwzxwqz0sWP7Y2kGAq1IdPGmRLOk5McEbhn4A9A9oeGkBCEyRYutqcAMDG3cebk
         wz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744787; x=1794349587;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=doROU71wMgt+NnFj8nFHCztOldCexP1j58PXMoDruN8=;
        b=L08ISYVruK1mLu/vvN4hTQMXGyEhivE9ubIKLb3D1n7ZuNwBnW8YQLojCDlZ0S/s/s
         j0OdWo3Mdcf5WGtEthAzmgNqP6AbIvdRKR7fZ5NgO6nawXPHLawq7shUtmVvdBGH6b6p
         qqw0iOZilTxKC8z2TwbV2/La8Kz916pa847Vu3Dikb6TQCBzNvyXlJg/cfD/phMW8AbV
         ++/ZvGdz7hg8FU/+3qCdivKyJnrwcNH8sNFQ1k5BDSTiaQn1/+KqgJR8wBPMateL9pAN
         NwOnpGzNI/cJQWafcLZcV6hqCkSF5vEEpUQYZyW/vjTLyFYaZOYgoqACkB0Y3u656Kdn
         ToAw==
X-Forwarded-Encrypted: i=1; AKwUvBxHCFznJCLUr/F5silJP7IvscwQoGlTyZTZVsFBu1cLD+fbmMjEkQXDNjduN6DnRai+dPQNKtw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ReltKEavQODuUF90kjf5vT1mYWSR2tlVnBaDapiEMG8JbThy9
	pyjBGvyYuFaypsf7byxjlYRIHLJ3YYHBT92SmfOccFzWYsQu8NbWmIGr
X-Gm-Gg: AYBFou1md236zrsJBF2DacPdzNfZ5PJGFlGSKKkDzgCR9JSBuD3PztuYp+8TH70LDif
	WC18BtvgimfkcvpekVtL+TFO+Qg398XoT24KSWwP7hmLZlALBACAPnSXRKjTT4geY6b8dW48MxK
	fEYd0ykOke6ZtbCPeacXJQ4lSRm6/bShKCz5SZmdbIDNh2UTHv/xIPZRoy3cw+jASu5c+3fdqxu
	Kg6moXA9IkL/aSWqJlid360a7WFmyEMl+rkgDReZTemTyyOIfjKIEPezAwaYVzEbdyeCgxEjURj
	cRH8QpBhopfwiSSilx+z3keqS5lv4ezzyhI6fNmSxUxZGllbHnVp3fHBAyijrl2pJvFHVFz0Wus
	D4Ux8VMSZX5yBnhyxWIzU4vp5G2UHOCs/rYZ6GStcdJ/a6G8z16gVaXrf4dIi/y9Bnk8IPKJXfR
	fMamzVw9Mx/R/cFjwa8ne02yuVFSwaV3yy0QExXfLiiBy+OHxBrqofCzCqQnYrs+ovuRbEm58sK
	4T6XV4iudYcFCyi++UWa8drA5RX/gQZtUF26L113RM/WjQO6DQy942HgFciSWjvkJFajs0zJCGl
	vteRS0nCGyhd6PuMsvNPfj7j/hizoNByNhBG/5yLCMXykSw1agQwLPRFRPETtQoSxAQt0r2bln+
	JehLXHezx4hwu0uLPhQnB3VRLNXHXYYml0nkQX6DKNi+Pc4n9cEj7FAGIDLDiEr7oA8467JNWmm
	U8klQWKetjJNJatuqOT9ZIDkdOZj6OHQB8Z6N/+IgKwkFxNCXPkaB2q9E5zGPovjpPuSXsMdx/
X-Received: by 2002:a05:6808:5394:b0:4c3:cab9:2ab7 with SMTP id 5614622812f47-563efb428ddmr9071266b6e.31.1793744787544;
        Tue, 03 Nov 2026 14:26:27 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef58b1sm128435b6e.3.2026.11.03.14.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:26:26 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 15:26:12 -0700
Subject: [PATCH v6 10/10] dmaengine: dw: Prevent tx-status calling DMA-desc
 callback
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
Message-Id: <20261103-submit-dw-dma-synchronize-v1-v6-10-2ee0c348224d@gmail.com>
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

The DMA transfer status getter can invoke a completion callback from
dwc_scan_descriptors(). An 8250 RX timeout queries that status while
holding the UART port lock, and its DMA callback takes the same lock:

  serial8250_handle_irq()
    uart_port_lock_irqsave(port)
    serial8250_rx_dma_flush()
      dmaengine_tx_status()
        dwc_scan_descriptors()
          dwc_descriptor_free()
            dma_rx_complete()
              uart_port_lock_irqsave(port)

Queue completed descriptors on a channel completion list under the channel
lock. Let the controller tasklet detach that list and invoke callbacks
outside the lock. Termination discards notifications still on the shared
list; the tasklet owns descriptors it has already detached, and the
synchronization hook waits for that run.

Keep handling raw completion events from tx_status(). Clients such as
catpt poll transfers without DMA_PREP_INTERRUPT and can mask the controller
interrupt externally. Polling must still advance software-emulated LLP
blocks and complete cookies without waiting for tasklet execution. Hold
the channel lock across event handling and status calculation, then
schedule the tasklet for deferred notifications.

On channel release, discard queued notifications after draining the
tasklet, before clearing the controller's in-use state.

Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Cc: stable@vger.kernel.org
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
[james: defer notifications while preserving polled completion and cleanup]
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 105 +++++++++++++++++++++++++++++---------------------
 drivers/dma/dw/regs.h |   1 +
 2 files changed, 62 insertions(+), 44 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 6f863fae7455..fad089fcaef5 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -257,6 +257,22 @@ dwc_descriptor_free(struct dw_dma_chan *dwc, struct dw_desc *desc,
 	dmaengine_desc_callback_invoke(&cb, NULL);
 }
 
+static void dwc_free_completed(struct dw_dma_chan *dwc, bool callback_required)
+{
+	struct dw_desc *desc, *_desc;
+	unsigned long flags;
+	LIST_HEAD(list);
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	list_splice_tail_init(&dwc->completed, &list);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	list_for_each_entry_safe(desc, _desc, &list, desc_node) {
+		list_del_init(&desc->desc_node);
+		dwc_descriptor_free(dwc, desc, callback_required);
+	}
+}
+
 /* Returns how many bytes were already received from source */
 static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 {
@@ -295,19 +311,17 @@ static u32 dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc, struct dw_desc
 
 static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 {
-	struct dw_desc *desc, *_desc;
+	struct dw_desc *desc;
 	struct dw_desc *child;
-	unsigned long flags;
-	LIST_HEAD(list);
 
-	spin_lock_irqsave(&dwc->lock, flags);
+	lockdep_assert_held(&dwc->lock);
 
 	if (!(dma_readl(dw, RAW.XFER) & dwc->mask))
-		goto unlock;
+		return;
 
 	dma_writel(dw, CLEAR.XFER, dwc->mask);
 	if (list_empty(&dwc->active_list))
-		goto unlock;
+		return;
 
 	desc = dwc_first_active(dwc);
 	if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
@@ -325,7 +339,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 
 			/* Submit next block, including for polled transfers. */
 			dwc_do_single_block(dwc, child);
-			goto unlock;
+			return;
 		}
 
 		clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
@@ -340,15 +354,8 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	}
 
 	dma_cookie_complete(&desc->txd);
-	list_move_tail(&desc->desc_node, &list);
+	list_move_tail(&desc->desc_node, &dwc->completed);
 	dwc_dostart_first_queued(dwc);
-unlock:
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	list_for_each_entry_safe(desc, _desc, &list, desc_node) {
-		list_del_init(&desc->desc_node);
-		dwc_descriptor_free(dwc, desc, true);
-	}
 }
 
 static inline void dwc_dump_lli(struct dw_dma_chan *dwc, struct dw_desc *desc)
@@ -365,18 +372,17 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 {
 	struct dw_desc *bad_desc;
 	struct dw_desc *child;
-	unsigned long flags;
 
-	spin_lock_irqsave(&dwc->lock, flags);
+	lockdep_assert_held(&dwc->lock);
 
 	/* Termination may have cleared the error since the tasklet sampled it. */
 	if (!(dma_readl(dw, RAW.ERROR) & dwc->mask))
-		goto unlock;
+		return;
 
 	dwc_chan_disable(dw, dwc);
 	clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
 	if (list_empty(&dwc->active_list))
-		goto unlock;
+		return;
 
 	/*
 	 * The descriptor currently at the head of the active list is
@@ -402,40 +408,41 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 
 	/* Pretend the descriptor completed successfully */
 	dma_cookie_complete(&bad_desc->txd);
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	list_add_tail(&bad_desc->desc_node, &dwc->completed);
+}
 
-	dwc_descriptor_free(dwc, bad_desc, true);
-	return;
+static void dwc_handle_channel(struct dw_dma *dw, struct dw_dma_chan *dwc)
+{
+	lockdep_assert_held(&dwc->lock);
 
-unlock:
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	if (dma_readl(dw, RAW.ERROR) & dwc->mask)
+		dwc_handle_error(dw, dwc);
+	else
+		dwc_scan_descriptors(dw, dwc);
 }
 
 static void dw_dma_tasklet(struct tasklet_struct *t)
 {
 	struct dw_dma *dw = from_tasklet(dw, t, tasklet);
 	struct dw_dma_chan *dwc;
-	u32 status_xfer;
-	u32 status_err;
+	unsigned long flags;
 	unsigned int i;
+	u32 status;
 
 	/* Channel release may have drained a polled completion before this run. */
 	if (!dw->in_use)
 		return;
 
-	status_xfer = dma_readl(dw, RAW.XFER);
-	status_err = dma_readl(dw, RAW.ERROR);
-
-	dev_vdbg(dw->dma.dev, "%s: status_err=%x\n", __func__, status_err);
+	status = dma_readl(dw, RAW.XFER) | dma_readl(dw, RAW.ERROR);
 
 	for (i = 0; i < dw->dma.chancnt; i++) {
 		dwc = &dw->chan[i];
-		if (test_bit(DW_DMA_IS_CYCLIC, &dwc->flags))
-			dev_vdbg(dw->dma.dev, "Cyclic xfer is not implemented\n");
-		else if (status_err & (1 << i))
-			dwc_handle_error(dw, dwc);
-		else if (status_xfer & (1 << i))
-			dwc_scan_descriptors(dw, dwc);
+		spin_lock_irqsave(&dwc->lock, flags);
+		/* The snapshot selects work; recheck events under the channel lock. */
+		if (status & dwc->mask)
+			dwc_handle_channel(dw, dwc);
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		dwc_free_completed(dwc, true);
 	}
 
 	/* Re-enable interrupts */
@@ -911,6 +918,7 @@ static int dwc_terminate_all(struct dma_chan *chan)
 	list_splice_init(&dwc->active_list, &list);
 	list_for_each_entry(desc, &list, desc_node)
 		dma_cookie_complete(&desc->txd);
+	list_splice_init(&dwc->completed, &list);
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -955,10 +963,9 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
 				      enum dma_status *status)
 {
 	struct dw_desc *desc;
-	unsigned long flags;
 	u32 residue;
 
-	spin_lock_irqsave(&dwc->lock, flags);
+	lockdep_assert_held(&dwc->lock);
 
 	desc = dwc_find_desc(dwc, cookie);
 	if (desc) {
@@ -978,7 +985,6 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
 		residue = 0;
 	}
 
-	spin_unlock_irqrestore(&dwc->lock, flags);
 	return residue;
 }
 
@@ -988,19 +994,26 @@ dwc_tx_status(struct dma_chan *chan,
 	      struct dma_tx_state *txstate)
 {
 	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
+	struct dw_dma		*dw = to_dw_dma(chan->device);
 	enum dma_status		ret;
+	unsigned long		flags;
 
+	spin_lock_irqsave(&dwc->lock, flags);
 	ret = dma_cookie_status(chan, cookie, txstate);
 	if (ret == DMA_COMPLETE)
-		return ret;
+		goto unlock;
 
-	dwc_scan_descriptors(to_dw_dma(chan->device), dwc);
+	/* Poll completion even when the client has masked the controller IRQ. */
+	dwc_handle_channel(dw, dwc);
+	if (!list_empty(&dwc->completed))
+		tasklet_schedule(&dw->tasklet);
 
 	ret = dma_cookie_status(chan, cookie, txstate);
-	if (ret == DMA_COMPLETE)
-		return ret;
+	if (ret != DMA_COMPLETE)
+		dma_set_residue(txstate, dwc_get_residue_and_status(dwc, cookie, &ret));
 
-	dma_set_residue(txstate, dwc_get_residue_and_status(dwc, cookie, &ret));
+unlock:
+	spin_unlock_irqrestore(&dwc->lock, flags);
 	return ret;
 }
 
@@ -1079,6 +1092,7 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	struct dw_dma		*dw = to_dw_dma(chan->device);
 	unsigned long		flags;
 
+	/* Polled completion can leave descriptors waiting for the tasklet. */
 	tasklet_disable(&dw->tasklet);
 
 	dev_dbg(dmaengine_chan_dev(chan), "%s: descs allocated=%u\n", __func__,
@@ -1089,6 +1103,8 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	BUG_ON(!list_empty(&dwc->queue));
 	BUG_ON(dma_readl(to_dw_dma(chan->device), CH_EN) & dwc->mask);
 
+	dwc_free_completed(dwc, false);
+
 	spin_lock_irqsave(&dwc->lock, flags);
 
 	/* Clear custom channel configuration */
@@ -1238,6 +1254,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 
 		INIT_LIST_HEAD(&dwc->active_list);
 		INIT_LIST_HEAD(&dwc->queue);
+		INIT_LIST_HEAD(&dwc->completed);
 
 		channel_clear_bit(dw, CH_EN, dwc->mask);
 
diff --git a/drivers/dma/dw/regs.h b/drivers/dma/dw/regs.h
index 5969d9cc8d7a..c41f18281efe 100644
--- a/drivers/dma/dw/regs.h
+++ b/drivers/dma/dw/regs.h
@@ -279,6 +279,7 @@ struct dw_dma_chan {
 	unsigned long		flags;
 	struct list_head	active_list;
 	struct list_head	queue;
+	struct list_head	completed;
 
 	unsigned int		descs_allocated;
 

-- 
2.53.0

