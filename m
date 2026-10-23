Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792772855;
	b=TTSX9b/tRqp/dvQSufdTnWxVz2GXFLcnhEidU4GzDufBy0NNQffbE+aXx9jyNzup9W6u
	 +kxBLor25KXouex0QNXESxBMov3J38dULgHlyhaUYAbdwSW2AoSBOrtmLSzwIwky2y2B+
	 UbELG6vpJDbPcoemQdzlVs7W4SSxUyn2WuE3GdpY8+AmgfASBZSB9L95q5xIotOBAdMk6
	 y/Sufjo0D8QMn7d07MSs7HaGZdKFAM7dOEMw7X4gy+mnclTmhOwDMyzavgDu+Jugw4pZ1
	 Mfv5X7kmfBr1mt0rI8rCtATe/9GyGN4NC0LOdJ7SWyW/I5omwnsXp36/eg8NQ+EtzBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772855;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=LnT7ErhIPfz2XEiDMVSZAaVOI+TPOyMOC4a7RAVDPqc=;
	b=pkzVwHuQpM3n1ZVoegeL8eSdldM9EED3tVoJIekO/byJKj3CaLecAF0M+4RZ0oOBO2kF
	 q86H4JQPf6yFDwMhARbzd/I1cvw/a0HEzVMEZnNbyouJze8UQOHlBGCKab0uZPu7qegOm
	 eXidJ2dOoJQzrPUNKlRjBsnLiLofY7Fj83MaAPhj4lQCSSB/V5MjHiFNVYcu+I2TzKxu1
	 NBLpNKuTniOxB0bK1da2aiTIxdFx7ief5OPDBJW+F/geC23UI2m8RMAf6cTBUTcWAeCVY
	 nhzZgX9+JNzBE2chZtb3z5E+Lz0rMRJ8yJkjXkNZBCfoVmg1u6D8/z3sPUhWeJucuYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c6EFyH0A;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496E7606A32F
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 16:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 496E7606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c6EFyH0A
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-70b875f6f1fso635197eaf.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792772854; x=1793377654; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LnT7ErhIPfz2XEiDMVSZAaVOI+TPOyMOC4a7RAVDPqc=;
        b=c6EFyH0AR4YrAqnRW5359Qq5fVB/fFlXkFiz2Y0Y/vNq9FQTKDfW+eI/bKstwuUyXg
         r3UASbNrjuCIARXD5yucGYPkXUwzHBXTzUeinEVtRy7xBrUKcd6X1cMJ+mFnOPx6xqPN
         iy2pZG46MQesm2e6BGjtor2UyjWsZOSsRHsqviOBQ5j43uVccYephAwdlS+4GSTvu1ta
         9BEQej/XTtxRoen0I6Gdmm148jCm//hStKY+tSQPfDYL9M8F1cE3Jp06wMWc0A6A/Zmn
         F7B2SdCFX36SLw+q1Ktq7LTae6s+0bJBWTAcGnglGT6ZuyAQboJRF7TLXDHuFlLCkBoi
         nD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792772854; x=1793377654;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LnT7ErhIPfz2XEiDMVSZAaVOI+TPOyMOC4a7RAVDPqc=;
        b=Mg5k8J++LRB30aJqR5wW8hC//Qq/5Qyv6/Kx9mePtd39f+6QoMkCAU8zQOtqwy9/TT
         jNBr0rU1JZfToTLTiyWBiMBYJ4mz6YNAJbvufN4pi3uTKI08wKdWjkBHQ/gNFmwwpF0/
         97uOvo2BiuBxxkWtwCraknrX60+Lu/Ewcqpzhg/15H8v0VUpYu8L4jBB5iuExiQQEyXN
         ji+5VlSnc9vCbZUWNW0/GpzcHGyYZTu3Sqan0DGkryfLyB5dIQ/jMWIALeMAfdSOi0lK
         Pn0GEBQSjXP17hJaiJ5v1G7ZLfxc6OFY3PQVbpbIeSdpoTYWme5bAphCjbC/kiZeOCu4
         TVLw==
X-Forwarded-Encrypted: i=1; AKwUvBwnS0G8v3LXOg04CFWWwtFHBxx0FjGW3t8RXtvelmb7Vfn0Lu5wi81dItWw50Aw57taLjm03ts=@vger.kernel.org
X-Gm-Message-State: AFq9FYJg8qbob38pPVNcXHYhDVrLRZmEJcB3LUkw0x7AH2FLJ2LUYk5Q
	GsnvDY5g3fQywG72kt6xEib4PoQSYNRtjKfSnPjnsig8ri77o8ti97Q+
X-Gm-Gg: AYBFou0jXkM5ZKbYFpMiWoZlDxh//RkHqQ3kaunCve9YRs1CckX4oBF7gVDm5YQ67f5
	b0bkIBrrM0n6fzeHp+ojBaECFWlYShv5lQhNAnYXcVMuDDWCDye2TJnLs8m9m2WsEpqQJZiO3Bg
	r/s4xQju/CyVOUS6JbTKpUcPk7xDn8o2ftJLkjn75q3qNujGyHIr1+/EcyeEp7PUDWmQGDZAFDl
	atB/BOMBOYNhjte3s5Ket9nykRH7Q78nXZcsQhzX32SfbiuE1dJUOrGWrio9G8+4/q6b9EdiE8Z
	R/YfZinpgRGrXMlV6tnk/BJGAGEKVBQAvNKRf9laDENBL093uJvWB/yGpUZ/t0lNSTIYC03QbnB
	No/KbbK69DFF1386LjWzDvE/hWs2lXu9tWPpkTTdYMCWZkMo3RQamYr/u6cHJ4vM72L8UEi6f5D
	cQWxP3S4qeCdDxPM84Akv8n3wwrAmlaqmbMkTm4RpNtj5m6UkpUYn7lADnKUjvkl/RfXddaqgYq
	8rM7PwvJI60mHxzMr59DKdlkvSFmzQKogtrp2lFJjZP/ULphy4T2XIC95EYQLJqltnjq4OSu2pO
	s3W8DXLC7qF5KL/LQuCso6HCKerZ4QwHV5kGI+LV1JFMF6bjJ9UjU4lR/gpqZsUVA9ysju2Hw0Q
	qy+MlsPPsXLx2Z+VZZ7jaJhlAeiEXqSrd9zXPkvHI3ugsC2QF8XdUDfwMvpp7v85jdCeCjTqPup
	VHZ88=
X-Received: by 2002:a05:6820:440c:b0:6c2:396e:b991 with SMTP id 006d021491bc7-70b88a8ec5amr1684933eaf.61.1792772854205;
        Fri, 23 Oct 2026 09:27:34 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70b9aed3144sm372801eaf.12.2026.10.23.09.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:27:33 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 23 Oct 2026 10:27:23 -0600
Subject: [PATCH v3 2/4] dmaengine: dw: serialize error recovery with
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
Message-Id: <20261023-submit-dw-dma-synchronize-v1-v3-2-c62bf048f5ce@gmail.com>
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
index 07a5f5105787..51c5460b4670 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -408,10 +408,17 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
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
@@ -419,12 +426,7 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
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
@@ -443,6 +445,10 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 
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

