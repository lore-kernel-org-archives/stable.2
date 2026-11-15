Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727195;
	b=ZRMOHPKNQxNJHxDxIyuVpkH6Feoct+46hy+cmHYFh6c9z7nonmjTgVffo//BSekKkty8
	 TrkWtPSGM7ELn4P+EF9NCskiqbaYslPtTAgbXBLJ0dlvUQXHwJfG0EgyJDQbBL5yjh6zc
	 Gde78+2PkDiuPCUr9uCb1x3yDzG9hTxUrZn/9rCQ3RbR2NreQGiygmwWDdPq2bRcVnSsN
	 3O/0TJh/GZMv2KYvulQRazjha2bAuM2SEWLcj0hLMf1IHPfTl9UVwVs319Os6YRmxPGdS
	 Sej2/5r/979Lm/xAOqSuWcLqldnzG7Ll+oZed3y5yjgGyIeTnOJdC9TlJonkkuS4jjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=pZ+dtlSoMIwzi8tXLggRIOEKa0idJB89sEnqPt1VQaE=;
	b=wTeKDuTi2zCdmiFamnAraQDqXV1yw0DHZ0a2fdm757VU3rGyxsnMG7pxpcaZdIJWYhSW
	 kVn1NoG/BaRyTuSycBOCbmrlU7EhjGHYuA6htTt2eNM7W9SXfAaPXEN8o7e66iJ5FjqUh
	 7xsuhsojRyzjzT1HNSlkpn8Q09YepElNTws1/TytUTXllij1Tlzr20FYGQzpUoUE056ul
	 TN+AV5hj4MeEUQncUcQ27VbivZCdMh4JtYggXhb+exH6piFg3Xchk3QN5f0ZHuLN53zd7
	 mYitJ+3yVYlke0NCWI3tCE4IgUiS2brMdB7kLkgIEFnBVfEJn2DtcnwAODz34j67r3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rVBifrle;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE03460A382F
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 07:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE03460A382F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rVBifrle
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6df7f544919so2064555eaf.1
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 23:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794727194; x=1795331994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pZ+dtlSoMIwzi8tXLggRIOEKa0idJB89sEnqPt1VQaE=;
        b=rVBifrleMzP84l/hPxYELN2fD2a0DnTrmhidiUE/G3b2Ci7QZihgT1VdZV8GePTF/t
         DOEjfBzF6Vats+CXTaPgLqUOuAExcNKyFVfUmRaFiNc35TvW2htW4Z8MBWKo318iwwi7
         raRNt93RWvJ+uMHRuuaPSweciuYkRCh/qidEERyNJbSO86DVK7uocznMGUMIRLU5FvAf
         mfnS3X3pLR9G28dW/WbkdY3Ewb7H372j7Mjndz/+bYv1NY9+hjpipygSf61XHvKfrB6n
         fCmu1Jl/0NKciZzVUVtxwSKUC7OS2BH+tyc3kYgPbtsGu4/s2ZpuCn09mx+9lWJP3dTY
         GD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794727194; x=1795331994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pZ+dtlSoMIwzi8tXLggRIOEKa0idJB89sEnqPt1VQaE=;
        b=jaJOoApCyilslF+CGzt973sNJTAxMuujpGaljuyxMfypUkI8ovJdg9XWJArTG6jCTh
         B30Z2sUtCz+VlGeW8YdD9qXK+P9gEuWHuszN3uGpIgY4lQ3ho10RJiNzP7Dqlvs69cle
         +daXwJXYNkfeEpz+CD6C5+SdZews4tJCp+5BtRhmwv8B9YIatZcLZECAwR/1RyQYejYT
         jHcHyoX34GaSyLI0T7vnRxppSy2jP5biA1DOnjtl42j6rGCGmvMT2Z1FJza+BtxM2fPN
         kcEErCASIOoQdE51DLJ77tVtjvdeNejYq/ZJNZGnCQi6UDaetyWldr8prurWWXgASQvj
         zQAw==
X-Forwarded-Encrypted: i=1; AL+hErGS+ud3SmCBpk4sHb2LiMgVn//SJcnJ00F8cT7jYqxe+YwS/rNR3yC/KnL23rEOMroe6T9Fhvs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6EJJK02gcjR+TE2v/4yzp2JbHa0eV4EzJbSu86NVAHC2npSsQ
	24WQqwj9CywVPPIcrGn73NEaeUZC9FF6sFzilSZiHb1sGXovD55AW12b
X-Gm-Gg: AYBFou2L90Lpk98hNJe8Dt+ssw/SoChHaAuReaY8/Qdxf9WY6mKBGNoezq7VnLVMvcX
	Oil4veVeQt9PEUaHHbLMnJpparqeY+TqWS4w/suDFcq9rJqpf8yCDtroDlw4BTjr+3qC3+zROk3
	dV8sU/ejdD9iSq2Zkpx4aDEDt6s1b2hgrntjAsgpuZM+lWW/1hh9QoNGz2OWZQBOMcff/I2y4fd
	Ipa3jnoN9bdfG+aODXOA+fgwbBT4H45cMgAZSu25c8VEH2EKrKEhT1nfPq6+5NycrmglS9/l2lw
	m8+A0kPeaM34XXfZgcyLca5ez0NzeIj3PmOok2rHLiPgpw8IGbDgASnAojg+um1YohGcCibKGQF
	Ggcv9fYcILndc4fF61SMw28Is9f9YM6BqEWp2HSh8sL4B1E7FqNy5NbQRh5auh32O14vl9GtARj
	1E7ERvuykN5FRvJpe8AsBMvuozvMB18teVE9QAovL43k3zwQDnTHCNJrWk/8Iv8l4vx5aX7pIUo
	l0YnulIvy2772IKy2WnTNQeVmd760ET1iDg1OrQEtB4JOSH0mWIoG8mjLP94Paixoo4XmWKtO8u
	JVXDph1wrzKOtyyS2X6DfVggmfsUtc+bDPkVmlQpLz0mLC2ky37mRCgI1kgdBojXN8KGbamvAK+
	iKTAJpvEvYcqjFR/3sEqs/c7Z6zIsKp7qTsG+M3LVWTrRHwMES9WTmDJvIRvJN8js/t0EMonJY5
	wbzhxvXvibGSIuovkKhPR2v3h+7ex/5f36tHn3sN/pH8pzEzMVILw=
X-Received: by 2002:a05:6820:83d2:20b0:716:c021:56eb with SMTP id 006d021491bc7-71ab4ef6568mr3133090eaf.28.1794727193901;
        Sat, 14 Nov 2026 23:19:53 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ae860ebd7sm1145321eaf.8.2026.11.14.23.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:19:53 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 15 Nov 2026 00:19:43 -0700
Subject: [PATCH v7 10/10] dmaengine: dw: Prevent tx-status calling DMA-desc
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
Message-Id: <20261115-submit-dw-dma-synchronize-v1-v7-10-8d58f3d49e4d@gmail.com>
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
 drivers/dma/dw/core.c | 102 +++++++++++++++++++++++++++++---------------------
 drivers/dma/dw/regs.h |   1 +
 2 files changed, 60 insertions(+), 43 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 6f863fae7455..804fbfa0e5e5 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
@@ -257,6 +258,22 @@ dwc_descriptor_free(struct dw_dma_chan *dwc, struct dw_desc *desc,
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
@@ -295,19 +312,17 @@ static u32 dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc, struct dw_desc
 
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
@@ -325,7 +340,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 
 			/* Submit next block, including for polled transfers. */
 			dwc_do_single_block(dwc, child);
-			goto unlock;
+			return;
 		}
 
 		clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
@@ -340,15 +355,8 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
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
@@ -365,18 +373,17 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
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
@@ -402,40 +409,41 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 
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
@@ -911,6 +919,7 @@ static int dwc_terminate_all(struct dma_chan *chan)
 	list_splice_init(&dwc->active_list, &list);
 	list_for_each_entry(desc, &list, desc_node)
 		dma_cookie_complete(&desc->txd);
+	list_splice_init(&dwc->completed, &list);
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -955,10 +964,9 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
 				      enum dma_status *status)
 {
 	struct dw_desc *desc;
-	unsigned long flags;
 	u32 residue;
 
-	spin_lock_irqsave(&dwc->lock, flags);
+	lockdep_assert_held(&dwc->lock);
 
 	desc = dwc_find_desc(dwc, cookie);
 	if (desc) {
@@ -978,7 +986,6 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
 		residue = 0;
 	}
 
-	spin_unlock_irqrestore(&dwc->lock, flags);
 	return residue;
 }
 
@@ -988,19 +995,24 @@ dwc_tx_status(struct dma_chan *chan,
 	      struct dma_tx_state *txstate)
 {
 	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
+	struct dw_dma		*dw = to_dw_dma(chan->device);
 	enum dma_status		ret;
 
+	guard(spinlock_irqsave)(&dwc->lock);
+
 	ret = dma_cookie_status(chan, cookie, txstate);
 	if (ret == DMA_COMPLETE)
 		return ret;
 
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
 	return ret;
 }
 
@@ -1079,6 +1091,7 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	struct dw_dma		*dw = to_dw_dma(chan->device);
 	unsigned long		flags;
 
+	/* Polled completion can leave descriptors waiting for the tasklet. */
 	tasklet_disable(&dw->tasklet);
 
 	dev_dbg(dmaengine_chan_dev(chan), "%s: descs allocated=%u\n", __func__,
@@ -1089,6 +1102,8 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	BUG_ON(!list_empty(&dwc->queue));
 	BUG_ON(dma_readl(to_dw_dma(chan->device), CH_EN) & dwc->mask);
 
+	dwc_free_completed(dwc, false);
+
 	spin_lock_irqsave(&dwc->lock, flags);
 
 	/* Clear custom channel configuration */
@@ -1238,6 +1253,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 
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

