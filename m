Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104118;
	b=EhrNTtBwPFlH0BNpndehUZY9C4S1t9M3sL1xwMJpt86RJR9JfIi0UrlTKzTFujNPEvRS
	 aVKH0iMMZuGkvCRHFKjchapqIZ2tZHl5yzYP/aPy+4iZGdsjhzhSZj7L61QrYVjOvHVy6
	 vLkS2WayTl5NNTcgR2XhE0+MkAj26EiwTHOuR8sB0o5iB6RMiNTEG79s+EasRhyoW6YNq
	 x/gApR7UsVLN94sgoz01QxRsVG2zp4+cgIR4+z3l8eXubA6rVhVJveg1S6gxaKG22YOLv
	 4sqXoRo0334dOaahRe7sp2WZfundDfZV9nmk4ubapvHV6YRoQ4jLdc0wvOj6O9tcZSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=rfsGoBQIbogwRnnVczPLtH8aeHkW23Do7VnMP/YAMt8=;
	b=cNBugvvAwvD2VWBK5kD06huq6FStDMRLCfI+0lw9JnkmQL5m/GGWqnx3twk9HC/5tTxg
	 HI6as4nGZyIf7SYNO8wdlcjGHFZqrhlUquIt4VKvZuJfBzZFbJ6a5jC2FbFp4DFwnyXYF
	 UmWAsNtVtf+ErvkFPOQ81nJu9tsJJjhwxdIRYt0/RUJdAY3YsFkxMpNU1KmmoNXZmv4zj
	 8oFgn0mWMiAJ0Et8aGJMHT7084O3mE22tfyzMOo4nSzhNAsepM3gmRO1k1bPEWTeYV3HQ
	 5iyKVUqIDYmQ/oiSjRLwlK2/oDZR3Go8XT5DpwUiOkjIP8OrjdHGdbWqOFeELqLJwmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AHShgd2o;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6A060A381A
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E6A060A381A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AHShgd2o
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b4d86f5328so17720267b3.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795104117; x=1795708917; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rfsGoBQIbogwRnnVczPLtH8aeHkW23Do7VnMP/YAMt8=;
        b=AHShgd2oeLMqBrr0sc7ZEvNlAG+K7PWEG/bWzutCIHJdFaft1/dhI00nz1BnT9hp20
         z0tyWXjkaFuAVyKiQUpDHHelnpuqv5JxSipGT/vot72LGj5vtYreb8zbqQT2YTZdPcWc
         nTblMcTjObC+P3KsLoIulu/JU0WzP6qWf16yhDrD1IXZ+Ljq4KGVYSuXCjCTG/3y78lv
         +AISzGfv8sDx0eqSq5TVPhojVGjKhCa9a3fD2LuccNF88MLydstQ/09Ar+ddpYG/zm7t
         teU0gYaJ6kflW3gW2q31Xjjb1+UsTjYFK+Tnl56O2Mp8j/+kpM39G7o2h8+dfsN6wrk3
         deug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795104117; x=1795708917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rfsGoBQIbogwRnnVczPLtH8aeHkW23Do7VnMP/YAMt8=;
        b=pMHR6WlO+jIhYmR8SCkzpxiR7imqIATN4gqM1R1GnqDjFvPajVEkCZLMt0Cvh2WWlY
         v0jj2EHXUVdQBOpnk3kkLWR5yNKSEqwO+vwRum/ePv0mbTNuhOPL1F1jU0ScVnKAxbRo
         1F3EqOgL/Nd1R/Q1PMezgMA+eMuLi974d+Uvy9/8Vz/xXKDV+KPD631kZBJrOBITDt0n
         1IAhLN8qOQNoKVT+5osXB018gOAaft77eVTLn55AUUy63Tg+HijRzaRI/ZxFsors52Ds
         0eAKr/lL+TtfYuNEcUY5+wjkqMIkT9z0DwoCet+Mk9dHYdrAtnVL/TB3eZiiEJMv91ws
         Qf3w==
X-Forwarded-Encrypted: i=1; AL+hErGA+Qk+hRDrinQffpzkRiwWACALpQrdYQzK1g891BtGtYt7ehB2YZFfwNpnB5S+CFAF6vzmCZA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9K1CQujD9xraUp8OuTtjEe9523G3ftF5q1s1uhZhekkG6dtiR2
	wsdQLPegKU23ToBFP9j7b5GAcV3EmzKqXn1OMl+sZ8qlpRACNRMBRYqs
X-Gm-Gg: AZFdTZdO5UyADzKXSBVkBqdgXExRNCcQROwXgGgOTpHLoJSts9VJfJjIeOFJIfq3kx7
	eNZlZR1zPU1k2RrGLBpkY0lhXsiPROTRb1t+HwQ2l3aKnMrcs1jUvqkuXQZkRM2p0Esh4RIvAKw
	svIZxmk0NYGpB7Q1pXUCVi6y7Z83nqcEOIO9/6YWfDLeTqdBVXoLlQ+1q6wEADUB+mKcs4d5xI2
	71GTcaT7qQFhJ7zH84W8KpaRRTsPa0/+qbSaH7j2EujX9EReTFo4oaH5q0fBXlz4u2uzGM9jCxC
	HgAlItLdoru2J1/HRVJgaLuQPl6LYKsDfULG+XbwbW/n6YYijyR2xYUT75yNQqYbg+GoZngAh+9
	KOgc7TfnhLwnaiO16wppimRGzoWpjTjqPlSqqjmpbAdL04R/rg0A7f4C/CqQLDjSScR+RpjOedd
	e7sXPU7MjuKjP3p1MBaawLFCb6tMel0QmgiOVggAwWOwh2cj5D9ffY6VY7Ey5DYdsZta/NGsz2t
	skhu9YOd5vxB++UOnGZw/69OGkaJfN86oGbfvMAkNCy9022Lc9r9mOjLEjMOKzYuLpOlzTTgtEF
	iIxTMrBb6oT6bHp+7xVsXu+84TjwCEWRAUyCyCV6s/bMf6GyzQUxxA8ikImSOI9ZX4+oFNgMA8T
	iqs2IO3jpWZgfRRWJ1kX/Nrq+31CJq+tPYiQMQck5HXeG2YzsRtlgYL38OLmkBGbjlv4ViBpus8
	4iNPAdQ/agzzaifDN2xMLu1v7td/eCeAXiB2b2+vY+SU7IWNXlMHJrAmGGXNKRHZLGzsmrHR4q
X-Received: by 2002:a05:690c:6513:b0:8b1:88ad:1fce with SMTP id 00721157ae682-8b5204cfb03mr879257b3.42.1795104116589;
        Thu, 19 Nov 2026 08:01:56 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52031aa4bsm623267b3.34.2026.11.19.08.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:01:56 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 19 Nov 2026 09:01:02 -0700
Subject: [PATCH v8 7/9] dmaengine: dw-axi-dmac: serialize interrupt status
 with channel reuse
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
Message-Id: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-7-f8e7fe60594c@gmail.com>
References: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-0-f8e7fe60594c@gmail.com>
In-Reply-To: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-0-f8e7fe60594c@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>, Baruch Siach <baruch@tkos.co.il>
Cc: Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev

The interrupt handler reads and acknowledges channel status before taking
the channel lock. Termination can finish and a new transfer can start
before the handler takes that lock. The saved completion or error status
then applies to the new descriptor, stopping it and completing its cookie
before its DMA transfer has finished.

Termination also leaves completion and error status pending. A subsequent
interrupt can consume that status after the channel has been reused, even
if no handler was running when the old transfer was stopped.

Read and acknowledge status under the channel lock and keep it held while
processing the event. Move locking out of the completion and error helpers
into their sole caller, and clear all channel status after a successful
stop. Status collection, descriptor ownership and channel reuse then share
the same serialization.

Initialize the virtual channels before requesting the shared IRQs so every
lock is ready before the interrupt handler can run.

Fixes: 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 31 ++++++++++++--------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 2547f9596ae6..2eeb902eaad3 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -21,6 +21,7 @@
 #include <linux/iopoll.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/kernel.h>
+#include <linux/lockdep.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_dma.h>
@@ -1072,9 +1073,8 @@ static void axi_chan_list_dump_lli(struct axi_dma_chan *chan,
 static noinline void axi_chan_handle_err(struct axi_dma_chan *chan, u32 status)
 {
 	struct virt_dma_desc *vd;
-	unsigned long flags;
 
-	spin_lock_irqsave(&chan->vc.lock, flags);
+	lockdep_assert_held(&chan->vc.lock);
 
 	axi_chan_disable(chan);
 
@@ -1083,7 +1083,7 @@ static noinline void axi_chan_handle_err(struct axi_dma_chan *chan, u32 status)
 	if (!vd) {
 		dev_err(vchan_chan_dev(&chan->vc), "BUG: %s, IRQ with no descriptors\n",
 			axi_chan_name(chan));
-		goto out;
+		return;
 	}
 	/* Remove the completed descriptor from issued list */
 	list_del(&vd->node);
@@ -1100,9 +1100,6 @@ static noinline void axi_chan_handle_err(struct axi_dma_chan *chan, u32 status)
 	chan->desc = NULL;
 	chan->cyclic_restart = false;
 	axi_chan_start_first_queued(chan);
-
-out:
-	spin_unlock_irqrestore(&chan->vc.lock, flags);
 }
 
 static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
@@ -1111,11 +1108,11 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 	struct axi_dma_hw_desc *hw_desc;
 	struct axi_dma_desc *desc;
 	struct virt_dma_desc *vd;
-	unsigned long flags;
 	u64 llp;
 	int i;
 
-	spin_lock_irqsave(&chan->vc.lock, flags);
+	lockdep_assert_held(&chan->vc.lock);
+
 	if (unlikely(axi_chan_is_hw_enable(chan))) {
 		dev_err(vchan_chan_dev(&chan->vc), "BUG: %s caught DWAXIDMAC_IRQ_DMA_TRF, but channel not idle!\n",
 			axi_chan_name(chan));
@@ -1127,7 +1124,7 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 	if (!vd) {
 		dev_err(vchan_chan_dev(&chan->vc), "BUG: %s, IRQ with no descriptors\n",
 			axi_chan_name(chan));
-		goto out;
+		return;
 	}
 
 	desc = vd_to_axi_desc(vd);
@@ -1159,9 +1156,6 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 		chan->desc = NULL;
 		axi_chan_start_first_queued(chan);
 	}
-
-out:
-	spin_unlock_irqrestore(&chan->vc.lock, flags);
 }
 
 static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
@@ -1169,6 +1163,7 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
 	struct axi_dma_chip *chip = dev_id;
 	struct dw_axi_dma *dw = chip->dw;
 	struct axi_dma_chan *chan;
+	unsigned long flags;
 
 	u32 status, i;
 
@@ -1178,6 +1173,7 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
 	/* Poll, clear and process every channel interrupt status */
 	for (i = 0; i < dw->hdata->nr_channels; i++) {
 		chan = &dw->chan[i];
+		spin_lock_irqsave(&chan->vc.lock, flags);
 		status = axi_chan_irq_read(chan);
 		/* Leave suspension status for the pause and resume paths. */
 		status &= ~DWAXIDMAC_IRQ_SUSPENDED;
@@ -1190,6 +1186,7 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
 			axi_chan_handle_err(chan, status);
 		else if (status & DWAXIDMAC_IRQ_DMA_TRF)
 			axi_chan_block_xfer_complete(chan);
+		spin_unlock_irqrestore(&chan->vc.lock, flags);
 	}
 
 	/* Re-enable interrupts */
@@ -1220,7 +1217,7 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 
 		vchan_terminate_all(&chan->vc);
 
-		axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
+		axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_ALL);
 		chan->desc = NULL;
 		chan->pause_requested = false;
 		chan->is_paused = false;
@@ -1600,10 +1597,6 @@ static int dw_probe(struct platform_device *pdev)
 	if (!dw->chan)
 		return -ENOMEM;
 
-	ret = axi_req_irqs(pdev, chip);
-	if (ret)
-		return ret;
-
 	INIT_LIST_HEAD(&dw->dma.channels);
 	for (i = 0; i < hdata->nr_channels; i++) {
 		struct axi_dma_chan *chan = &dw->chan[i];
@@ -1617,6 +1610,10 @@ static int dw_probe(struct platform_device *pdev)
 		vchan_init(&chan->vc, &dw->dma);
 	}
 
+	ret = axi_req_irqs(pdev, chip);
+	if (ret)
+		return ret;
+
 	/* Set capabilities */
 	dma_cap_set(DMA_MEMCPY, dw->dma.cap_mask);
 	dma_cap_set(DMA_SLAVE, dw->dma.cap_mask);

-- 
2.53.0

