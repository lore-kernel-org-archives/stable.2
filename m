Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792772862;
	b=tpKJ6ddQv/5oTy359cq6BV+urbn63lCKD9yYnYk/WNExkhzq1S4uqxonELe+NZbMYWDU
	 hAynHSO3cZNVIe9Ku85EhPaYovgftUS91qQrcis2gmTkzF8nzrtGPWI7l3QCUuWLuZNBS
	 23sMWRCzF57SjF22Nbecoh45KKAZpbN9/rQpUE1YGqzNVTnBzjHt5GLa0Qq/FO0XzuipW
	 YjmDW7JVZRc7Lh1DY+AEd2oVwnVifqTgxa27hADLoPG3Jp8rC1LX8lEqEF/sOdrwb5OzN
	 mLxLai7IyicTQP3mcrqucOdKsxPLtdovLaT5dOIppnb+TeEK4DqTMjDEGJTpnth9pZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=SNbRYQal0JoY2G6AiIqVW3KpE51Kimmrbq+Ywbgajcg=;
	b=ShD6eZA2grG0y/L/fT+jeZXKFbXOSo0SULMAppzHknszAJ/BgbiFnuDX46NjeBVsSX80
	 Mx5UJYSLP3Sc6qYVSbf/cRUS2saScjzy+lHBlYRZoE08IGYQyTtE1h3RPgtMnUwqngxrB
	 Ljk5Umf/biofYk0H2zUFMI00oBi+0Kc0snquwWSfC6Q8B9ZNC803KkTQHzPwyfomfgyQE
	 Mgm8HwXsBzxH6eO0mvT25aN/ZcI8SZU0vrSj7EDgNj8G8dJNLxgVvCF5v8rsF0q3B/pPq
	 zWffGa3xKnr2avSJZgXRI0437lXlstleHZZ1MY4NVGjdlIhkyUPe7yxU23btlvHCyvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="YTG/tZ1U";
	arc=none smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9916606A327
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 16:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9916606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YTG/tZ1U
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-705cb6ceebaso715197eaf.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792772856; x=1793377656; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SNbRYQal0JoY2G6AiIqVW3KpE51Kimmrbq+Ywbgajcg=;
        b=YTG/tZ1UIuVPI4mQOhHlkWzp+PRj4+z6qm2pJQBVY41nTJUcDCx1fPQiPEpnVb/zFS
         3m6wbBjIdAdEouUcqRYVnmYJvvIvFh2NYqvTAH+L6o4b4KyYe0jIKqh/6R5glCxFprBU
         VKw4VHtD0Rdw/93HNIxbWN51x9R+Q2kh9K5F3qBUXhBibc5vFHkoIjQkFal+D0C2jvz3
         1ootKKZ5OQq4mHmFDun3t9po4NdcDnuuKu2OrQxG3EOj9fd7+fNpy/3I540NanUOWKaw
         EFKzEli7kJS05QGi6Mrzb5CZWeF1ycaxVQe2EZCv+dWyu7jKP7D8TrDrpPOTYFemOf19
         1K6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792772856; x=1793377656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SNbRYQal0JoY2G6AiIqVW3KpE51Kimmrbq+Ywbgajcg=;
        b=bZYXD87BgyB9b2YBodwxBbs/7A0xJ1cVhDhFWVpWED3It5s6gmI62N6QsyBRgSBSYy
         KxeklYaYeeIDi+4t5kKoL6X/7ul3/UGYs7JutBa0wjozrujmQwtpAkqge/+8ShkSWnO6
         ivx8FGIQJd0GrMy5uI+LkPhNdNdpOyTB4QVzw+H6cjzu5YGlA6a5zQmBmu5IcXu+2NL9
         AWsd6FMhLF815kDhoobrW7ceuEDdeTqP9DWsKn/1OmnmbspYGl5CH4zL/0JsXHUiC90p
         JEpDNAI01PcRz564MiodWTrQbvZVHsJ4253WCGarE+4k1KT8NY+EOiDd14kcNO15HuDx
         W5Tg==
X-Forwarded-Encrypted: i=1; AKwUvBznnKcHow657ldND8kg8UQEJaMS1u9rK5dhMCfC98TCiHH+Qc6kflBwUwhJjVJV3w7byQqZynY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqiZmHnJrfkE/tC7hmT/Gx8wYH/d//gdueTUlhA19F3p89f4kw
	F3zypobBVCR0reta7CkeCn2vGQ9qMtHIhKwByetHL51EiB7QaTCI7Z3k
X-Gm-Gg: AYBFou1j89gxyo89Da4Fydow3I/AuIMZBhLr+u3T5dOR4J/RrhIcG6ZVNlu4+75mOgO
	WyYpXh/3TSBxYOkv8Ylu94hEu6MiVMPsvLVQHgkLLmEiicC4V2668IRHpiRfY0CeX6LihupWKpG
	p+WGcvVMSOiCQbGRVkNB9/HocQobwx8xrZ9BDUp5y/pv1v47f5ztDFNoppYDV/uKp+Rvb0+XS+k
	cZAs22jPZofYEVS4Lx3j1yJ55llctk1QNrw0UiZyLkukh9E1mStauB/cTLlC1LIuKqQvZJO5Ord
	piVnI5BGixN15jHhucmA1jDMqLyGsIqfqc8RpjXG/rByZIzVPJ5T9twcbcE2jwEjEYyacktl2/Z
	xA6Fpx+8bm0StxeGVia0CaT/O8Ksx7kSCEQLgp1AWJDNkKO8G8tnStKykP7N2so/sU+9Kdvn3rr
	uUW50ZDcwUy4zsswbGY4dP/Ryr3sWitUsQbyNE4P8Eeb1eN7HljXHTjeRymhS8MxENnJmY9e953
	xInw7uBtqHTOr+CcChUQ1qoxhusyIZ8HTBMtNoMOPypt6qQyX78xtvZeJTPd6O1nnN+boi4VM/h
	zrMf5dZ7PntaHQtFoWRQES5G+sOLJuaoq69M3cTc4drIy+1B9CQCNejlkedDVox3xEtWynSfx1k
	r3LjcqWwzZPfaleeQI7Vp80gPVR8oCO7LbADz89oMAQVBmcRlO4eED1Wp06CtdTTwaXnXwYyFvp
	yZJmWH
X-Received: by 2002:a05:6820:330a:b0:6f7:2050:a2af with SMTP id 006d021491bc7-70b88a8a106mr1982127eaf.53.1792772855576;
        Fri, 23 Oct 2026 09:27:35 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70b9aed3144sm372801eaf.12.2026.10.23.09.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:27:35 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 23 Oct 2026 10:27:24 -0600
Subject: [PATCH v3 3/4] dmaengine: dw: Prevent tx-status calling DMA-desc
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
Message-Id: <20261023-submit-dw-dma-synchronize-v1-v3-3-c62bf048f5ce@gmail.com>
References: <20261023-submit-dw-dma-synchronize-v1-v3-0-c62bf048f5ce@gmail.com>
In-Reply-To: <20261023-submit-dw-dma-synchronize-v1-v3-0-c62bf048f5ce@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Maciej Sosnowski <maciej.sosnowski@intel.com>, 
 Dan Williams <djbw@kernel.org>, 
 Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
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
          dwc_descriptor_complete()
            dma_rx_complete()
              uart_port_lock_irqsave(port)

Separate cookie completion from client notification. Under the channel
lock, move completed descriptors onto a completion list and advance their
cookies before starting queued work. The controller tasklet takes ownership
of that list and invokes callbacks outside the lock. Termination discards
notifications still on the shared list; the tasklet retains ownership of
descriptors it has already detached.

Keep handling raw completion events from tx_status(). Clients such as
catpt poll transfers without DMA_PREP_INTERRUPT and can mask the controller
interrupt externally. Polling must still advance software-emulated LLP
blocks and complete cookies without waiting for tasklet execution. Schedule
the tasklet for deferred notifications and calculate residue separately
for active and queued transfers.

Serialize cookie updates with termination so a delayed callback cannot
move completed_cookie back behind a canceled transfer. On channel release,
wait for an executing tasklet and discard queued notifications before
clearing channel configuration. A pending tasklet run can then return
without accessing a controller whose last channel has been released.

Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Cc: stable@vger.kernel.org
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
[james: defer notifications while preserving polled completion and cleanup]
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---

Changelog RFC:
- Instead of just dropping the dwc_scan_descriptors() method invocation
  calculate the residue in the Tx-status getter.
---
 drivers/dma/dw/core.c | 275 ++++++++++++++++++++++++++------------------------
 drivers/dma/dw/regs.h |   1 +
 2 files changed, 142 insertions(+), 134 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 51c5460b4670..6d27af3c0f2d 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -236,18 +236,17 @@ static void dwc_dostart_first_queued(struct dw_dma_chan *dwc)
 /*----------------------------------------------------------------------*/
 
 static void
-dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
-		bool callback_required)
+dwc_descriptor_free(struct dw_dma_chan *dwc, struct dw_desc *desc,
+		    bool callback_required)
 {
 	struct dma_async_tx_descriptor	*txd = &desc->txd;
 	struct dw_desc			*child;
 	unsigned long			flags;
 	struct dmaengine_desc_callback	cb;
 
-	dev_vdbg(chan2dev(&dwc->chan), "descriptor %u complete\n", txd->cookie);
+	dev_vdbg(chan2dev(&dwc->chan), "freeing descriptor %p\n", desc);
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	dma_cookie_complete(txd);
 	if (callback_required)
 		dmaengine_desc_get_callback(txd, &cb);
 	else
@@ -263,6 +262,22 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
 	dmaengine_desc_callback_invoke(&cb, NULL);
 }
 
+static void dwc_complete(struct dw_dma_chan *dwc)
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
+		dwc_descriptor_free(dwc, desc, true);
+	}
+}
+
 /* Returns how many bytes were already received from source */
 static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 {
@@ -275,121 +290,51 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 
 static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 {
-	dma_addr_t llp;
-	struct dw_desc *desc, *_desc;
+	struct dw_desc *desc;
 	struct dw_desc *child;
-	u32 status_xfer;
-	unsigned long flags;
-	LIST_HEAD(list);
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	llp = channel_readl(dwc, LLP);
-	status_xfer = dma_readl(dw, RAW.XFER);
-
-	if (status_xfer & dwc->mask) {
-		/* Everything we've submitted is done */
-		dma_writel(dw, CLEAR.XFER, dwc->mask);
-		if (list_empty(&dwc->active_list)) {
-			spin_unlock_irqrestore(&dwc->lock, flags);
-			return;
-		}
-
-		if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
-			struct list_head *head, *active = dwc->tx_node_active;
-
-			/*
-			 * We are inside first active descriptor.
-			 * Otherwise something is really wrong.
-			 */
-			desc = dwc_first_active(dwc);
-
-			head = &desc->tx_list;
-			if (active != head) {
-				/* Update residue to reflect last sent descriptor */
-				if (active == head->next)
-					desc->residue -= desc->len;
-				else
-					desc->residue -= to_dw_desc(active->prev)->len;
-
-				child = to_dw_desc(active);
-
-				/* Submit next block */
-				dwc_do_single_block(dwc, child);
 
-				spin_unlock_irqrestore(&dwc->lock, flags);
-				return;
-			}
-
-			/* We are done here */
-			clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
-		}
-
-		if (dma_readl(dw, CH_EN) & dwc->mask) {
-			dev_err(chan2dev(&dwc->chan),
-				"BUG: XFER bit set, but channel not idle!\n");
-
-			/* Try to continue after resetting the channel... */
-			dwc_chan_disable(dw, dwc);
-		}
+	lockdep_assert_held(&dwc->lock);
 
-		/* Detach the completed transfer before starting queued work. */
-		list_splice_init(&dwc->active_list, &list);
-		dwc_dostart_first_queued(dwc);
-		spin_unlock_irqrestore(&dwc->lock, flags);
-
-		list_for_each_entry_safe(desc, _desc, &list, desc_node) {
-			list_del_init(&desc->desc_node);
-			dwc_descriptor_complete(dwc, desc, true);
-		}
+	if (!(dma_readl(dw, RAW.XFER) & dwc->mask))
 		return;
-	}
 
-	if (list_empty(&dwc->active_list)) {
-		spin_unlock_irqrestore(&dwc->lock, flags);
+	dma_writel(dw, CLEAR.XFER, dwc->mask);
+	if (list_empty(&dwc->active_list))
 		return;
-	}
 
+	desc = dwc_first_active(dwc);
 	if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
-		dev_vdbg(chan2dev(&dwc->chan), "%s: soft LLP mode\n", __func__);
-		spin_unlock_irqrestore(&dwc->lock, flags);
-		return;
-	}
+		struct list_head *head = &desc->tx_list;
+		struct list_head *active = dwc->tx_node_active;
 
-	dev_vdbg(chan2dev(&dwc->chan), "%s: llp=%pad\n", __func__, &llp);
+		if (active != head) {
+			/* Update residue to reflect last sent descriptor. */
+			if (active == head->next)
+				desc->residue -= desc->len;
+			else
+				desc->residue -= to_dw_desc(active->prev)->len;
 
-	list_for_each_entry_safe(desc, _desc, &dwc->active_list, desc_node) {
-		/* Initial residue value */
-		desc->residue = desc->total_len;
+			child = to_dw_desc(active);
 
-		/* Check first descriptors addr */
-		if (desc->txd.phys == DWC_LLP_LOC(llp)) {
-			spin_unlock_irqrestore(&dwc->lock, flags);
+			/* Submit next block, including for polled transfers. */
+			dwc_do_single_block(dwc, child);
 			return;
 		}
 
-		/* Check first descriptors llp */
-		if (lli_read(desc, llp) == llp) {
-			/* This one is currently in progress */
-			desc->residue -= dwc_get_sent(dwc);
-			spin_unlock_irqrestore(&dwc->lock, flags);
-			return;
-		}
+		clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
+	}
 
-		desc->residue -= desc->len;
-		list_for_each_entry(child, &desc->tx_list, desc_node) {
-			if (lli_read(child, llp) == llp) {
-				/* Currently in progress */
-				desc->residue -= dwc_get_sent(dwc);
-				spin_unlock_irqrestore(&dwc->lock, flags);
-				return;
-			}
-			desc->residue -= child->len;
-		}
+	if (dma_readl(dw, CH_EN) & dwc->mask) {
+		dev_err(chan2dev(&dwc->chan),
+			"BUG: XFER bit set, but channel not idle!\n");
 
+		/* Try to continue after resetting the channel... */
+		dwc_chan_disable(dw, dwc);
 	}
 
-	/* Residue describes source reads; only RAW.XFER completes a transfer. */
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	dma_cookie_complete(&desc->txd);
+	list_move_tail(&desc->desc_node, &dwc->completed);
+	dwc_dostart_first_queued(dwc);
 }
 
 static inline void dwc_dump_lli(struct dw_dma_chan *dwc, struct dw_desc *desc)
@@ -406,18 +351,17 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
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
@@ -441,37 +385,43 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	list_for_each_entry(child, &bad_desc->tx_list, desc_node)
 		dwc_dump_lli(dwc, child);
 
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
 	/* Pretend the descriptor completed successfully */
-	dwc_descriptor_complete(dwc, bad_desc, true);
-	return;
+	dma_cookie_complete(&bad_desc->txd);
+	list_add_tail(&bad_desc->desc_node, &dwc->completed);
+}
 
-unlock:
-	spin_unlock_irqrestore(&dwc->lock, flags);
+static void dwc_handle_channel(struct dw_dma *dw, struct dw_dma_chan *dwc)
+{
+	lockdep_assert_held(&dwc->lock);
+
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
 
-	status_xfer = dma_readl(dw, RAW.XFER);
-	status_err = dma_readl(dw, RAW.ERROR);
+	/* Channel release may have drained a polled completion before this run. */
+	if (!dw->in_use)
+		return;
 
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
+		dwc_complete(dwc);
 	}
 
 	/* Re-enable interrupts */
@@ -945,12 +895,17 @@ static int dwc_terminate_all(struct dma_chan *chan)
 	/* active_list entries will end up before queued entries */
 	list_splice_init(&dwc->queue, &list);
 	list_splice_init(&dwc->active_list, &list);
+	list_for_each_entry(desc, &list, desc_node)
+		dma_cookie_complete(&desc->txd);
+	list_splice_init(&dwc->completed, &list);
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	/* Flush all pending and queued descriptors */
-	list_for_each_entry_safe(desc, _desc, &list, desc_node)
-		dwc_descriptor_complete(dwc, desc, false);
+	list_for_each_entry_safe(desc, _desc, &list, desc_node) {
+		list_del_init(&desc->desc_node);
+		dwc_descriptor_free(dwc, desc, false);
+	}
 
 	return 0;
 }
@@ -963,24 +918,56 @@ static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
 		if (desc->txd.cookie == c)
 			return desc;
 
+	list_for_each_entry(desc, &dwc->queue, desc_node)
+		if (desc->txd.cookie == c)
+			return desc;
+
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
 	struct dw_desc *desc;
-	unsigned long flags;
 	u32 residue;
 
-	spin_lock_irqsave(&dwc->lock, flags);
+	lockdep_assert_held(&dwc->lock);
 
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
@@ -990,7 +977,6 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
 		residue = 0;
 	}
 
-	spin_unlock_irqrestore(&dwc->lock, flags);
 	return residue;
 }
 
@@ -1000,19 +986,26 @@ dwc_tx_status(struct dma_chan *chan,
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
 
@@ -1089,7 +1082,12 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 {
 	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
 	struct dw_dma		*dw = to_dw_dma(chan->device);
+	struct dw_desc		*desc, *_desc;
 	unsigned long		flags;
+	LIST_HEAD(list);
+
+	/* Polled completion can leave descriptors waiting for the tasklet. */
+	tasklet_disable(&dw->tasklet);
 
 	dev_dbg(chan2dev(chan), "%s: descs allocated=%u\n", __func__,
 			dwc->descs_allocated);
@@ -1100,6 +1098,7 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	BUG_ON(dma_readl(to_dw_dma(chan->device), CH_EN) & dwc->mask);
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	list_splice_init(&dwc->completed, &list);
 
 	/* Clear custom channel configuration */
 	memset(&dwc->dws, 0, sizeof(struct dw_dma_slave));
@@ -1111,11 +1110,18 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	list_for_each_entry_safe(desc, _desc, &list, desc_node) {
+		list_del_init(&desc->desc_node);
+		dwc_descriptor_free(dwc, desc, false);
+	}
+
 	/* Disable controller in case it was a last user */
 	dw->in_use &= ~dwc->mask;
 	if (!dw->in_use)
 		do_dw_dma_off(dw);
 
+	tasklet_enable(&dw->tasklet);
+
 	dev_vdbg(chan2dev(chan), "%s: done\n", __func__);
 }
 
@@ -1246,6 +1252,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 
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

