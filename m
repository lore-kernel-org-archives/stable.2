Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202048;
	b=ELpHviCYiH33xgoq/CpaWdqCR5sauNRcl1SLP673WjnW7mCNKrch+8EzpPzUdd3v1q7j
	 WOBY7TUTrUJG+QNVhrR3SgPGZnakkVrM4s37YnJT920aPD7ppAFYiwqjAI6IQHartL9cy
	 d0ElYH4G+BkTCPWGiQ84rYf1YrZ1jHGM48Je7ad34UEyp4q7iQmdMeoihUZAOxdYfVOAa
	 Lij6UNbQ7Bp8UymeEkBWuzMdcukVJh/iuwSEqla8jJG5NUL9EjFVShrFjsGtGe552smzE
	 oQn/teDbKsAQNfLhtrV2NuhtXKfsJLziF3y5UN0rjQLRn5gHSMwfRtHEy3hBYQKH8iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202048;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=hff5tvGmP/RyFyMtruhnb2xhTD0GxWM6AkuaxxUQMjA=;
	b=vjWT/ceYt+CYZPtIyMr3XRKQ0P1GiVZgQnOnlITAPtJjn2occS9yulD5xv0jQBznDMAN
	 K45TRtuk0p4JZmdy41fxniqp7uoV4K0BsrNXkwS1NjVnwtkSQ2mk88p8WcOOdV7jwaOvQ
	 w9NlrhjXGETk5H2mpOtX3IQxErK42srfAENIYBCUghZTblDoBu4L981jFsjg+RwPHVMq7
	 6GpcqauOP6mcrCVXoSacnGRuUcsG5+OGg+aOKoouoiI9QY7Dbl6BNq/+DJ/v0gOo1oBKT
	 KGNm0MyDF5OqUGh/Ru6aLq3+XWbLGMtorbcrB0Eg7iKIcs3O5WDIDUrWAOfRKOUzSKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rWkf5jVC;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BEB60A262C
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 19:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6BEB60A262C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rWkf5jVC
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-71b45386310so342467eaf.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202045; x=1795806845; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hff5tvGmP/RyFyMtruhnb2xhTD0GxWM6AkuaxxUQMjA=;
        b=rWkf5jVCB8LNCMh8N4AVYV5aWMG2fVD2EYCdQGGwTx6bHuW2pDeGm6d11kjsa1K8UI
         H5P52CHryu6ry3HvWHGLwRyVuPAE2sz590oz9ZBctoeosw/R7+3DumPTUc/11BhDLrRY
         on2wZDonBh30+zAUVHwAx0QJeO5Lq++chXZjsGCvc3kypauJti8RFW7bT/8rIHzboLL4
         ESWbD+d9jJNFTl709tRvWsEGtFZdICT+FvPB2kufXRBw3W1aFgzK5WNj+dJjPvMoas9a
         WfsgPJilomteRNE2D0SiQNhkTkrt90gE+ZjU/6NI/tk66dmRM0R06KOi8YgwVccvdCKP
         HmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202045; x=1795806845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hff5tvGmP/RyFyMtruhnb2xhTD0GxWM6AkuaxxUQMjA=;
        b=GsvKNY3x1f/s6D6NlN7qPJ1MnD/fjNcZrF5skgTs980hjN9yt66EpptO1DEp1H1q7h
         J6QlHaBRIemw6cYoAF497DIuDpwSuv5VuZivg0pgonaVH1S0KPwOMrSKOMEuQCL0zKsE
         3sI68rG/SWy3LwzY5ZTrTRFEckD/oDNmCbqnS9E0ZstejJ6kIfxfHn6v2RHKZduzjiiU
         ahzAr0A75BJBufoIhwAcLz310osUJlEd9dEv2VSBtTRqqliV7SJS7/Tb5LG+FEc+F4T+
         BSgNIvL8ET7rLD4+CwqyppCm4NvtT777IblWmhQyGW0uWff/qBrEAUByLq5kQUoIzXf1
         Vt/w==
X-Forwarded-Encrypted: i=1; AL+hErG6wS8lbaNObFqN+/JUfr0yYMlP1CY5BrA7PoDSz84agIQqc9KH7fod9VR7eZgC1G7qzkQfTfY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Pu0wgFCSzwJJrhAWesKjEn+Erkd79lQpOw6WvCYcmqY19Sp9I
	dSRvpozlVJPnR98UTZXsjtjndWN/2HG2Uio4iFuj9FJ+adeQtjPN7BGH
X-Gm-Gg: AYBFou07QWp6bBb1tn0h545sQRm9XGMiM7ruHYAX2z3r7x1LzRF8+B/bxapMMMYW5gT
	FXNmSqab7ZbwqsZX1wprPbUDOMARkFJCpvR1YHnnQtG8zge51q6z8y50if64tvPusPzwoHgABE1
	3faUXdx1L/QIFvXc6IUUr9UjXrbVv9bLIZbW+w/5iaP4r+7i4ukfx9LyISp4cm1+nQO65Abq7LS
	D8QsSlVWPfQttWsi32kHH5Msp/Fj6zH291RvqNUYfYilDWaVGYQ5zz7w3K8StVBm63GxAyOZBqZ
	4bnKSp+sVAq9dRsz1eULqEW19on7ecrPJ1rHDQSmK5LnZkUS8AZJXirh/2Fn24S3IoWyXlc503o
	4NPskDTptDQDDvydszRloAjkXUQH4c4NMl8q4Qmg0CVwOGNofEf7aAjJ8UrEWLDN7Yl4ly7yqMX
	KbKEU8SOFSQzq4kKsPnP9wJFcHThYcHr4zh+o17nvJ6bg3eVZoDz9ks9TpO1B8/SlmiEWgK85hI
	8iD6DpnjgtDyu5JG+rZH2Wjg9ULADIhnSIg6TX++5FT5hdLVkHadSFkf40D4DXQZwy9MsDAGjac
	hHKi4W1XwDDd3UU+8aLaJxasKmqZz5aWNHfGxApFJ5U+vF2HaoFsCpb32LF52JiQZtiTLK0ewQC
	4avsZHXJYzFAJs1DWLAjVtXFFdBzUTnyp/33mmRBhezSalXO+XXTErHoVOgiqMGKA6VFpVG2cx1
	5dCT5uQQ/+g4fmNkoYZEwstLaguYMf/hEpbQklG4Eg2iC18n3FYOL3
X-Received: by 2002:a05:6820:891c:10b0:70b:8148:94f with SMTP id 006d021491bc7-71b39588aaemr2283538eaf.76.1795202044585;
        Fri, 20 Nov 2026 11:14:04 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f3964sm2654782a34.14.2026.11.20.11.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:14:04 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 12:13:55 -0700
Subject: [PATCH v9 5/9] dmaengine: dw-axi-dmac: preserve pending pause
 requests
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
Message-Id: <20261120-submit-dw-axi-dma-stop-pause-v1-v9-5-48ab58961d6e@gmail.com>
References: <20261120-submit-dw-axi-dma-stop-pause-v1-v9-0-48ab58961d6e@gmail.com>
In-Reply-To: <20261120-submit-dw-axi-dma-stop-pause-v1-v9-0-48ab58961d6e@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>, Baruch Siach <baruch@tkos.co.il>
Cc: Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev

dma_chan_pause() clears SUSPENDED even when polling times out. Hardware
can set that status after the last poll, and the unconditional clear then
discards an acknowledgment the caller never observed. Another channel's
interrupt can also consume the status because the shared IRQ handler
clears every channel's status before taking its lock.

Leave SUSPENDED to the pause and resume paths. The channel latches the
status for polling but does not enable its interrupt signal, so leaving
the bit set does not assert the IRQ. Track the suspend request separately
from its acknowledgment so a timeout can be followed by either a pause
retry or a resume. Wait for acknowledgment before clearing the hardware
request, since hardware ignores an earlier clear. If that wait also times
out, return -EAGAIN with the request still pending.

A completed transfer is also quiescent, but its completion handler may
still need to advance a cyclic descriptor. Defer that restart while a
pause is pending, and resume it without reprogramming the first LLI.
Track the active descriptor until its completion handler runs so that
resume and issue_pending cannot restart a completed cyclic segment or
reissue a completed noncyclic descriptor while its IRQ is pending.
Start queued work after the active descriptor is retired, respecting the
pause request.

Clear stale suspension status at the start of a new descriptor rather
than at each cyclic restart. Reset the software state after successful
termination and when allocating a channel for a new client.

Store the lock-protected pause flags as bitfields in existing padding.

Fixes: 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 99 ++++++++++++++++++++++----
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  8 ++-
 2 files changed, 91 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 8c115d20728b..99b648d4ca76 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -482,6 +482,8 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 	irq_mask |= DWAXIDMAC_IRQ_SUSPENDED;
 	axi_chan_irq_set(chan, irq_mask);
 
+	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
+	chan->desc = first;
 	axi_chan_enable(chan);
 }
 
@@ -490,6 +492,9 @@ static void axi_chan_start_first_queued(struct axi_dma_chan *chan)
 	struct axi_dma_desc *desc;
 	struct virt_dma_desc *vd;
 
+	if (chan->desc || chan->pause_requested)
+		return;
+
 	vd = vchan_next_desc(&chan->vc);
 	if (!vd)
 		return;
@@ -544,6 +549,10 @@ static int dma_chan_alloc_chan_resources(struct dma_chan *dchan)
 		pm_runtime_put(chan->chip->dev);
 		return -ENOMEM;
 	}
+	chan->desc = NULL;
+	chan->pause_requested = false;
+	chan->is_paused = false;
+	chan->cyclic_restart = false;
 	dev_vdbg(dmaengine_chan_dev(dchan), "%s: allocating\n", axi_chan_name(chan));
 
 	return 0;
@@ -1088,6 +1097,8 @@ static noinline void axi_chan_handle_err(struct axi_dma_chan *chan, u32 status)
 	vchan_cookie_complete(vd);
 
 	/* Try to restart the controller */
+	chan->desc = NULL;
+	chan->cyclic_restart = false;
 	axi_chan_start_first_queued(chan);
 
 out:
@@ -1135,11 +1146,18 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 			}
 		}
 
-		axi_chan_enable(chan);
+		if (chan->pause_requested) {
+			chan->is_paused = true;
+			chan->cyclic_restart = true;
+		} else {
+			axi_chan_enable(chan);
+		}
 	} else {
 		/* Remove the completed descriptor from issued list before completing */
 		list_del(&vd->node);
 		vchan_cookie_complete(vd);
+		chan->desc = NULL;
+		axi_chan_start_first_queued(chan);
 	}
 
 out:
@@ -1161,6 +1179,8 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
 	for (i = 0; i < dw->hdata->nr_channels; i++) {
 		chan = &dw->chan[i];
 		status = axi_chan_irq_read(chan);
+		/* Leave suspension status for the pause and resume paths. */
+		status &= ~DWAXIDMAC_IRQ_SUSPENDED;
 		axi_chan_irq_clear(chan, status);
 
 		dev_vdbg(chip->dev, "%s %u IRQ status: 0x%08x\n",
@@ -1200,6 +1220,12 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 			dw_axi_dma_set_byte_halfword(chan, false);
 
 		vchan_get_all_descriptors(&chan->vc, &head);
+
+		axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
+		chan->desc = NULL;
+		chan->pause_requested = false;
+		chan->is_paused = false;
+		chan->cyclic_restart = false;
 	}
 
 	if (ret) {
@@ -1215,16 +1241,49 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 	return 0;
 }
 
+static bool axi_chan_is_suspended(struct axi_dma_chan *chan)
+{
+	if (axi_chan_is_hw_enable(chan))
+		return axi_chan_irq_read(chan) & DWAXIDMAC_IRQ_SUSPENDED;
+
+	/* A completed transfer cannot acknowledge a new suspend request. */
+	axi_chan_disable(chan);
+	return true;
+}
+
+/* A timed-out request can still be acknowledged. */
+static int axi_chan_wait_for_suspend(struct axi_dma_chan *chan)
+	__must_hold(&chan->vc.lock)
+{
+	bool suspended;
+	int ret;
+
+	if (chan->is_paused)
+		return 0;
+
+	ret = read_poll_timeout_atomic(axi_chan_is_suspended, suspended, suspended,
+				       2, 40, false, chan);
+	if (ret)
+		return -EAGAIN;
+
+	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
+	chan->is_paused = true;
+	return 0;
+}
+
 static int dma_chan_pause(struct dma_chan *dchan)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
 	unsigned long flags;
-	u32 status;
 	int ret;
 	u64 val;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 
+	chan->pause_requested = true;
+	if (chan->is_paused || !axi_chan_is_hw_enable(chan))
+		goto wait;
+
 	if (chan->chip->dw->hdata->nr_channels >= DMAC_CHAN_16) {
 		val = axi_dma_ioread64(chan->chip, DMAC_CHSUSPREG);
 		if (chan->id >= DMAC_CHAN_16) {
@@ -1251,17 +1310,11 @@ static int dma_chan_pause(struct dma_chan *dchan)
 		}
 	}
 
-	ret = read_poll_timeout_atomic(axi_chan_irq_read, status,
-				       status & DWAXIDMAC_IRQ_SUSPENDED,
-				       2, 40, false, chan);
-
-	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
-
-	chan->is_paused = true;
-
+wait:
+	ret = axi_chan_wait_for_suspend(chan);
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
-	return ret ? -EAGAIN : 0;
+	return ret;
 }
 
 /* Called in chan locked context */
@@ -1295,6 +1348,8 @@ static inline void axi_chan_resume(struct axi_dma_chan *chan)
 		}
 	}
 
+	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
+	chan->pause_requested = false;
 	chan->is_paused = false;
 }
 
@@ -1302,15 +1357,31 @@ static int dma_chan_resume(struct dma_chan *dchan)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
 	unsigned long flags;
+	int ret;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 
-	if (chan->is_paused)
-		axi_chan_resume(chan);
+	ret = 0;
+	if (!chan->pause_requested)
+		goto out;
+
+	/* Hardware ignores resume until the suspend request is acknowledged. */
+	ret = axi_chan_wait_for_suspend(chan);
+	if (ret)
+		goto out;
+
+	axi_chan_resume(chan);
+	if (chan->cyclic_restart) {
+		chan->cyclic_restart = false;
+		axi_chan_enable(chan);
+	} else {
+		axi_chan_start_first_queued(chan);
+	}
 
+out:
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
-	return 0;
+	return ret;
 }
 
 static int axi_dma_suspend(struct axi_dma_chip *chip)
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index 3c86e5d468ea..b18c9880711a 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -42,6 +42,12 @@ struct axi_dma_chan {
 	void __iomem			*chan_regs;
 	u8				id;
 	u8				hw_handshake_num;
+
+	/* Protected by vc.lock. */
+	bool				pause_requested:1;
+	bool				is_paused:1;
+	bool				cyclic_restart:1;
+
 	atomic_t			descs_allocated;
 
 	struct dma_pool			*desc_pool;
@@ -50,8 +56,6 @@ struct axi_dma_chan {
 	struct axi_dma_desc		*desc;
 	struct dma_slave_config		config;
 	enum dma_transfer_direction	direction;
-	/* these other elements are all protected by vc.lock */
-	bool				is_paused;
 };
 
 struct dw_axi_dma {

-- 
2.53.0

