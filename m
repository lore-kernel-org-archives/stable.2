Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808884;
	b=kTfvBy8nD9VvHI+ZUs23R69Vozi3nxV1wVMglhhpdZ0M9DV7Iyg7zq1s43+jNLMbm7xu
	 FWt/sYbFwU7cUWlZfkaDa+iLDc/m/g2hFMcvtSgoMbMR6YW8cC93j9K1nhdOmLAxB5oBc
	 d4Ty26CtZwKsiwDPWFW9RkcBwn9inPfGiP3U02MsfzJ7KoWyaIClfYnZ/bfIE4dRWjUJK
	 lkFkUd9efEzkbnNqPg6fVqeg1YutAHuUO9BUsCuL65OvQih2AM0ydH/TzYnIzNw1fCBdB
	 coTNcDtssn3k8srZUa/oVRL0d5AGWiPsj6i/XtCa7w/eTx6JTYplRsTGkwXlRPtC3pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=xD7v+KKjqUXGmD+jDRuPUvviwA8dBJ4NF/bEGvBPM4E=;
	b=J0xCHmAIMhwPU4kFFx1xCDNCX0RpBwYwz+KuwBWrc0L95LD4wzE5GpHAr7DLP/+qn9GF
	 //UNm2T67FdXf3dmRuolbiLDA4kKa56aD0ziDx8yK0XgQ7VL0onN47zUIOgkp8k/JOJJx
	 ckGZDpi/u/T2dMT5lTmoPHbQ1IaS8YmnK6S4/I19WU7TP+s92rRu5kzUi1kMQB3XJ42bc
	 Ue9nn+MsAtnbNpIjeveMbXUe9bp0QTZOIj6E2kCly5df6o+GTRNE2UfOlF6wjFFgEYjIQ
	 5Pp7fy6bj93AgRKxjZDELTJeurTGrjV/3uJXYrLaqtA4+GNr316kcZr98LOib3lgUeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HPD23fxM;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471A1606A88F
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 06:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 471A1606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HPD23fxM
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-847ac7ccd85so2524754a34.3
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 22:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794808883; x=1795413683; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xD7v+KKjqUXGmD+jDRuPUvviwA8dBJ4NF/bEGvBPM4E=;
        b=HPD23fxMwC8vBD3CvIILTNiEqkjaQbqYSYW8mJ4ekGqjZOophkemcr0fnqmfUUJjX7
         /yqHdnj3sAlZimQbFFRDtSunyQZQ00J65tXc85d1Of5FUUp3XW7z7vLZGs3yRa46LHQh
         zGh97KrDm5jPVGRJhA8hmNIqH1iPFi3HXLTUaDFVpcinObE4B2fvU8AVm7BLLZUZDOi7
         BoAGM7dgjNHr7Iw2hjnoGzSgyOYn8YQ8/5pY2mo+00BohKImaWGDfjQuIm+NmMxcas7f
         TKxw9/dWDzPwXGS7xHgmYBWzJ9u6JjSfcDTvZjghV3TgvH2l2Fz9oJbRbBTYbY560mbT
         fzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794808883; x=1795413683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xD7v+KKjqUXGmD+jDRuPUvviwA8dBJ4NF/bEGvBPM4E=;
        b=FLsNfvZTrsFNsne8n8aQ0ZKqpKrmBriYbhJD44tsRNWiS/lK1NpCLcvdoclHxZyQv+
         bT1IK+5W6GY1v+H738PzlqkS/ZKKEN1xmVjeTYdRy6zspCe4Nqi4wRylMaTUPy8RmxR7
         PPXm7Wo9lBmEqNT/JlEue2gZEL0ZJ+rqhTM3MLjtl1rOX4rqcrWPwGC1nbkzHRDPtrpk
         xUdks3+XHZSwFgVnCdo184jiZpDKqNrBsiTWxBxS7PsDNoUUohE1BqEqoC4aZrXPRHXL
         dEZlnUZsqvgxT+VE8M1TCC7gJA+SfM2HM2OEhuhHoxaP+BoFOj95l3cR2YLJdfV0DXdv
         UPvg==
X-Forwarded-Encrypted: i=1; AL+hErGZeRyUi17Jg8R2Sm5qj4kpbyCL+GyuvnpUkUzjOEAWec/60YD/YD79s85VxOE+tMThjzbqdBg=@vger.kernel.org
X-Gm-Message-State: APuU4Z82dgr4mZespbqygndUT8WO6Ol9T0aon9nIaLi8Va18xJ4UE0UW
	c5sZmHYfSIH8K58NJEv5PMCDINl3ULr8dL0Cnby0cT2gW7nz3g1eIrVd
X-Gm-Gg: AYBFou0lDEhnvaxMaC02ep6kqAr70Gr7+PHlwP+HtZXeS1uJPIPkuvwRz3a2ezT9a24
	D0IfbzU29H/SbQIN4ia6sTMqgIO0LFj393jAO4KdE5zJFPfAD4thHqxzx2FeHhJK45bodWFZ/aK
	Tgq0KeOdx0OfKiKTuOpTYCwShFSFo+JkP43QFx1bbrYgTlLlG2OvZuhyxD1Bo/q/0KfKzUQnOqM
	dnfbcAwau5oxIriAKX6KLks2QrQtzpzUaBTkLAcuj2Nq+m9qyiuoAVR4gxO+R8TYex9FeNq7eK6
	DaEpr8IgTKX9f0cui7YOhq5rJlqVMbUq7PT8zZA/8cAlsazX/RFdbpCWzZW/BxQvN2Zr/d5itm7
	3PDAnwrC8WyreS2QZwepXserUnmkt7AeHrAwNy1/Z3RDY5o6a+BYUK/YpcvBr2JP0rdu/u+Ll+M
	Na75ACC/plpqMRpLXPnK8UUVRPt0e7H7mtL8rjO5o2ct9Yo05MDubTIMAvQxiaSOMtw2Z8imkt2
	6YCrRsqqi+qdGXDRf8PZC8vDdSo9AryoYJ4SqVIdFF4ShAgIBZo16bpjSs9Az9FqsUGcsSUlUpf
	gcLQPKCCM9iiCvS8CAeBXyiSVFFAtCGGi+uWs3BYbgL6M+5DYpryorrjHErbSW8n1gx0mk2jT1y
	NKRAdtBjNBcIZKS3K8I35a7cL5TKqgPUXDbO06t3oo2SSkemzwssFVTe3Bzo1wmxp04YfmaXm25
	uCUCU0JvergLrr5aajUTtSuwrsOU5IEOnGSDhdU/4lA756jtgBZOM=
X-Received: by 2002:a05:6830:3e05:b0:862:b918:2019 with SMTP id 46e09a7af769-862b91822e2mr3339375a34.29.1794808883265;
        Sun, 15 Nov 2026 22:01:23 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862881a965esm9375160a34.25.2026.11.15.22.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 22:01:22 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 15 Nov 2026 23:00:46 -0700
Subject: [PATCH v6 5/7] dmaengine: dw-axi-dmac: preserve pending pause
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
Message-Id: <20261115-submit-dw-axi-dma-stop-pause-v1-v6-5-bcb23d1e7029@gmail.com>
References: <20261115-submit-dw-axi-dma-stop-pause-v1-v6-0-bcb23d1e7029@gmail.com>
In-Reply-To: <20261115-submit-dw-axi-dma-stop-pause-v1-v6-0-bcb23d1e7029@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>
Cc: Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev

dma_chan_pause() clears SUSPENDED even when polling times out. Hardware
can set that status after the last poll, and the unconditional clear then
discards an acknowledgment the caller never observed. Another channel's
interrupt can also consume the status because the shared IRQ handler
clears every channel's status before taking its lock.

Leave SUSPENDED to the pause and resume paths. Track the suspend request
separately from its acknowledgment so a timeout can be followed by either
a pause retry or a resume. Wait for acknowledgment before clearing the
hardware request, since hardware ignores an earlier clear. If that wait
also times out, return -EAGAIN with the request still pending.

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
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 98 ++++++++++++++++++++++----
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  8 ++-
 2 files changed, 90 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 1a53fbc951a9..cd9a5b45d295 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -481,6 +481,8 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 	irq_mask |= DWAXIDMAC_IRQ_SUSPENDED;
 	axi_chan_irq_set(chan, irq_mask);
 
+	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
+	chan->desc = first;
 	axi_chan_enable(chan);
 }
 
@@ -489,6 +491,9 @@ static void axi_chan_start_first_queued(struct axi_dma_chan *chan)
 	struct axi_dma_desc *desc;
 	struct virt_dma_desc *vd;
 
+	if (chan->desc || chan->pause_requested)
+		return;
+
 	vd = vchan_next_desc(&chan->vc);
 	if (!vd)
 		return;
@@ -543,6 +548,10 @@ static int dma_chan_alloc_chan_resources(struct dma_chan *dchan)
 		pm_runtime_put(chan->chip->dev);
 		return -ENOMEM;
 	}
+	chan->desc = NULL;
+	chan->pause_requested = false;
+	chan->is_paused = false;
+	chan->cyclic_restart = false;
 	dev_vdbg(dmaengine_chan_dev(dchan), "%s: allocating\n", axi_chan_name(chan));
 
 	return 0;
@@ -1087,6 +1096,8 @@ static noinline void axi_chan_handle_err(struct axi_dma_chan *chan, u32 status)
 	vchan_cookie_complete(vd);
 
 	/* Try to restart the controller */
+	chan->desc = NULL;
+	chan->cyclic_restart = false;
 	axi_chan_start_first_queued(chan);
 
 out:
@@ -1134,11 +1145,18 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
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
@@ -1160,6 +1178,8 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
 	for (i = 0; i < dw->hdata->nr_channels; i++) {
 		chan = &dw->chan[i];
 		status = axi_chan_irq_read(chan);
+		/* Leave suspension status for the pause and resume paths. */
+		status &= ~DWAXIDMAC_IRQ_SUSPENDED;
 		axi_chan_irq_clear(chan, status);
 
 		dev_vdbg(chip->dev, "%s %u IRQ status: 0x%08x\n",
@@ -1206,6 +1226,11 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 
 	vchan_get_all_descriptors(&chan->vc, &head);
 
+	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
+	chan->desc = NULL;
+	chan->pause_requested = false;
+	chan->is_paused = false;
+	chan->cyclic_restart = false;
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
 	vchan_dma_desc_free_list(&chan->vc, &head);
@@ -1215,16 +1240,49 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
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
+	ret = readx_poll_timeout_atomic(axi_chan_is_suspended, chan,
+					suspended, suspended, 2, 40);
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
@@ -1251,17 +1309,11 @@ static int dma_chan_pause(struct dma_chan *dchan)
 		}
 	}
 
-	ret = readx_poll_timeout_atomic(axi_chan_irq_read, chan,
-					status, status & DWAXIDMAC_IRQ_SUSPENDED,
-					2, 40);
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
@@ -1295,6 +1347,8 @@ static inline void axi_chan_resume(struct axi_dma_chan *chan)
 		}
 	}
 
+	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
+	chan->pause_requested = false;
 	chan->is_paused = false;
 }
 
@@ -1302,15 +1356,31 @@ static int dma_chan_resume(struct dma_chan *dchan)
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

