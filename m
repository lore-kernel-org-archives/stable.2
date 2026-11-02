Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648071;
	b=Anlef7vNLGFxA7o2jQpJh5UbjZikmcsQKEwPc/UmRUKc9s93Dwj8rmZYznTnBrOMPSI4
	 9nS3xrVV3PoqkydPRXXNXyL1CnCr9FKpbmO8tgtggS2ce3qCWzUa6BDdN/8bSi+1zDgiv
	 3CFYcICDrCP9kyJ+GwfH1fNzRGRFkAuMSTGrJbe2O5GlsllHv+zSoE319e+ZTBg1vGSqz
	 j43dqQ2fQI9HWg9JqB5ZkZX/vQmERHKYezLGQSrYxNesWnTEiHPahaRvrcGIq/zjBomPJ
	 Bfhf2k+ZLorgGlpCm6uNVOl1eyv/R6Fy+ucLDDAJwJgNBJXl8QUe0LuNrQ/wSdpuJFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Yl96wqQilLpc7/Ibk/0ynCVIs5nkBAFIykihtuvWKqM=;
	b=4YsM7LPh6LRxefW7qENKNgdI4Ayj3WCb/x+y0IrOoDnxrtWQExktPlWg4wt6YCRi5GH8
	 YRNyQCDCdqQr1gv6OT9zIvHdRWutZln5Bp8ReSIGTFuNUL5UIIgKDgRa7J9nyS9MUwfBY
	 SB33Fg9ZMNjhCNFwOPsJRHecNPZrHZHlDt/ODh2p3JCwPjeyonyXF5YQPmmsazQn56FrQ
	 jyPTfi5QFWKUtIXMIIZWNIXNmNxUMQTeaB8q5xgLsfCO3zL120aK+uYxT33f7L9bwrzsj
	 vjXodq9m2ZTOLSvIGSf6gIxn1poZedUHZBTSLNcDLGiZSCUnnyMN3WAkZVY0isyn20Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y2cvAsHX;
	arc=none smtp.remote-ip=209.85.167.174
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376F56082BE9
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 19:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 376F56082BE9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y2cvAsHX
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-55650fe1f0dso1707322b6e.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 11:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648070; x=1794252870; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yl96wqQilLpc7/Ibk/0ynCVIs5nkBAFIykihtuvWKqM=;
        b=Y2cvAsHX+eh05XBFXLysd1GcPu+vY41dwyUKo12gTOJdPcov2hoSPqGtuCVpceYehz
         20mDNdeMAEf9ob5iYr1G/N+Fg8qZyPA37dPl9871tzHdyCjOH7Qc4YYn4W7tSA9qs96B
         rNyg55aeiSi8qXx9Tcm8Kre+MJIVNGsH+CgJ3obpA33+HwAOhuGgvCGng8SsRkyVuCCi
         tIVItueXTU01zYJJGq3UBd1aipziXg734ghM0hIqUEutjGuauQdRLZPPdrNQn+BeIy2N
         O19HKfkQMO7rWU1JESoIbargJiErJ+52pGDkWf9eLwHjYyDP+Mhcn8EaXvudhXSkXmco
         5XBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648070; x=1794252870;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yl96wqQilLpc7/Ibk/0ynCVIs5nkBAFIykihtuvWKqM=;
        b=stFSFR1t8aJMvdmXM/ceRl0b1Nj/pCTZgwJtneaq60YfIJCM93eRXTn0XJYidt/oov
         nmLPaAjOFv7hjB4ZZcXaFuu4qFU2msot+ufgNBO/IEMR5smXZaMFrph6UUBvBsLmPrhh
         n5GbKKAcZaath7F4lUiAChr9q/Ee21s57VJgxoJ3x99Df9bVr3RR66cAW2osbaEVOT83
         VGFMruipe2ScFAjyl7ipH+myyfdfN1k1fxHLYQ6Vn7jZvEfClsEcqcmn9xg7rFRVSC1k
         x/Dm7pnVvzqPRdamnrHnu/5lsRymTXGiEAuqC2tXd2pCswaL8m+G3ran31VwRPQj2Q0d
         xusA==
X-Forwarded-Encrypted: i=1; AKwUvBwXHWt+hbiFEsgNFxOtg1Er8KL2RnTeLf6aPWwf58RtMwcbeei8XEj7vonaPTnpQzaHXonZ1kA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKj6pG7krlHfCDq7ojX+YkFDUf8jWmipyd3a6bifRcwSIprVC+u
	UB/q/OkJTs9itJa4ZK5+LDZVVqKYSeeXbliDUvVNO16d5oVz6kPEPR/7
X-Gm-Gg: AYBFou0YI03yBXIyqLK7tNMLvOvyK+W42QUuA5FHL0s8QQ81rMh/ZkKzj6SgmH+jV7/
	1os022mx3GrgMxD1Z7UuIuovqBAVUeoLO5x5VMpfdPdSVhT8HVvHzabYwnwx6BG6WaNLggsVqw3
	oA6jDqZyi6BlB7KltlyI7/SdJtj+T6NK5kMno1BvAUiqS3cSrFnYsF45URhMU4anKlrqH40NNm/
	NCPqkzEEMjbNKRTu1HXOO3DkQLfrlj8g9aQa5IAMUwHYf8agK8pWIeVcQwBB/JVbPcd5dJhq5Vt
	G/3ESpxozjvMa0Hghsdu5bI6+fmOdv11dkyoV65ciso992NDYtoMkYutttBKeePR1RdDt9tLjjc
	sEu0sM776k4Z0XTjtQ/ZoVOqZUSmsd8ymIhB99OEYSKFIJumDJRLe4JrAFQWrvt1vEed+8yuC/h
	MFc0UQ9GRSV/P0qu06oo/bmISQTUHpcA+AJOqiLwTEWmT4pgKuPuAr0P8Icu7dzwtNVjmg6b38F
	aMd2MIyfie+t6AJh1S2WBGt7WCUJWVLHHlzZK0egZaoOyoKyMof/5/4wci43W5Jw4HOt3OazklX
	gmQMd+y2eqvJxVFWIn1ylgJcYzcMnDagWcvql7bwuhzXpUfsXkuhF1Uj9OQe36gRNqPeUJaxNzO
	cEiR2SsVZtb5LgQ/Rn5VUOqyfSbw8/Bu/ltZy6BRyCLSNcVHXJRID/DtuuzBIiN0JZunlMiF4rU
	HAqYkFc2oXBM3j8J6PNZlA8zCKVsiSQeZplnguiZNZnJo5n3KhzrLE
X-Received: by 2002:a05:6808:6503:b0:4af:5d69:1cb4 with SMTP id 5614622812f47-5640dc20b39mr8692406b6e.15.1793648069992;
        Mon, 02 Nov 2026 11:34:29 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd93451sm8558249b6e.3.2026.11.02.11.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:34:29 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 12:34:22 -0700
Subject: [PATCH v5 10/10] dmaengine: dw: Prevent tx-status calling DMA-desc
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
Message-Id: <20261102-submit-dw-dma-synchronize-v1-v5-10-d3207758fbf9@gmail.com>
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

Changelog RFC:
- Instead of just dropping the dwc_scan_descriptors() method invocation
  calculate the residue in the Tx-status getter.
---
 drivers/dma/dw/core.c | 105 +++++++++++++++++++++++++++++---------------------
 drivers/dma/dw/regs.h |   1 +
 2 files changed, 62 insertions(+), 44 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 6371b9156882..e02082f47701 100644
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
@@ -269,19 +285,17 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 
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
@@ -299,7 +313,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 
 			/* Submit next block, including for polled transfers. */
 			dwc_do_single_block(dwc, child);
-			goto unlock;
+			return;
 		}
 
 		clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
@@ -314,15 +328,8 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
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
@@ -339,18 +346,17 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
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
@@ -376,40 +382,41 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 
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
@@ -885,6 +892,7 @@ static int dwc_terminate_all(struct dma_chan *chan)
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

