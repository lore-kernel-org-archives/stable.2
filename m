Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648062;
	b=RM7aWaL+//ZblmUFOF+bR1lBnzj/GJ9jrAiQC3savXa0hN7xe8dFBg5WLW/SQ0seKI52
	 /0KAt+vb4oVUDg6zISi0fuDjCItSXch4rUCPXjS9KVz3wLUE7Ig14PQkbk6sVBrLup3Zv
	 pSSJ7ohK/ataUFLMaQiq3nG3FR3EgpNzG387lWkqP8pcIMp1kKS1eIhbypFdkzs1QOBtx
	 FwdgGj+B8NaNncYGytYKXVt1f/iQUN52+WGRyxjEE/NuOhtdC3YXirUVms03RFyQEMCrd
	 qTCd29l4qAOSJUr3coePLC9OlT3zZpVZR6CWfkRzzNKc832StH/kr2a84rV6tZ0QUDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
	b=VBYlDSz4XcYujmzgS/0geHZobiUdu2+5wVlVSy4LDT1Ry04Ym5+dgA9uuBJMQjrMjZWj
	 9xdk0mKF7wePSbbqgv7W9hBH4TQdz0iNG0i7QmWk9o70j2gXV0/rZWQMUdCB1OMomLca+
	 yRzr4g4AOXge5wb350zswknn3oehhT2o8VOYVDZn6dr1bXuE7cV+I+ffBzm2yd+qmNgy+
	 2w311j5nGkLNMoeL1QmaI7zI7BwJXOYPA4ymEtTLheX2Gt/llCRktcMu0pV2lLfljY1nR
	 ATeeZCufgy2AWpULhYsD1y8T+Yp7TrUySYQMTS5r+izYDLu9VEqXNjKt/vVYbpqmdRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h0yJUUbj;
	arc=none smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058B7606D815
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 19:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 058B7606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h0yJUUbj
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-53dbe9b8d6eso3058409b6e.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 11:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648061; x=1794252861; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
        b=h0yJUUbjstn8n0lPMZb2BE7TQtnBcd7AjiPCy5Za2PFXpMbWiPRPEUAR3nxKRQRIRU
         IHc7q36oNA8OzxDC9sdg9ozvovc++jE1fEuB1D9drsvaMpjc4g8kTD+Jd7BLcEWRHWti
         BoUycOYQIiQbwZOuObVYf+XY7/LC6Y7NHPIEyGdxnfsX9OxyKj6ObXEjWe1ta1/CDno8
         r+b19zNJGWoiNtz1K9MpYYDv/OcCfMQemBYW4PIY1wIdRuOXp4qx3KPvDaFPcoanTelz
         McjMRvBAg6xVWnlZ5P1d6DLDD+OW2D1GHBb6HNtggdnSLguDawyCkuVntdjtGQjbUezQ
         eayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648061; x=1794252861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
        b=uPTs/VSMTdPBuIf5/MNprjSxCXHPn6LqrMSg2v4yn6G0kHGkaxiNODieNUfV9ND9OZ
         qC+pJNfl2zjoKg8Sh0a+RuHu0/B5R90N55Z7mFmIqR4Of9bgqwSAZ9uMmV0KzmdRWeog
         /m26dcjokE/UuFnzkBfjsnQ5rK7gzdwwL2CgDbUdhfxHEyV45gCi0KuFh3l/Slp2Ms/5
         hPZ3Hy5TJpBIdl9rYqns4D6oTbZIk+zWdGj6g30n1BbIrgW35+/G06GUOESx+l7XPwr6
         7ldLhuwHjq5+ZXGiKwUbcNcSHLkh8Xhrae5sNydrpt3LZCcMHTJHey1nTH/tRpOLmquC
         bIXQ==
X-Forwarded-Encrypted: i=1; AKwUvBwJt421RVt9LfxJpmqOwiiuucmFH9/jL0qVLnRYI90UQhoB3MpfAy+HibGRj6e6Ln+NfZpwPQ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNg9eqc989YDPAvmX8SkTW2wGvlv668NxSvk+35inyzvfEbsOB
	pSkUfN+eAZWC8qlCOsPYkghKfv/SnRRQLtkqmqTG5kLmUGVVfCXmKIyt
X-Gm-Gg: AYBFou0C1OeuQaZqXVUKGvCqR872t1ix+/xti80cHwIsQ46s7AUYVpXvf0/4coIoybK
	JgZPb0safqh9i4m6oC90FWwdUOR41vnvCAzWQrL7HrzHcxu3a8JkrqE/XUoB7Rc0lRCceKU0yZe
	ednhWn4e/lPjo7e84Sc+fbJMjT1+OolnwcrqgH8GSA6ElhunzOyH22B+RCTOg/GoXkgi5LrGyrW
	dt6mSR3TMC4tXQ5MUCLZ7GeUTXa7+7i/SkAxUnMJgPuT+tGH7WWZ5Q8LNRHhW3CMmf+nGvjJgrk
	jrdZci7UpLZ4XoFQVNFq2usscxbfzwojJfOawDqsXe+lzkxs3zm9znHcAqJSItNbovn2wBIibjJ
	DofQuYdxP5vyMr0TLd4KMVHfqCuX7JwuPZGRcldZZGp4uOMM88utnkVxdAX9wLlpaAghlHpzRx6
	vy8S4afGkPrysXLEkblCBYYAX29YGNxgg8XLPmgJapuO49seKmzs1p9lo1Vz4BlAhhvwlULf+Z4
	Y3o62XF1BCoCvRndvPYS3zq/B/hipJGSq64ZH1y72CwK6ij3ve+Xa4MqMrZuzFCfkzZRzgRVZJV
	YlIlmNTb0a2GfdEZc53We/K9Bs5uNobr6bGHnzQksg7flqJ32+8FTnkyysozCuUI7EjMFb/173R
	Ac2MqmC3++EXUKbbf+CeqjdlNj7DXkppSGdBznRjnQgfmry7WZOvnZTeXyjVCHPNRym57x1ZGY7
	0zljvngE9gUwi05+YSR4oGPWAh00cHhE7WlnWkn/hAwMrLdVJ9qMt3wk+zb0KT824E0FbNrqMi
X-Received: by 2002:a05:6808:1304:b0:50d:26fc:e6d3 with SMTP id 5614622812f47-563efbee16emr7279840b6e.43.1793648060817;
        Mon, 02 Nov 2026 11:34:20 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd93451sm8558249b6e.3.2026.11.02.11.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:34:20 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 12:34:14 -0700
Subject: [PATCH v5 02/10] dmaengine: dw: serialize error recovery with
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
Message-Id: <20261102-submit-dw-dma-synchronize-v1-v5-2-d3207758fbf9@gmail.com>
References: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
In-Reply-To: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 2a9db9e39f5f..f7ca9da5af90 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -403,10 +403,17 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
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
@@ -414,12 +421,7 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
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
@@ -438,6 +440,10 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 
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

