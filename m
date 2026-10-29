Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312996;
	b=TJxBGq24AZyjaWKV+erEVCs3Bcvt8Tu5QVTDlfR2s7Sz+ZangWGKZf10fTYOnzURe82m
	 IR77OmqwcIkrjrefhJNoXoDdERFZ+mhnlx9h5l7LpReTay86SZJv2ur69cuHyludMIsp8
	 QhWf91UBBDZB2ou5pbhUfl+U3rtbELC1U60Z/H0Rku0TQH0b+O5joBk4r0juddyr1JoNz
	 90rMEu/nCwhyGkI6RlCEqgsSoNx7FDkc01HAblBQSiCYYCGYRPe3Z6RvfQRdVjspXbKJN
	 +P/v1bu1hzWfnlhmNSPDQfIcByopjQZRlgeZk6GG7Rsca4EUEkylPn8o8lJus4d5svg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=wkIhisdDZBkDpi2Ngf0GdoFEgXXogA5sytIiQ5NQ4z8=;
	b=hSBXTyroVehF7bNzjIo77ue+l8zOpsjv1Gz/bvrtVLqZWmeORVXH2yyLdSvOvBol8D0R
	 0HFBkelznASzqItAcs08uFynIteJozLDFX28pdKH4RpZM27mXJI6nzI6A+7D9fNRUn18U
	 pd3ZN3CHILRjupSODV8hLpHszdX9ssuGsQBEAgUoXaFptnrBEF9liWIQPIaTv3MMw4CZ7
	 oztLjLzo6wd90yTJ71fVzk+TQ2FWUwJuBtCvQJV8aMAmpmrgBibk5onLcT1UGOumhwdUw
	 35oRYN0zk+6+w7o/jj9umMvaM0TIwab1O10sBp6ZXaPFOFsQQNV1XPMzHePqnIb3ZHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RNR9Efno;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2313606A31E
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 22:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2313606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RNR9Efno
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-823e4047037so104392a34.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793312995; x=1793917795; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wkIhisdDZBkDpi2Ngf0GdoFEgXXogA5sytIiQ5NQ4z8=;
        b=RNR9Efnolrr+Tv9pm9QqjboB94rb3QbKuu+iJXO4ui75czgSEYX97arGLUAsN9mwo2
         B50CHn1wvxCqxQCsXAFdR+7ydwiXXqH0SYNxsKZp6tGp+lzWZBCuGO7d6NaT6SWqAah/
         4oh5JKgWkM6Mn4xhGHrO/636qy3uWRezfa2BPyUK2oVVonW2O/EQe5p0bOJ0CI9J0n9B
         uKvmM+L6elc+Qm+WjsLg58z2wgo/+S2tZiMvIJAPe+Dgz8dWV8WyL/smx5HUOKvydH3w
         lowo1cfPCa8eR5h8J4jeIoEziEYkFV7djX03DDN1ASjBCGAAarILZr7aTW+aQ25QklH9
         dMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793312995; x=1793917795;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wkIhisdDZBkDpi2Ngf0GdoFEgXXogA5sytIiQ5NQ4z8=;
        b=ghjgIXSJXwmvFWi4AxYvEhFyRUGTYvS/GDha5umnkqcy4bskA9gMNyhGErJaUxbPI7
         Ld+v/5oOoKAQ7wFpoMvWPbEqSWMih68JXtrCKRf6IUpJ+ZPQbccb5aGp/pNcBwZwbQwp
         7s+weqeac9B0+SCLH3mCa6QtkLsasS+uPX8ioBQtKP7pb2idHYGycuwP0sFcnaIIuR58
         MVFi9qfZOxnMxU6eEz2ZaC6AoW0guKO1AAkeL9J0MGna9oCP8rRusWhK7ze2I6O8Iiap
         aUPQcz518Ka0qc4h3cS94ieKqzUfCzWY+5Lgx+QCGO5Rh0fk6tzgSP1zMnJd6f93J313
         45AA==
X-Forwarded-Encrypted: i=1; AKwUvBwbHSghpgSjCSh3CMcOTLGhjswIoNYB0oCJomLwZoU68+ReCPTOGAHhwOwb73UlNITLXJEidMM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNizajQD3YfJv22m0PbwGvXRgiPtm1586LSxuUYESbHiRmbvhy
	B2g/8E/XWTmcV1WOipdJxGZ/vpPTK+VHoF9wUhgfJzCSqzhXoyaWT7CV
X-Gm-Gg: AYBFou0ubnZ+o37ZjLMSMY7oMbbgksqOffFrrrr42qz3TNK2SeVDyIYbNhBXynsd64W
	LpSFtBUha7quimTKBYXRvEp/K/hq8tucWhsS66kGbnnq33Ng7saOBisG5ed6uKuVgjpsrYU14Ck
	GG76irBsvwtMX0rFSwNSOGJU4N7lJyhxErgtUNjZGsRN07+0ycluSGzLGEi3flsFcqP6gR8k5cY
	ClVTXCy8PTPk7tUPIyWKMkyre71jbqzKSESkvQu94O/amTjCmEuUlJ4i59JTTKiEMN3hFroeVTy
	j7XtflEchScSwhGB4DgBbw+ZwCRq+BUWQ36zJbnuYgm7ig3pvfe8wiMFD7RPZRW8Lvt9A5vRtEe
	78p2xayQbai8jfXCeGnW7A0wE0idajXum0OdE/pxxepG/DgouPoN1FnUNbejZ+XlcrSMA7xc/r1
	CcFmJe4cFYuZSzQZYPCmBC+WoE3d5A5izfqrmJy2GcarVK3VCDvQyjciB5jidkCaV+W4f58BPKv
	Iby4hHA47f3LOOejOyvB/TN67vYpG4xrqd9qo8US/O3IaEKCT7wV/JWcUxSAEmG/1aDNHBo7wBz
	p/yeQJ2S44czxwNXEwZSt+halnuPcdssTIj6DysI9KjxAkDiTWFOOS0GX//UhE1DysOL29mQQmP
	nehhK+mlHmBxnLXWi3IGZc1s7BpAYjDvGiF4/vEKbG2ukp7QQXtSOpSm2e7NijXOrR5/OVyMd1v
	8pVnprDJJavMZFzs2WurRbQuTM1kfdY34iMdkyKzjBs91qY8K6q4Om
X-Received: by 2002:a05:6808:1383:b0:4e7:3fd7:2752 with SMTP id 5614622812f47-5640e02af93mr409218b6e.54.1793312994747;
        Thu, 29 Oct 2026 15:29:54 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fc49880sm236130b6e.2.2026.10.29.15.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:29:54 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 16:29:40 -0600
Subject: [PATCH v4 6/7] dmaengine: dw: synchronize completion callbacks
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
Message-Id: <20261029-submit-dw-dma-synchronize-v1-v4-6-fea447d9f285@gmail.com>
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
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2

The controller tasklet can detach completed descriptors and invoke their
callbacks outside the channel lock. Terminating the channel does not wait
for those callbacks, and there is no device_synchronize hook. A client can
therefore reuse callback state or release its buffers after
dmaengine_synchronize() while an old callback still uses them.

Disable and re-enable the controller tasklet from device_synchronize,
outside the channel lock. Disabling waits for an executing tasklet,
including descriptors it already removed from the channel lists. After
termination, a later tasklet run cannot acquire another descriptor from
the terminated channel. Clients must continue to exclude new submissions
on that channel until synchronization finishes.

The tasklet is shared, so other channels may schedule it while this wait
is in progress. Preserve those pending runs: tasklet_kill() temporarily
owns the scheduling bit and can consume a concurrent scheduling request,
leaving controller interrupts masked. The disable/enable pair leaves the
scheduling bit and pending tasklet queue intact. Other channels' hardware
transfers continue, though their callbacks may be briefly deferred.

Fixes: b36f09c3c441 ("dmaengine: Add transfer termination synchronization support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-180707@kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 3bda85adbeee..66065d7b26ae 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -902,6 +902,19 @@ static int dwc_terminate_all(struct dma_chan *chan)
 	return 0;
 }
 
+static void dwc_synchronize(struct dma_chan *chan)
+{
+	struct dw_dma *dw = to_dw_dma(chan->device);
+
+	/*
+	 * Termination removes the channel's descriptors from the lists, but a
+	 * running tasklet may still own a completed descriptor and its callback.
+	 * Wait for that run without losing schedules from the other channels.
+	 */
+	tasklet_disable(&dw->tasklet);
+	tasklet_enable(&dw->tasklet);
+}
+
 static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
 {
 	struct dw_desc *desc;
@@ -1295,6 +1308,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	dw->dma.device_pause = dwc_pause;
 	dw->dma.device_resume = dwc_resume;
 	dw->dma.device_terminate_all = dwc_terminate_all;
+	dw->dma.device_synchronize = dwc_synchronize;
 
 	dw->dma.device_tx_status = dwc_tx_status;
 	dw->dma.device_issue_pending = dwc_issue_pending;

-- 
2.53.0

