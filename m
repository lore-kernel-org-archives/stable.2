Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104114;
	b=ftGLYmP0sdJv67kEuIPTbpA3mWdL9CKEHJvUNYgmn5ilHDtDbAmJMZJnkRpCYkneam5Y
	 Tk5fhS5UDLsF/qyIj5HAd9WagwE1x9zzwX+4xWbYx7xpuYMpPrPDNBhJ7Sdaibi4EQiem
	 +x3mCbPFcEqS2ch3Zqy2ZYOdsOgUgvUzpF0MJK9xNXy6pWsYd/e4dPeqlWuMIKQ11sKG9
	 v014N7btvFmZWrVwwwgWgZ68U/W/nz6C20fl95Qni64X4BdVC7NV5CILhnCy3G1xh8XL/
	 eIdyQx27W8t9PTOxeA1QKfd9IqjdIzugRY0Xl3X39Pkh2qejtCkcosp6/LcGMLBGBZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=ELPVGKyJPN38ost3dJadROBrjbhctV0voUbr4/8P8tY=;
	b=j1Nf10DRIWgGPYcDyTwerMdkBMos86kJSnPyDhOdd5c2fxlHggl8hbzyuThe8Ro/UEF+
	 DI+qHfOSCqFHs5JzrU8SPHRpvBSQqQjHQ2fvim7dEX1VGBtIgypOpfRem4p3ocLN3raOj
	 t0zkCDjZFdlPr9MMjht4spC+5Gm3VmbFhp7NXkTOv89C4+ZvB5vyzTGAZh9/7LzyAzFp8
	 rBYNJElOs0qIq6N24Gn4xSLjTBr/b7azGDM2AF2WVJBNmzt3MO1m68LAbVbuVU7+bqjec
	 Q2VtZk/Q++7obhmtK9UGdcxSLDlxN6vuMex7sKJKAs4kV3o0ME3HO6kGN88axTpyTBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xsyHnKod;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636D460A262C
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 636D460A262C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xsyHnKod
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b4efdc8c20so14638127b3.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795104113; x=1795708913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ELPVGKyJPN38ost3dJadROBrjbhctV0voUbr4/8P8tY=;
        b=xsyHnKodkL1XBh5fRrq6hxBMmmzsBSrGtOkHT6OkZ9QXMFx47YLNZc6YWphfVjWXfZ
         q72sCG3RNnPwoUvjkztP9V4BGUymiWgNyChvKSW5Jdu3Cyp5XbbqHOy3RGboDsV1Fx4B
         cDTrWbfVK2ATpwpWR880HgF6tB8qwaKM5o3F+rpyDOfBKTA6TUp8TEXXAA93rlryLw8s
         XyuwiVJRSwEEls8DxvabLjsQKTNkFacXFD6bPQIo++EExZp+eJPab13zoRWvVj8oZcbm
         XCaM/q1NwQHn/hV6Gf90Vdto9fX3Akcl1YV/GXV+JR32EaSfPUA92jFI0MGvArVVvbDt
         0rKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795104113; x=1795708913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ELPVGKyJPN38ost3dJadROBrjbhctV0voUbr4/8P8tY=;
        b=I7jhvepXY6OTeKsaxQjEICSJaUVM0OlMk5E8SlR0A0bQqDj6ornKfUxn4b2Rqs+zeH
         /wzkPpXe8RP33d+gW9n2ZdPHcT14RSl8vfG2it7cnH6M79QbYlWDS2Fw5sBtIQNPWodf
         p/HHpN8mo0cxOaRQhvG9lztnDq6cdTmn5ksquZaCAletRQ4PYKu3N3rrT4iCMVpDA53e
         s5pjXfmCaGeDsdIjRsouHdXDmtv8pXcxwJvcBddq09/iXz9gWacDnmvzTgDglzcbQg8A
         zoKJQEmGxzc1ifNuLV/ugFw1fRBr9UJ28D42/s8GbMoRywlbUG7msQilN3GYoOKQ2fr/
         TCPQ==
X-Forwarded-Encrypted: i=1; AL+hErEC2b2iEwVjYf2FXXDkCBGu/BSP8JNwzwpQ/goerxxab9SroaYFw4PzWicjA/xoI9E+mPMksQ0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9D2X0zyQ503MRHAfSScYjiwxnjycW6KVonYus+q6jLfXbzCO0H
	5R13d41z9NeyEuIt0I9qagbq7qQE6oMqjPkP7Et6dLdriFtoo7Uyb38d
X-Gm-Gg: AZFdTZfmJtkFxhKm9UCwySAMYqxFHDiNHPj6DFaE7jmmO11e+IMkjylNi4k/PffbCkB
	HTqE7PGeL8bsMirJ2CkBW54Tcm22agSPctQeydy28lN3H+o/5nIW5P9uQBHnvQgikF+dQ9VKPhh
	gwx0DIKMxiZntICxIL9V8mOOzPtMELJXv/s3jTB+UnuVHl9FdAL2xwoamJ0fGqJwhSmVxxHSOHT
	GCGt5aLl9xHNzdadyWahqoK2PTvg3SJt1XEXiEuHRgRoqjF1LHXIL+REwtNOCo/BTyzzkJE6KB7
	zm/Osvyo7GqPKR7kCSt9exULQXEaIAW87lA+Y4I07jEeNAS3rtX8zSaTtz6JJidztOnahkktwt/
	2A5kzAXVODiX6ut7+yYL9WYgcmOeo+dNih4HfI97reJfDiUyBL12vWhzFKPmfgfDD/ZAdwCsIz3
	HIfC5XVrU9FqwqwF6dobGzgMbKzHam90Pjp9388B40vj4dV3reJs3A4vjbcghuAuGiaESHFBLx3
	RgjqaukXHisXRpVfxQfj/z9jb4mPPX2lr36ygxs/M0t6Dk1vJv+Q19jtBw5qJso8Hf4CYEWQNFQ
	IePQQl4Fz3qWXVD4lZkXocXAImnqrY5gPLv1eTT1NETbxma9bpH40C75a7dMhUULLnxRmDLQf+v
	ngdfSKBZxP4je2rn1iI8Otv+wqxcY0f/7fkv8hJIuXIiOL+5+3Csscke4X5lzAMe2dXHcZXqe5u
	FikN+wifgK9fR0kVLU4PsXErnVPevvJ33kcZ4PA4wo1ab6PHNJJz0=
X-Received: by 2002:a05:690c:6381:b0:8ad:bc2e:aad1 with SMTP id 00721157ae682-8b52042e7b9mr753327b3.17.1795104113164;
        Thu, 19 Nov 2026 08:01:53 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52031aa4bsm623267b3.34.2026.11.19.08.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:01:52 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 19 Nov 2026 09:01:00 -0700
Subject: [PATCH v8 5/9] dmaengine: dw-axi-dmac: preserve pending pause
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
Message-Id: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-5-f8e7fe60594c@gmail.com>
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

