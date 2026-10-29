Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312994;
	b=kRb3dILUy7c/Go6xB1wC8mtTY9k7FaZUrkq/6ivysX4HkdFAkDaOJZar816Z8NwgZtFK
	 gdlbPXfSR4amCurVxQ218WnCVD8VkhOAyR6esN0AL4xFMBbJjSQtqXnRcKH1YBdpdqfHe
	 a7T+vl4fPP9LvkGGif0RP4zAx/fflb1nqQKzq0E7ZLW6g2Rk1WvF7YYGBEmpUDqol3Yui
	 E/rHZ5VwjJkd/a5d5RYvZHyTk1T9Xtfw1i6NzRdJppwM0+NaJjXHakcZXIbWdZSHLNyrf
	 kikeX9kwvP7u1c8tJEDXgDkQw2sDuaqQf9yGYWt3AjlPoJGgvM/5WvT3NXYEcbm/aQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312994;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=V3aVMBEgHd2ET1QgNtXDVMmlRouLoSPiwRHkeRlkC0o=;
	b=BajW1iETv/OcfnEdUySufUvF77upqd9mZOOL84tqwbS7ni+HeVQnIAibw7QhUvfh+ENI
	 srZxKDtOeyFU0olw90vtJlF+4ejz+TfC6EkaSkRnE5R98iU7HJ2rdeGyg7WA0ZcaoP+a1
	 v7KYXnpu5h5ribr856pwkZbrlqp9iF1RgIPMF+ZZHCVvKQs33j4vLgatTYZ6Xyc8OCV0d
	 dSjl8WtePYzFSkWY9wOUqSBvTxqe7uxucPuCXUlpVeldTWXSsEUl1E0XOC3UamwS1PVc9
	 hpmEvbgKmsuU8JHxqqKj28sVUwmLUWw6dB0PbqMHbvi95cTPFVEeVGJK1FJ3nZYKQmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hVVekswo;
	arc=none smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B707460A2605
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 22:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B707460A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hVVekswo
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4b190cdc9feso77972b6e.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793312992; x=1793917792; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V3aVMBEgHd2ET1QgNtXDVMmlRouLoSPiwRHkeRlkC0o=;
        b=hVVekswoHQdlz999Gs8Vn53cZ4nPwjP1ChbWRh7eRX7VPs6Zj+KVXjA2hKpvJyujV9
         Wb4OsXswCplvtb1lruNW12JAIsKHANaKRTZrVWrrijuDhohTwxAQElvuS4M8euvWhlmh
         zevr2+ysCbGCuDw6cCUAkBsF74haeyOmXM07a3TaepvBekGHZw5OPU57iSeUZiaENZof
         YCmww+32cGJFBJwQVNALyh983falWd2hmLWQ5+W/BYAGTukPoXp8q/5+MDuNBvv5vqqc
         sjgg6XRXoJdK8exrS2plfVFm2itdH2BIW+GfpLetEqbe0VoghF6dezKfMdxAoDKCHHtv
         tifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793312992; x=1793917792;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V3aVMBEgHd2ET1QgNtXDVMmlRouLoSPiwRHkeRlkC0o=;
        b=kf8y+4rGPWQCRHVUPg/HkgEtJmYh22+vxdS9HtCQBq3zLNxJvXW1zYiSH+KVO4YzKV
         5dGrg1Jc6CcJsJ0zmYcnxcEJB6AnbgwZR+/hvOC7XBpXdDmBYIogM2f6uBqMOgQVitrg
         uJsjHept8/ibXnLKEVvvT74DLV2O/kAiSY2lx0IFjUkHg21lKxnebiYC81QxMbWTtSN9
         eWvNKZ51HWltlSkwK7Y6VhGe1FuzG+P70si7MUrHe2iL7PYnFQ1CVVKuMj0ZZUTn2wBq
         JkFJsNqE7fwZHzTTlLfd+tm6aQ/Kpk5BRpSHkMhgHLjB9iysMh7YBDD3Q1wPf4Z50Ghm
         gapQ==
X-Forwarded-Encrypted: i=1; AKwUvBz/A5cbYVxo/OHtlL89lWoMemyoLPnhDz7q4hw2nIDD6CTPwsaJWPgur/wcpuchzBPBTqByswE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHVYGHwqSC8r5/sCK2u0UmnOxCV+ul1i2iL9zGMKjuhg2ZDA6U
	zD0PdogkmaMXOyqjsiJQOlAOgC8nofp1/Y0NlNIkOVpEpLBMuuaXXpJs
X-Gm-Gg: AYBFou1sVcCRTjJ2qKjSpjK3NMUEhrR5TC3mjasUwnavV16AdOWb2LGOkYz3A9RWffy
	YMF1nb12tsZSHeRHMspdj5X4pj9i6Vmd1fUWDoSDJpQNLIkgHLK4NmX+eTcmgxaCysqDY50/p2n
	1/0B/hvxE/nPEhxQEmPEGizlSdipMdbXDFuFFczAMWckGMdcp7fNaKDxJf548kkfVWibbWRbWPI
	eE+JmJLrqca5PWhDNSUxg51KpmHwwwJxoijq2dEN9+yGeEMA0NSDxczLVMzHvxfQC1XmjUOwwQS
	hFc/PvGwhyuSFb/9fOEmbkKTvoo1PIRy4BUSi8eItoVfLBWR5jJNu4B+NZTgieEJJxY3YWC1qD/
	zE8VEn2vuwNHaIRrBe14oI3A7vm0wy67ALLtW3CQWhEathw4kVxhyFyfZRSKs3pOarNlWALVFUm
	283QzL9pXBRGBjcXS1Cn84xT7sNNlsBDhZFY3iYdKUuI/2pjhKF8pfQIXKxbGak//W5LM/juRBk
	0Mtl96UwQhVj5iR5Tkq2Y6HZb3NTQpszfH9IialnUrfNoE8qwspqjRRxbccRJqk4bPR6Tq/YhlW
	cOfLjNvX4h9o/8Kw6dkw6WIqheWL5AAcsyEJ59JsMznMxcBA7I8X3TXgauAGywBTKqe6Rx+WIeR
	ZUApRThG5xcs2d1rwIuGFROBmLeSC5hpQ8qRRp5jfk2vdhUPgBSUUyAcXgydOvDVQRNSZmXLT9s
	rCEyg1tSoD3N1fQJwA+T+nsMY1Iuepc467i9yB6h3MQDTHlvbxCPqPw8ZOaY+lEepea9JtzXsJ+
	w==
X-Received: by 2002:a05:6808:c410:b0:4df:5cd0:89c1 with SMTP id 5614622812f47-5640dcf25a5mr483692b6e.23.1793312992335;
        Thu, 29 Oct 2026 15:29:52 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fc49880sm236130b6e.2.2026.10.29.15.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:29:51 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 16:29:38 -0600
Subject: [PATCH v4 4/7] dmaengine: dw: calculate residue separately from
 completion
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
Message-Id: <20261029-submit-dw-dma-synchronize-v1-v4-4-fea447d9f285@gmail.com>
References: <20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com>
In-Reply-To: <20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com>
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

The descriptor scanner mixes transfer-complete handling with hardware-LLP
residue calculation. A status query needs the latter for the requested
cookie even when no transfer-complete event is pending.

Move hardware-LLP residue calculation into its own helper and call it from
the status getter under the channel lock. Keep software-LLP progress in
the scanner and subtract the current block's progress when reporting its
residue. The scanner now handles transfer-complete events only, retaining
the distinction between zero source residue and destination completion.

Also search the queued descriptors so a transfer waiting to start reports
its full length instead of zero residue.

Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Cc: stable@vger.kernel.org
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
[james: retain polled completion and report queued residue]
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---

Changelog RFC:
- Instead of just dropping the dwc_scan_descriptors() method invocation
  calculate the residue in the Tx-status getter.
---
 drivers/dma/dw/core.c | 166 +++++++++++++++++++++-----------------------------
 1 file changed, 68 insertions(+), 98 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 1f7afcd01565..1d6419e1cd3c 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -274,123 +274,60 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 
 static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 {
-	dma_addr_t llp;
 	struct dw_desc *desc, *_desc;
 	struct dw_desc *child;
-	u32 status_xfer;
 	unsigned long flags;
 	LIST_HEAD(list);
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	llp = channel_readl(dwc, LLP);
-	status_xfer = dma_readl(dw, RAW.XFER);
 
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
+	if (!(dma_readl(dw, RAW.XFER) & dwc->mask))
+		goto unlock;
 
-				/* Submit next block */
-				dwc_do_single_block(dwc, child);
+	dma_writel(dw, CLEAR.XFER, dwc->mask);
+	if (list_empty(&dwc->active_list))
+		goto unlock;
 
-				spin_unlock_irqrestore(&dwc->lock, flags);
-				return;
-			}
+	desc = dwc_first_active(dwc);
+	if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
+		struct list_head *head = &desc->tx_list;
+		struct list_head *active = dwc->tx_node_active;
 
-			/* We are done here */
-			clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
-		}
+		if (active != head) {
+			/* Update residue to reflect last sent descriptor. */
+			if (active == head->next)
+				desc->residue -= desc->len;
+			else
+				desc->residue -= to_dw_desc(active->prev)->len;
 
-		if (dma_readl(dw, CH_EN) & dwc->mask) {
-			dev_err(chan2dev(&dwc->chan),
-				"BUG: XFER bit set, but channel not idle!\n");
+			child = to_dw_desc(active);
 
-			/* Try to continue after resetting the channel... */
-			dwc_chan_disable(dw, dwc);
+			/* Submit next block, including for polled transfers. */
+			dwc_do_single_block(dwc, child);
+			goto unlock;
 		}
 
-		/* Detach the completed transfer before starting queued work. */
-		list_splice_init(&dwc->active_list, &list);
-		list_for_each_entry(desc, &list, desc_node)
-			dma_cookie_complete(&desc->txd);
-		dwc_dostart_first_queued(dwc);
-		spin_unlock_irqrestore(&dwc->lock, flags);
-
-		list_for_each_entry_safe(desc, _desc, &list, desc_node) {
-			list_del_init(&desc->desc_node);
-			dwc_descriptor_free(dwc, desc, true);
-		}
-		return;
+		clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
 	}
 
-	if (list_empty(&dwc->active_list)) {
-		spin_unlock_irqrestore(&dwc->lock, flags);
-		return;
-	}
+	if (dma_readl(dw, CH_EN) & dwc->mask) {
+		dev_err(chan2dev(&dwc->chan),
+			"BUG: XFER bit set, but channel not idle!\n");
 
-	if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
-		dev_vdbg(chan2dev(&dwc->chan), "%s: soft LLP mode\n", __func__);
-		spin_unlock_irqrestore(&dwc->lock, flags);
-		return;
+		/* Try to continue after resetting the channel... */
+		dwc_chan_disable(dw, dwc);
 	}
 
-	dev_vdbg(chan2dev(&dwc->chan), "%s: llp=%pad\n", __func__, &llp);
-
-	list_for_each_entry_safe(desc, _desc, &dwc->active_list, desc_node) {
-		/* Initial residue value */
-		desc->residue = desc->total_len;
-
-		/* Check first descriptors addr */
-		if (desc->txd.phys == DWC_LLP_LOC(llp)) {
-			spin_unlock_irqrestore(&dwc->lock, flags);
-			return;
-		}
-
-		/* Check first descriptors llp */
-		if (lli_read(desc, llp) == llp) {
-			/* This one is currently in progress */
-			desc->residue -= dwc_get_sent(dwc);
-			spin_unlock_irqrestore(&dwc->lock, flags);
-			return;
-		}
-
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
+	dma_cookie_complete(&desc->txd);
+	list_move_tail(&desc->desc_node, &list);
+	dwc_dostart_first_queued(dwc);
+unlock:
+	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	list_for_each_entry_safe(desc, _desc, &list, desc_node) {
+		list_del_init(&desc->desc_node);
+		dwc_descriptor_free(dwc, desc, true);
 	}
-
-	/* Residue describes source reads; only RAW.XFER completes a transfer. */
-	spin_unlock_irqrestore(&dwc->lock, flags);
 }
 
 static inline void dwc_dump_lli(struct dw_dma_chan *dwc, struct dw_desc *desc)
@@ -969,9 +906,39 @@ static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
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
@@ -984,9 +951,12 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
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

