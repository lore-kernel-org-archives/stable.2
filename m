Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792772858;
	b=gchsKWp+Gnqynw5Xz+dYro+js5oKtLQeKU9as9d3dRwayibSe6z1htQ3xfU7GKg39iHS
	 w/ShA7q7BlXVGRu0ZBTRYzyJEk1WxmQlRonWtJgb/e8imVDWtIudTNLqrKP1l5tw1rlFq
	 EBzeNT67H9aIKHkRDJLR8moZdwi+/mGE+4LaMEuu05q6F1MIFL9RvNkHNG0KPx7wR7mF7
	 iRfBwME66wgABw0nSAtBlMfI9y2TMJuiQA2R4h2o90F7YQ00Obxq9s5F93MGV6s9qfjSE
	 TIqFuzeGvmsvPe2ffV35hgY0tZpXGlSABs03qlvk5fOjB0SJCgrnMkAUF6QdV2dAfxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772858;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=NcEoJJHS6s0Ldxcf7QTPPdL5n5yIYzYW/l921a9eHYI=;
	b=yKApbB9H3pYpZadjbbllH22QnXDADX1fOrPm7hLr70YcvAg57e9+O4mcquZ5D88dmZWJ
	 RIHTg9OSxRdPTHI6IPJFqJMN+ia6Ts2If/3uff1lR5NlK4OkmJbYc/HnREERiN0ICpTY/
	 OxgAFkaTcTgsBhuBJ5O42XNVPPXQqvL93xLE9zehC7+FdIEJEGd25bo0mQrgNB7mCTmLx
	 /BfUXVbJKKp2WkkkCYUvD82Potrpp9M6UuShuLdocjlJLfq1o13Gcap9jFjHAZUWZsab/
	 34T8f2zykB3tpLkvmGhMSpl6pTZbCAbiaFY7HbcYz9Jevrk8+tlYGWhBtFY/m6UbXGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bstAkr43;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB4760A2606
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 16:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EB4760A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bstAkr43
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6de1fd5f572so535955eaf.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792772857; x=1793377657; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NcEoJJHS6s0Ldxcf7QTPPdL5n5yIYzYW/l921a9eHYI=;
        b=bstAkr43KzEfnOvQVvQpkrC8EZcMp6H2yQHgpP4YuHjnzJC+a17LoDM5bdUOUNW14R
         HMEgiATvdmlwKaaPHQqESqvPfVEEWC3ZiMmMAFGk6/Zn4oSNgmztKNNiyTt7IW/zV/O5
         Z6rMDPxCaqmVFUycbjRBX85w6Hegt/Z3CWp8SLFIs4wrlAhwK3f/uw1WRvmzsNkGFTHh
         xDNPJXpn4thBivAWoiAar5mDqWYGhYwUCC9TuD++5KpUkDGnmr7j0/t4oPdwO6olyMod
         cHDZA5MKEuAWrlB6q6F1VAPAmY5VqZiDyA83jr44FUA0obY5NInDglv2mqUQRUUqzxQp
         vtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792772857; x=1793377657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NcEoJJHS6s0Ldxcf7QTPPdL5n5yIYzYW/l921a9eHYI=;
        b=NO5BbSPUkS6mtegLIQWrWr/eMEephnmG3mm6AkS8YDkFIvmahAk/iKF/rX9TV0ftjd
         m1Ugxw5RgMevUKqdCfbG0i7J+fMKo2X6UlrVvIavf4xDDRSYl3omW6XaDaqQe4lVnbPq
         piV+sq2wOI5SP6m1YFO2/dsNYQrh32s5c9tZDFr2bWTYpci5NRzKSa0DyngsZmMilZR/
         2X+1fmiWpPMBpk2OIZCaFwHBGyMfFFwV4SL55yfhdURnPc8Vdc+GtymWvsludTqZhq3u
         YpGaZpcyW1F3mbuCX5mcbeTZZX824dyr3OOwRrFBdk1aMulvOv1Wub6nidZkdOaix3mK
         Ke1Q==
X-Forwarded-Encrypted: i=1; AKwUvBxO7hXUSTmC1FViiw3Of9M9d1dYyuZGEqy72zinGa/aJlZYtdux9IKgbeaGp1aKTkoxzb/c1IM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKY+rQZUWz+VJrLisoFd2svAkgke6vW5M63RxgntRSfJ2WogOUj
	bVOARK8muiBdFOul+19owB/rVVEXxHkRPzuDKj8IyPh1sy8j+JVxUtwo
X-Gm-Gg: AYBFou0E3ssveuObolU/DgEnWabpZ2cQYQG1fA2PUXmb7csImLb6Q/0kE9W0aGHJnsi
	gQIBNhOZhFFfEO1RlT7qSpbB8dUjszbV+6KXFGmp/61onHpwrTGb4/+UyrTSXArNt+MxLLOE1BV
	Un3kue7Tv1mv8Lp/X3+2oMDObjBnoqWVwdSh8unbLIalmHoRk6orl8N3+lLqhR6bNhVcXc57XRL
	PBR+Z0tQmm+ZwvUgyFKAKLcF0O1UacxWlWGNcHsQSx7E4BCg+MfwGkITEhAZx7xLjTYf1ufG+NI
	B8fDjj8tdB+GRj/UhzoIG0HAAIEPgFCP3mfAOtYCVAnNBQZz+cqi6WxMsvENGBSjvH2/0J4Y1W/
	JNjnoqqHWfDHbBkbSUiEj2p/DDNhZHFYkr3XlAuvTHWrAzqSkswmzma71vJLxYs271CTHleeuoo
	ioasuOw61Zb6ltRyeRd30hbj7dzI9PX7OtZOFyJz2VBlqRGTCBaSvjUV1bFvMuUKLlarpUq1Wnr
	zn9sCAY0G3hn20rQxT5GeU0PeKyiJ4tJJ1YCQKSvA05xrVrgabWRQkzJmme1CCmgAqvqtP8nxE9
	uAMRpJd8om4mdNICoa8t7YehyC300ik2PhNwkojItT12vtjhb1mbbas4yaE27qRZ6i79tCq3h/j
	pl8dxjmZPTPXegz6eHJHTNS0M1LZl9RrD4dOCQ8sn6piGTJeHc66Wn+UU/sAZRrhDRa5VXLKUSD
	Sm6As=
X-Received: by 2002:a05:6820:1621:b0:70b:8379:c170 with SMTP id 006d021491bc7-70b889b7a5emr1671116eaf.27.1792772857121;
        Fri, 23 Oct 2026 09:27:37 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70b9aed3144sm372801eaf.12.2026.10.23.09.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:27:36 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 23 Oct 2026 10:27:25 -0600
Subject: [PATCH v3 4/4] dmaengine: dw: synchronize completion callbacks
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
Message-Id: <20261023-submit-dw-dma-synchronize-v1-v3-4-c62bf048f5ce@gmail.com>
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
---
 drivers/dma/dw/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 6d27af3c0f2d..d80be93f0c49 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -910,6 +910,19 @@ static int dwc_terminate_all(struct dma_chan *chan)
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
@@ -1318,6 +1331,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	dw->dma.device_pause = dwc_pause;
 	dw->dma.device_resume = dwc_resume;
 	dw->dma.device_terminate_all = dwc_terminate_all;
+	dw->dma.device_synchronize = dwc_synchronize;
 
 	dw->dma.device_tx_status = dwc_tx_status;
 	dw->dma.device_issue_pending = dwc_issue_pending;

-- 
2.53.0

