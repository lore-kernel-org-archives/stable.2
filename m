Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695175;
	b=oQU1kFyYB4jwsX60krjFa89VkHNlOhROP+lPr0BRwpWz9mBY6o3vT9OCU8ErTfZyg1nw
	 xqoK4KsvsIEuQpdpav8zoopFWI2C7hjoV7i5lyTXT/dKYTBLGKtVSmLJSMQQwlrUV12ET
	 /EL3koNNqLqU2TN0a44VNdsJuldrpIZkM7NmaBgrYO9EqVnjhsKo4x2Tw1G2/JwEb6GWq
	 P32BGuvkhDrrEPOYeJXvisQ5x08z+KnyR7p2x/3s7BDDbfLaQ3C0i4SqAsQ+eNvKobAO0
	 sgrB1nQRvWWzTN0xlkQyFk4Oz12N0c0O3HDHNp+kLpglma/LuyrxIxwSZWxhOe8juIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=KbJm5SGXsdECTH4ZZRdz2rXhZWT5LUE28XcGXGMl8J0=;
	b=RbP1n1eNJDlRKZnnxL1nMlmJsK7wm+EVtnvUwwR3tKRhDwr1INVjLwsKtCAM/V3mBGZZ
	 vEZZcDPryoXPoa1LtMyXLj8wTgy7BndN5PElgY4Lw8h1GJZx41CVxAuwFbtAd9if+LpQ2
	 Xw5vi/O9UUWt6GEofJnhWsa9hxLo4LOl0RY4Zie54ENHmXhAwbnyoff2ssa8b++ZEwqOP
	 hRHvy8XD9Jzp0MXcUljLpGnnrk3uw8jtC7anvGv5gNwXb9MtGaMcsihlxE1oqwdrNr+07
	 y6k9dwfbCFuDS62+9Vszmtwohorv1Z3oeFVe8aoV2DK/CiFKTR8bWfpzWOy5W/Sz5Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LHfk67pa;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6832560A260F
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 18:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6832560A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LHfk67pa
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-8256106635eso45338a34.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 11:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792695173; x=1793299973; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KbJm5SGXsdECTH4ZZRdz2rXhZWT5LUE28XcGXGMl8J0=;
        b=LHfk67paldhYAuv9kaDjn79xOy88fVU3TrAO/kbwW0obhlMHE6xLXBCW5C4DA1VdB2
         Iw3znsq3xbanboqW47ChizQwQ1P+jW+7oqaxabGNJsORuLtagLQje/CiEjdwKYyACitU
         2qWZ640MRg0bZvZfhRlqiE1LD7CyusNqHWQt/SXf9Bvx2hYW074YifX4NxL/lfHHWIfw
         j0QrmROhLNGxriITCFflR1/JLkvCptktrFO8569G19CO/0Lec2O9r+jampJ1pP5YSGnn
         vFFigWaIXQmYMs4E/L7/TTU3FyklrXgYlounseFxb8HLmpOhVynKXXELqrYg3y/9HjH4
         4zKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792695173; x=1793299973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KbJm5SGXsdECTH4ZZRdz2rXhZWT5LUE28XcGXGMl8J0=;
        b=yZITQYsKqAgGqsLE8uByGXIsduw5mcWmqZTQLsyDhmk/0whrJsTi4ByZwcwgNq1Om8
         sKahALWTouLH5l+inaN2L7pTFoyLyncDQCMEeZG/rzyulS+RznbxuM8A4g0s8veVgBTs
         18zPuTJRSQxIvDeQ5xK/5Zro5IDALwOuryvhbyDaNx5FkPb9CHEgRt7334JtrKQAn6JB
         QIu13WGBT9onn1DF5gYbe5Cbap4Xmy4Tyx84yBFfDBzYvMP3tqG08L7MIW1uXb9PT7C7
         DEkeLppZX2+taHLmgWkYNT8YIxknfnKrn5VYreXaDdZWBNg/H2UJcXCiaX/cfzVdeiZ+
         LoBA==
X-Forwarded-Encrypted: i=1; AKwUvByAs05bKVtR9anC8UewxzULOxyAn21lG427Yz2ZW3nqLeSwe6kogsGlGt8qfZei7thLyZczfIM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIzi92nK3wqIIMmI8dPBJR98Voxya6fyVKhxmnAZqcgqMwcv2m4
	FohUWPYFI7UePzvwjbxkzZ2hoged3fTaqKoTeHgL0Nj0Lk2N4YZEqJsF
X-Gm-Gg: AYBFou2zz171xchw9pPJJlCn6G/1+KojnaEuU3saYvbVetT5Zra9ObGfwm69N+7gwhP
	V6LUq3WsrA17kvTyERDe1zw5petfb+gqJEZjWCR7trcbV9RcbDMdfi36tgE2/dBNyIYI8R945+E
	MJnJ88dvZoqlDIz7jZv4NLxipF2w5/yQM6MZ8cK0Eu5w45/pkLvfBsHbP0apRBeaFkVuNqt2xdq
	ynQAqs9cCRIAzAoU/HkZSnSBJ05ZiPU/Q47HF4VtCTA3zzQzAmq5kVI+XqgU4gsnreXJ923rrYG
	5nOZRuucrOj8gEa90tI4fDH2iiesLnLs7E7qjG5ZuDP4EYqRKs1ZT7SeF02jdcXf9f48gg28qRB
	SRC/43aD/RpUZ24lDN/AJwX6GvpYF48TT+sijjd5iqUBoiT+uRH38LNqkI2smwebpVs4tCH01kF
	CfZ8vHee+xUr9vI4eCN7ssGi6jpQooR4+rKX2jsjayKJS85oTCV2R9tjTZX5M7hMInll/EigW+7
	4v2ZcE9TN6TAK9MA8QPw3creuwoUtE9W5MiQ+C9cqjG1KUN3cabrMRhIGSWFo5WmHgm6Pxpj4Zz
	/l1ln52yPdR3kl0/mSipUHCnN4ky802XbxPcb+lYMlWwqXsmRSZb96gmgE4QMLxJ4uLIrkeRCzt
	+Sd8VXtGQkrqCJU/RueKlimH3HVVrl/rYIZspHmUPSxb4lIQHQ7V517D619PzusfRMqWkJTu8//
	4Qb5s=
X-Received: by 2002:a05:6830:82ae:b0:804:d4b0:a36 with SMTP id 46e09a7af769-84d08f1169amr5063899a34.27.1792695173289;
        Thu, 22 Oct 2026 11:52:53 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84f7703d288sm536083a34.4.2026.10.22.11.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:52:52 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 22 Oct 2026 12:52:50 -0600
Subject: [PATCH v2 3/4] dmaengine: dw: serialize error recovery with
 channel termination
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
Message-Id: <20261022-submit-dw-dma-synchronize-v1-v2-3-5244e94dca8c@gmail.com>
References: <20261022-submit-dw-dma-synchronize-v1-v2-0-5244e94dca8c@gmail.com>
In-Reply-To: <20261022-submit-dw-dma-synchronize-v1-v2-0-5244e94dca8c@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

The tasklet samples RAW.ERROR before taking the channel lock. A
concurrent termination can empty the active list before dwc_handle_error()
uses that cached error to select a descriptor. The list head is then
interpreted as a descriptor. Even with an active descriptor, moving
queue.next unconditionally can put an empty queue's head on the active
list and pass it to dwc_dostart().

Recheck the error status under the channel lock and stop the channel
before selecting its failed descriptor. Only one transaction is issued
at a time, so take that descriptor directly instead of scanning for
completions first. The scan can otherwise complete it and start queued
work before the error handler has identified the failed transaction.

Detach the failed descriptor under the same lock and use the queued-start
helper, which leaves an empty queue alone. Clear the software-LLP flag
before restarting so a failed multiblock transfer does not prevent the
next transaction from starting. Keep the completion callback outside the
lock, with the detached descriptor owned by the tasklet.

Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Fixes: f336e42f73d9 ("dw_dmac: Move single descriptor from dwc->queue to dwc->active_list in dwc_complete_all")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index fbc46cbfe259..1df028970c4a 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -395,10 +395,17 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	struct dw_desc *child;
 	unsigned long flags;
 
-	dwc_scan_descriptors(dw, dwc);
-
 	spin_lock_irqsave(&dwc->lock, flags);
 
+	/* Termination may have cleared the error since the tasklet sampled it. */
+	if (!(dma_readl(dw, RAW.ERROR) & dwc->mask))
+		goto unlock;
+
+	dwc_chan_disable(dw, dwc);
+	clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
+	if (list_empty(&dwc->active_list))
+		goto unlock;
+
 	/*
 	 * The descriptor currently at the head of the active list is
 	 * borked. Since we don't have any way to report errors, we'll
@@ -406,12 +413,7 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	 */
 	bad_desc = dwc_first_active(dwc);
 	list_del_init(&bad_desc->desc_node);
-	list_move(dwc->queue.next, dwc->active_list.prev);
-
-	/* Clear the error flag and try to restart the controller */
-	dma_writel(dw, CLEAR.ERROR, dwc->mask);
-	if (!list_empty(&dwc->active_list))
-		dwc_dostart(dwc, dwc_first_active(dwc));
+	dwc_dostart_first_queued(dwc);
 
 	/*
 	 * WARN may seem harsh, but since this only happens
@@ -430,6 +432,10 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 
 	/* Pretend the descriptor completed successfully */
 	dwc_descriptor_complete(dwc, bad_desc, true);
+	return;
+
+unlock:
+	spin_unlock_irqrestore(&dwc->lock, flags);
 }
 
 static void dw_dma_tasklet(struct tasklet_struct *t)

-- 
2.53.0

