Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471790;
	b=AggGeTbAvd0kMrz/4nmqmH4qB0B5TE06AqojjwlvoRcKR9/yOzUVpBeA/3LD95d2rjkQ
	 TcDyKkUo+APXSB0GxcpMP7LiWrXMsd6VSbTwgwHeXntxqlhjyNhXohGzoOYkEQEf+gq0N
	 ig8RrL5ETtKFLvOltaRMsaf/+j+8ucf8MsF2l55Wj9Yz6kkqfaN95lVHBsjuDO/eZsKPG
	 hOrckEbSEFXaW5u1cbT2yq7QiF82JHZK6FIfN04aJnw7r++LSAZyaBdmmYtmxN8l51yUz
	 th3dWxPkFKSuexnqzMqxciBZ0l5NfhB5ELwbmJ/omDEVoRRW6B+VzLp/BTI754FoLsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471790;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=MXWQrLCbj1VbbXmwzxndXA36ZN5dlLDITfWb5Un2PIg=;
	b=qT2CgUmcxPSLnQ21ChsGRaRD6KLNl9VTsnIjhmFsJJMVyvS9ErDwJV6oXtqI2GTtgwDB
	 7FK40xLUiuFCUAWsS8XGe3Mz11EBw5AgjbLaDK/4QwoX/2vJgmY6AEOcyNkbPENRxf51z
	 wHzLMRVzU4/v1xH/a9SgGGm5RPo/VtTO/mjHaaZzTDIFUVLFxkukcXcjts+hqUZView2D
	 gvVJV0zh6pd2a1nMq3PtaJSCjhTq/sPp3C7Db3BDU+d4nOOvqbtzTKG2jOQZWjsfwlldc
	 dzqkAtHM0iWd62b5lLESJlPnLowgwbmNINOQzhtAfvPT4mrhsZMliaTczl20hwW5Tww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f7w6J55o;
	arc=none smtp.remote-ip=209.85.160.47
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CE560A261D
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00CE560A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f7w6J55o
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-48ed0b68895so2584829fac.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794471789; x=1795076589; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MXWQrLCbj1VbbXmwzxndXA36ZN5dlLDITfWb5Un2PIg=;
        b=f7w6J55oIUyTOapN6J0/hpQgPiqGiPYypBlMjLjjrQzPlC5aEi3+BeOtjnfjQRi0f3
         /F+cfXioV3bgQLRmG5NXiF08p1vDk2YeZ9HsNGMTmdmboM2oPdtZUbdQ1bi6efnd71VJ
         rUOqmqLzwBfZrx7ijmDbQoEUzBHxonCDSFJDE4MkQxye1yMcKfVUkelRGZhbOPYU6lWZ
         cq22DCcOrtjRUrBNYH3XqO2AGQMiOvw8N1c3aVSV1e9zfQHsVzWy09YUFDQXeY//US2W
         1UFMl6jDxD40AMfe+iJBtF0+/LYoOI0ZPHaAO17z415I6I0FTs7K1hbhdywQU6QAb6LD
         LDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794471789; x=1795076589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MXWQrLCbj1VbbXmwzxndXA36ZN5dlLDITfWb5Un2PIg=;
        b=BjogOqUc/9lAmpP/xDMpCIFwdE7fWRSRjYDJzNQBDK7ZD18EyML+YQVSZQu4m4C6nX
         oX5nw+fq+NdcNWR9ZVaSq4cqRwl4S7aP1+ykqhS3za9xPZTglC9ooTAtf5H4sZ/zMGRn
         28z5hr69EOrN8Me3Oa2Pa35+cJEkiWJPoLIWGtjtDKJAc+7/O7FkIN1X/0Thyb9nA0MC
         CZ9aUMu6U0gXT4ySdl3D1PJ+szPQIv0k6MM4ZuGgJ2Vom1JuK3drp50B0fHm8kp7qRHX
         DfM7BGGloovgdT5qj+zOUnbuI2zbXcvGfhcb0yFoxFknoCKYu0Rfuk1+fwa5pDcYt+T7
         iy3g==
X-Forwarded-Encrypted: i=1; AL+hErEOB3PNzP3QsjUdrGWrBKhRfWbeP6JzTd//ZtoDXxNMt87/NZ5v0D1uSh3iLUSJQLGnnKuhrxQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zgOART1KEAbGe79Pfc80rGPVwijRokJOUjf6XdSeXDDQuwQ33
	7fGiDhvzbwUvRvywcbgE8WXfbaGlJj0MAdCoa//XGvcwrJ2gpezWXrWTRenEvJ1E
X-Gm-Gg: AYBFou0goPEwXLYqWyxe686j2LZEg1GGx8mxoT5+B0DjgxQdm9X2P+0nuv9tVfR2lJ3
	UbaW+XPBEy86AcOU4eDbdUyn96vp/xiyDu1gyztkHzH24kqaRQEyiLJR/nSLWe1IfbtV9rdjiQF
	9+4ydyX2GZoyqVgxWwmjEqQqopomKRMvr/x6MyubfeYsvI9JIExp3+qK/Ch/sml+3TdmvuRF7nt
	+nFROfQ6e8uTpbh30eM73T04olxelwugKnkZG2c2mSSnSkpdQVEwbKZznlMjLb1omkGjjgmBELh
	uyTKz0XAyLOLUXnqORaaWAE7+KcEuNzu9OssopAhpZSRZ+H//ruB7Stwh2iMXjysqavS4DqCDUZ
	vM5DB5SwLIldSODXGuFjo25k/YzOrgTLY2ITjFIP+DcJ/Nw3oxHYxqaTnZIeKX01B+aGFkBa8Gy
	t/xQ4m0LfPdF3YugoI4WWq/nLzYu79QFSN8MP55B+YWgJsSmnMkZecqFkDPBGsIND+uOECvtpdA
	K1LZT0QQ4/mTtpcGspUnH1mt7femckuZWdiKDpr3V31IO/WlP9jPLb/KyKjrfwhM/DcIxswLznQ
	F5yBCFzL0WZBxIpl6yY5e5RCvzZRwkEm+pjsfIDSTMDEKBI5U/D+VbXezQBphO+gJgb7Dn1Qry0
	x2PwTwCFFGrYCVpZZUhzlxvoGpUrPstuoOdP4l8UU7ehY64pCFUjXu/NFCpxtvveIGyv4Lwi/gN
	VIRjglsETXEY4g4/HmyvMk2kUZLJ27pDfskppIkrQBrJ5UkgM7bL1LKfMSuR25v9d4qHhEVIa0
X-Received: by 2002:a05:6808:c1b0:b0:55c:928:69d1 with SMTP id 5614622812f47-56b986255c0mr4313912b6e.56.1794471788880;
        Thu, 12 Nov 2026 00:23:08 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905d3bab2sm7411157b6e.12.2026.11.12.00.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:23:08 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 12 Nov 2026 01:22:54 -0700
Subject: [PATCH v4 5/5] dmaengine: dw-axi-dmac: preserve pending pause
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
Message-Id: <20261112-submit-dw-axi-dma-stop-pause-v1-v4-5-3ebc24b243db@gmail.com>
References: <20261112-submit-dw-axi-dma-stop-pause-v1-v4-0-3ebc24b243db@gmail.com>
In-Reply-To: <20261112-submit-dw-axi-dma-stop-pause-v1-v4-0-3ebc24b243db@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

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
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  7 +-
 2 files changed, 89 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 1a53fbc951a9..70ff0c500623 100644
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
@@ -1215,16 +1240,50 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 	return 0;
 }
 
+static bool axi_chan_is_suspended(struct axi_dma_chan *chan)
+{
+	if (!axi_chan_is_hw_enable(chan)) {
+		/* A completed transfer cannot acknowledge a new suspend request. */
+		axi_chan_disable(chan);
+		return true;
+	}
+
+	return axi_chan_irq_read(chan) & DWAXIDMAC_IRQ_SUSPENDED;
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
@@ -1251,17 +1310,11 @@ static int dma_chan_pause(struct dma_chan *dchan)
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
@@ -1295,6 +1348,8 @@ static inline void axi_chan_resume(struct axi_dma_chan *chan)
 		}
 	}
 
+	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
+	chan->pause_requested = false;
 	chan->is_paused = false;
 }
 
@@ -1302,15 +1357,30 @@ static int dma_chan_resume(struct dma_chan *dchan)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
 	unsigned long flags;
+	int ret = 0;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 
-	if (chan->is_paused)
-		axi_chan_resume(chan);
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
index 3c86e5d468ea..332f9b9b9fd3 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -42,6 +42,11 @@ struct axi_dma_chan {
 	void __iomem			*chan_regs;
 	u8				id;
 	u8				hw_handshake_num;
+	/* Protected by vc.lock. */
+	bool				pause_requested:1;
+	bool				is_paused:1;
+	bool				cyclic_restart:1;
+
 	atomic_t			descs_allocated;
 
 	struct dma_pool			*desc_pool;
@@ -50,8 +55,6 @@ struct axi_dma_chan {
 	struct axi_dma_desc		*desc;
 	struct dma_slave_config		config;
 	enum dma_transfer_direction	direction;
-	/* these other elements are all protected by vc.lock */
-	bool				is_paused;
 };
 
 struct dw_axi_dma {

-- 
2.53.0

